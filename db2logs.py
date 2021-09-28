#!/usr/bin/env python3

import sys

from LogWrite import LogWrite, LogRewrite
import pyami

import avro.schema
from avro.datafile import DataFileReader
from avro.io import DatumReader

from pcraft.Plugins import *


SCHEMA = """{
    "type": "record",
    "name": "event",
    "fields": [
        {"name": "time", "type": "int", "default": "0"},
        {"name": "action", "type": "string", "default": "Void"},
        {"name": "exec", "type": "string", "default": "Void"},
        {"name": "variables", "type": {"type": "map", "name": "var", "values": "string"}},
        {"name": "fset", "type": {"type": "map", "values": "string"}},
        {"name": "freplace", "type": {"type": "map", "values": "string"}}
        ]
}"""

logplugin_action_map = { "DNSConnection": ["named", "crowdstrike-dnsrequest"],
                         "HTTPConnection": ["bluecoat-proxysg-main", "zscaler-access"],
                         "TcpSynAck": [],
}

# action_category_map = { "DNSConnection": "network",
#                         "HTTPConnection": "network",
#                         "Controller": "endpoint",
# }

network_plugins = ["netflow", "paloalto-firewall", "fortinet-traffic", "aws-vpc-flow"]
# network_plugins = []

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Syntax: %s ccraft.db output_directory [-fv]" % sys.argv[0])
        sys.exit(1)

    ccraftfile = sys.argv[1]
    outdir = sys.argv[2]


    plugins_loader = Plugins(ami=None, pcap_out=None, app=None, loadfunc=None)
    pcraft_plugins = plugins_loader.get_loaded_plugins()
    
    writer = LogWrite(None, outdir, "-f" in sys.argv)
    if writer.has_error:
        print("Error. Exiting.")
        sys.exit(1)

    # global_variables = {}

    reader = DataFileReader(open(ccraftfile, "rb"), DatumReader())
    for event in reader:
        # print(str(event))
        # {'time': 1614504320, 'exec': 'Void', 'variables': {'$domain': 'haute-voltige.io', '$index': '1', '$var': '1234'}, 'fset': {'myfield': 'abcd'}, 'freplace': {}}
        kvdict = event["fset"]        
        # global_variables.update(event["variables"])
        
        if event["exec"] == "Controller":
            plugin_name = []
            try:
                plugin_name.append(event["variables"]["$log_plugin"])
            except:
                print("Warning: $log_plugin variable not found in action '%s'. Using mswin-security" % event["action"])
                plugin_name.append("mswin-security")

            # print("Controller Length of plugins: " + str(len(plugin_name)))
            for plugin in plugin_name:
                if plugin in writer.loaded_plugins:
                    if "-v" in sys.argv:
                        writer.loaded_plugins[plugin].validate_keys(kvdict)

                    writer.loaded_plugins[plugin].run_ccraft(event, kvdict)
                else:
                    print("No such plugin %s for action %s" % (plugin, event["action"]))
        elif event["exec"] == "LogCall":
            for plugin in writer.loaded_plugins:
                logcalls = None
                try:
                    logcalls = writer.loaded_plugins[plugin].logcalls
                except AttributeError:
                    pass
                if logcalls:
                    if event["variables"]["$call"] in logcalls:
                        writer.loaded_plugins[plugin].run_ccraft(event, event["variables"], logcall=event["variables"]["$call"])
        else:
            plugin_name = []
            try:
                plugin_name = logplugin_action_map[event["exec"]]
                for net in network_plugins:
                    if net not in plugin_name:
                        plugin_name.append(net)
            except KeyError:
                print("No such plugin %s for action %s" % (event["exec"], event["action"]))
            # print("Length of plugins: " + str(len(plugin_name)))
            # print(str(plugin_name))
            for plugin in plugin_name:
                if plugin in writer.loaded_plugins:
                    if "-v" in sys.argv:
                        writer.loaded_plugins[plugin].validate_keys(event["variables"])

                    # The variables for network are filled, in case they do not exist. This is a problem
                    # we do not have with pcap as we always have ip/port-src and ip/port-dst
                    event_vars = event["variables"]
                    pcraft_plugins[event["exec"]].set_network_variables(event_vars, event=event)
                    # print(event_vars)
                    writer.loaded_plugins[plugin].run_ccraft(event, event_vars)
                else:
                    print("No such plugin %s for action %s" % (plugin, event["action"]))
                    
        
    reader.close()
