#!/usr/bin/python3
from PCraft.Plugins import *

plugins_loader = Plugins()
loaded_plugins = plugins_loader.get_loaded_plugins()

fp = open("doc/plugins.md", "w")
for p in loaded_plugins:
    try:
        fp.write(loaded_plugins[p].help())
        fp.write("\n")
    except:
        print("The plugin %s has no documentation!" % p)


fp.close()

