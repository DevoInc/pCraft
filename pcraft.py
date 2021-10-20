#!/usr/bin/env python3
import sys
import os
import pprint
import subprocess
import io
import base64
import time
import shutil
import pyshark
import json

import pyami
import pycapng

from pcraft.PackageManager import PackageManager
from pcraft.Pipe import PcraftPipe
from pcraft.utils import *
from pcraft import io as PcraftIO
from pcraft.Sessionizer import *

from scapy.all import *

PCAP_CONF = "pcap.conf"
LOG_CONF = "log.conf"
DEPENDENCIES_CONF = "dependencies.conf"
ACTIONS_CONF = "actions.conf"

PCAPNG_CUSTOM_PEN = 58353

class PcraftExec(object):
    def __init__(self, pkg, amifile, pcapout=None, outdir=None, force_mkdir=False):
        self.has_error = False
        self.output_dir = self.build_outputdir(outdir, force_mkdir=force_mkdir)
        
        self.packet_id = 0
        self.amifile = amifile
        self.pcapout = pcapout
        self.pcap_shark = None
        self.pkg = pkg
        self.current_time = time.time()
        self.session = Session()
        self.variables_built_by_plugins = {}
        self.file_pointers = {}
        
        self.pcapng = pycapng.PcapNG()
        self.ami = pyami.Ami()
        try:
            if pcapout:
                os.remove(pcapout)
        except FileNotFoundError:
            pass

        if self.pcapout:
            self.pcapng.OpenFile(self.pcapout, "w")
            # self.pcap_fp = open(self.pcapout, "wb")
            # self.pcap_fp.write(PcraftIO.get_pcap_header())
        
        self.pipe = PcraftPipe()
        
        self.ami.Parse(amifile)
        self.start_time = int(self.ami.GetStartTime())
        if self.start_time <= 0:
            self.start_time = self.current_time - self.ami.GetSleepCursor()

        print("Writing PcapNG file...")
        self.ami.Run(self.action_handler, None)
        self._close_pcap_file()
        print("Writing Logs...")
        self.logwrite()
        
    def __del__(self):
        for k, v in self.file_pointers.items():
            v.close()
    
    def build_outputdir(self, outdir=None, force_mkdir=False):
        if not outdir:
            return None
        try:
            os.makedirs(outdir)
        except FileExistsError:
            if force_mkdir:
                shutil.rmtree(outdir)
                os.makedirs(outdir)
            else:
                print("Error: Cannot make directory %s: Directory already exists!" % outdir)
                self.has_error = True
                sys.exit(1)
        except:
            print("Error: Cannot make directory %s" % self.output_dir)
            self.has_error = True
            sys.exit(1)

        return outdir
        
    def _close_pcap_file(self):
        if self.pcapout:
            self.pcapng.CloseFile()
        
    def _get_pcap_process_to_execute(self, pkgname, action_exec):
        packages = self.pkg.get_packages()
        cmd = os.path.join(packages[pkgname]['dirpath'], "bin" ,packages[pkgname]['config'][PCAP_CONF][action_exec]['bin'])
        return cmd

    def _get_log_processes_to_execute(self, pkgname):
        processes = {}
        packages = self.pkg.get_packages()
        for process, conf in packages[pkgname]['config'][LOG_CONF].items():
            conf["__basedir__"] = os.path.join(packages[pkgname]['dirpath'], "bin")
            processes[process] = conf
        return processes

    def _get_log_actions_config(self, pkgname):
        processes = {}
        packages = self.pkg.get_packages()
        return packages[pkgname]['config'][ACTIONS_CONF]
    
    def action_handler(self, action, userdata):
        if action.Exec().startswith("LogAction:"):
            pkg_name = "LogAction"
        else:
            pkg_name = self.pkg.get_pkgname_from_action(action.Exec())
            
        strmap = {"__exec__": action.Exec()}
        for k, v in self.variables_built_by_plugins.items():
            strmap[k] = v
        #
        # We do not want to carry the variable for source/dest port if created by plugins outsite of the plugin
        # However keeping the default source/dest ip is helpful!
        #
        try:
            del strmap["port-src"]
            del strmap["port-dst"]
        except:
            pass
            
        for k, v in action.Variables().items():
            strmap[k[1:]] = v

        # print(str(strmap))
            
        pipedata = {"time": self.start_time + action.GetSleepCursor(), "pcapout": [], "strmap": strmap}
        raw = self.pipe.write(pipedata)
        if pkg_name == "LogAction":            
            cmd = self._get_pcap_process_to_execute(pkg_name, "LogAction")
        else:
            cmd = self._get_pcap_process_to_execute(pkg_name, action.Exec())            

        process = subprocess.Popen(cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, env={"PYTHONPATH":"./"})
        process.stdin.write(raw)
        pstdout = process.communicate()[0]
        try:
            stdoutdec = self.pipe.read(pstdout)
        except IndexError:
            print("stdout write for package '%s' not serialized properly." % (pkg_name))
            return

        try:
            debugstr = stdoutdec["strmap"]["debug"] 
            # print("DEBUG>>>")
            # print(debugstr)
            # print("<<<<<<")
        except:
            pass

        try:
            for k, v in stdoutdec["strmap"].items():
                # print("k:%s v:%s" % (k, v))
                if k in strmap:
                    pass
                else:
                    # print("%s is not in the strmap" % k)
                    self.variables_built_by_plugins[k] = v
        except:
            pass

        # FIXME: I first read pcapout, then dataout; This is no problem since
        # a plugin writing pcap != a plugin writing data (non-network stuff)
        # however if we want to do both AND we need to preserve time, we may
        # need another structure to keep buffers in time order.
        if self.pcapout:
            if stdoutdec["pcapout"]:
                for pkt in stdoutdec["pcapout"]:
	            # We rebuild the packet because packets building can come from anything.
	            # We just see a buffer. We need to have a proper session, and the correct time.
                    scapy_pkt = Ether(pkt[16:])
	            # scapy_pkt.show()
                    if scapy_pkt.haslayer(TCP): # Fix the session
                        self.session.append_to_session(scapy_pkt)
                        scapy_pkt = self.session.fix_seq_ack(scapy_pkt)
	
	            # We fix the time
	            # TODO: Fix time here
                    pkt = PcraftIO.raw_packet_from_scapy(scapy_pkt)
                    pkt = pkt[2:] # FIXME: This is a hack because I cannot slice the scapy packet properly in the PcraftIO.raw_packet_from_scapy function.
                    self.pcapng.WritePacket(pkt, "")

            if stdoutdec["dataout"]:
                for d in stdoutdec["dataout"]:
                    self.pcapng.WriteCustom(PCAPNG_CUSTOM_PEN, d, "")
                
        process.stdin.close()

    def _logwrite_network(self):
        if not self.pcap_shark:
            self.pcap_shark = pyshark.FileCapture(self.pcapout)

        for pkt in self.pcap_shark:
            self.packet_id += 1

            for layer in pkt.layers:
                layer_name = layer.layer_name
                # print("Searching plugin to match layer: %s" % layer_name)


    def _handle_non_network_packets_command(self, pkg_name, conf, timestamp, strmap):
        cmd = os.path.join(conf["__basedir__"], conf["bin"])
        templates = self.pkg.get_templates(pkg_name)
        # Select the template from the configuration
        template = []                
        for tmpl in templates:
            if tmpl["eventtype"] == conf["template"]:
                template.append(tmpl)
    
        # pprint.pprint(template)
            
        pipedata = {"time": self.start_time + timestamp, "templates": template, "strmap": strmap}
        raw = self.pipe.write(pipedata)
    
        process = subprocess.Popen(cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, env={"PYTHONPATH":"./"})
        process.stdin.write(raw)
        pstdout = process.communicate()[0]
        self.file_pointers[conf["logfile"]].write(pstdout)
        
    def _handle_non_network_packets(self, block_counter, block_type, block_total_length, data):
        is_log_action = False
        
        if block_type == pycapng.CUSTOM_DATA_BLOCK:
            jsondata = json.loads(data)
            packages_to_execute = []
            if jsondata["__exec__"].startswith("LogAction:"):
                log_action = jsondata["__exec__"][10:]
                packages_to_execute = self.pkg.get_pkgnames_from_log_action(log_action)
                is_log_action = True
            else:
                packages_to_execute.append(self.pkg.get_pkgname_from_action(jsondata["__exec__"]))

            for execpkg in packages_to_execute:
                pkg_name = execpkg

                strmap = {}
                for k, v in jsondata.items():
                    strmap[k] = v
            
                # Get packet timestamp
                timestamp = 0

                processes = self._get_log_processes_to_execute(pkg_name)
            
                # conf example: {'bin': 'logwrite.py', 'logfile': 'windows_security.log', 'template': 'microsoft.windows.security.logstash14', '__basedir__': '/home/sebastien/pcraft-ng/pkg/enabled/WindowsSecurity/bin'}
                for p, conf in processes.items():
                    if conf["logfile"] in self.file_pointers:
                        pass # Shall we do something? I guess not
                    else:
                        self.file_pointers[conf["logfile"]] = open(os.path.join(self.output_dir, conf["logfile"]), "wb")

                    if is_log_action: # It is a log action, we handle multiple writes changing the field name
                        actions_config = self._get_log_actions_config(pkg_name)
                        events = None
                        for k, v in actions_config[log_action].items():
                            events = v.split(",")
                            for e in events:
                                strmap[k] = e
                                self._handle_non_network_packets_command(pkg_name, conf, timestamp, strmap)                                
                    else:
                        self._handle_non_network_packets_command(pkg_name, conf, timestamp, strmap)
                # print("stdout: %s" % pstdout)
                # pprint.pprint(pstdout)
                
    def _logwrite_non_network(self):
        self.pcapng.ForeachPacket(self._handle_non_network_packets)

    def logwrite(self):
        print("Writing logs from pcap file '%s' to directory '%s'..." % (self.pcapout, self.output_dir))
        self.pcapfp = self.pcapng.OpenFile(self.pcapout, "r")
        # First we write the network stuff with pyshark
        # Similar to how packets are seen by wireshark
        self._logwrite_network()

        # Next we write the non-network events
        # which are encoded in custom data blocks
        self._logwrite_non_network()

        self.pcapng.CloseFile()
        
if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Syntax: %s script.ami output.pcap outdir" % sys.argv[0])
        sys.exit(1)

    pkg = PackageManager()
    # pprint.pprint(pkg.get_packages())

    # print(">>>>>>")
    # print(pkg.get_pkgname_from_action("DNSConnection"))
    # print("<<<<")
    
    amifile = sys.argv[1]
    pcapout = sys.argv[2]
    outdir  = sys.argv[3]

    pe = PcraftExec(pkg, amifile, pcapout, outdir, "-f" in sys.argv)
    
    
    
