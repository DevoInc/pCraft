#!/usr/bin/env python3

import sys

from LogWrite import LogWrite, LogRewrite
import pyami

import avro.schema
from avro.datafile import DataFileReader
from avro.io import DatumReader

from LogWrite import LogWrite, LogRewrite


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

logplugin_action_map = { "DNSConnection": ["named"],
                         "HTTPConnection": ["bluecoat-proxysg-main", "zscaler-access"]                         
}

# action_category_map = { "DNSConnection": "network",
#                         "HTTPConnection": "network",
#                         "Controller": "endpoint",
# }

network_plugins = ["netflow", "paloalto-firewall"]

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Syntax: %s ccraft.db output_directory [-fv]" % sys.argv[0])
        sys.exit(1)

    ccraftfile = sys.argv[1]
    outdir = sys.argv[2]
        
    writer = LogWrite(None, outdir, "-f" in sys.argv)
    if writer.has_error:
        print("Error. Exiting.")
        sys.exit(1)
   
    reader = DataFileReader(open(ccraftfile, "rb"), DatumReader())
    for event in reader:
        # print(str(event))
        # {'time': 1614504320, 'exec': 'Void', 'variables': {'$domain': 'haute-voltige.io', '$index': '1', '$var': '1234'}, 'fset': {'myfield': 'abcd'}, 'freplace': {}}
        kvdict = event["fset"]        
        
        if event["exec"] == "Controller":
            plugin_name = []
            plugin_name.append(event["variables"]["$log_plugin"])
            for plugin in plugin_name:
                if plugin in writer.loaded_plugins:
                    if "-v" in sys.argv:
                        writer.loaded_plugins[plugin].validate_keys(kvdict)

                    writer.loaded_plugins[plugin].run_ccraft(event, kvdict)
                else:
                    print("No such plugin %s for action %s" % (plugin, event["action"]))
        else:
            try:
                plugin_name = logplugin_action_map[event["exec"]]
                for net in network_plugins:
                    plugin_name.append(net)
            except KeyError:
                print("No such plugin %s for action %s" % (event["exec"], event["action"]))
            for plugin in plugin_name:
                if plugin in writer.loaded_plugins:
                    if "-v" in sys.argv:
                        writer.loaded_plugins[plugin].validate_keys(event["variables"])

                    writer.loaded_plugins[plugin].run_ccraft(event, event["variables"])
                else:
                    print("No such plugin %s for action %s" % (plugin, event["action"]))
                    
        
    reader.close()
