#!/usr/bin/env python3
import pyshark
import sys
import glob
import importlib
import os
import re
import shutil

from logwriter.plugins import *

class LogWrite(object):
    def __init__(self, pcap_file, output_dir, force_mkdir=False):
        self.layer_that_do_not_match_plugin = 0
        self.pcap_file = pcap_file
        self.output_dir = output_dir
        self.has_error = False
        
        try:
            os.makedirs(self.output_dir)
        except FileExistsError:
            if force_mkdir:
                shutil.rmtree(self.output_dir)
                os.makedirs(self.output_dir)
            else:
                print("Error: Cannot make directory %s: Directory already exists!" % self.output_dir)
                self.has_error = True
                return
        except:
            print("Error: Cannot make directory %s" % self.output_dir)
            self.has_error = True
            return

        # self.loaded_plugins = self.load_plugins(os.path.join(os.path.dirname(__file__), "logwriter", "plugins"), self.output_dir)
        self.loaded_plugins = self.load_plugins(os.path.join("logwriter", "plugins"), self.output_dir)
        print("Loaded %d plugins" % len(self.loaded_plugins))
        
        self.plugins_by_layer = {}
        for p in self.loaded_plugins:
            try:
                self.plugins_by_layer[self.loaded_plugins[p].active_layer].append(p)
            except KeyError:
                self.plugins_by_layer[self.loaded_plugins[p].active_layer] = []
                self.plugins_by_layer[self.loaded_plugins[p].active_layer].append(p)            

        print(self.plugins_by_layer)
                
    def load_plugins(self, plugins_dir, outpath):
        plugins_dir += os.sep
        loaded_plugins = {}
        plugins = glob.glob(plugins_dir + "*.py")
        plugins = [x for x in plugins if not x.endswith("__init__.py")]
        for modfile in plugins:
            plugin_name = os.path.basename(modfile)[:-3]
            import_plugin = modfile.replace("/",".")[:-3]
            module = importlib.import_module(import_plugin)
            loaded_plugins[plugin_name] = module.LogPlugin(outpath)
        # print(str(loaded_plugins))
        return loaded_plugins

    def process(self):
        cap = pyshark.FileCapture(self.pcap_file)
        #cap.set_debug()

        pktid=0
        for pkt in cap:
            # Controller from pcraft, to call plugins such as EDR
            # When PCAP is not enough...
            # This is cheating, we make sure our pcap has ip source and destination of 10.10.10.10 and port source and destination of 666
            # Then, we get the plugin in the URI and the data from the User Agent field.
            # TODO: Must be fixed by using pcap-ng ASAP
            # print(pkt)
            if hasattr(pkt, 'http'):
                # print("This packet is http")
                if pkt.tcp.dstport == "666" and pkt.tcp.srcport == "666" and pkt.ip.src == "10.10.10.10" and pkt.ip.dst == "10.10.10.10":
                    # print("This is a controller packet")
                    # The plugin name comes from the URI
                    plugin = pkt.http.request_uri[1:].lower()
                    # The key=values comes from the User Agent
                    keysvalues = pkt.http.get_field_value('user_agent')
                    kvdict = dict(re.findall(r"(\S+)=('''.*?'''|\S+)", keysvalues))
                    for k,v in kvdict.items():
                        kvdict[k] = v.strip("'")

                    self.loaded_plugins[plugin].validate_keys(kvdict)
                        
                    self.loaded_plugins[plugin].run(cap, pkt, pktid, kvdict)
                    continue
                
            for layer in pkt.layers:            
                layer_name = layer.layer_name
                try:
                    for p in self.plugins_by_layer[layer_name]:
    #                    try:
                        self.loaded_plugins[p].run(cap, pkt, pktid, layer)
                        # except:
                        #     print("x", end="")
                except KeyError:
                    self.layer_that_do_not_match_plugin += 1
    
        print("Layers that did not match a plugin: %d" % self.layer_that_do_not_match_plugin)

    
if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Syntax: %s pcap_file output_dir" % sys.argv[0])
        sys.exit(1)

    writer = LogWrite(sys.argv[1], sys.argv[2], "-f" in sys.argv)
    if writer.has_error:
        print("Error. Exiting.")
        sys.exit(1)
        
    writer.process()
    
