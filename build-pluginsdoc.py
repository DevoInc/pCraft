#!/usr/bin/python3
from PCraft.Plugins import *

plugins_loader = Plugins()
loaded_plugins = plugins_loader.get_loaded_plugins()


def get_description_from_variable(var):
    var_desc = {"domain": "A domain name",
                "ip-dst": "Destination IP",
                "ip-src": "Source IP",
                "port": "TCP/IP Port",
    }
    return var_desc[var]

fp = open("doc/plugins.md", "w")
for p in loaded_plugins:
    required = None
    try:
        required = loaded_plugins[p].required
    except:
        pass
    try:
        fp.write("## %s\n" % p)
        if required:
            fp.write("### Required Variables\n\n")
            for r in required:
                fp.write("| Variable | Description |\n")
                fp.write("|:--------:|-------------|\n")
                fp.write("| %s | %s |\n" % (r, get_description_from_variable(r)))
                
        fp.write(loaded_plugins[p].help())
        fp.write("\n")
    except:
        print("The plugin %s has no documentation!" % p)


fp.close()

