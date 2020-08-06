import glob
import importlib
import importlib.util
import os
import pathlib

import pcraft.plugins
from pcraft.Application import *
from pcraft.PluginsData import *
from pcraft.Sessionizer import *

class Plugins:
    def __init__(self, pluginsdir=None, app=None, arguments_dealer=None, loadfunc=None):
        self.loaded_plugins = {}
        self.arguments_dealer = arguments_dealer
        self.instdir = str(pathlib.Path(__file__).parent.absolute())
        if pluginsdir == None:
            pluginsdir = self.instdir + "/plugins/"
            
        self.plugins = glob.glob(pluginsdir + "*.py")
        self.plugins = [x for x in self.plugins if not x.endswith("__init__.py")] # I do not want to include the __init__.py file
        self.plugins = [x for x in self.plugins if not x.endswith("_utils.py")]
        if not self.plugins:
            raise Exception("No Plugins found from %s; The engine is useless!" % pluginsdir)
        print(self.plugins)

        self.plugins_data = PluginsData()
        self.session = Session()
        self.app = app
        
        for modfile in self.plugins:
            plugin_name = os.path.basename(modfile)[:-3] # We remove the extension
            import_plugin = self._modularize_string_path(modfile)
            import_plugin = "pcraft" + import_plugin[len(self.instdir):]
            module = importlib.import_module(import_plugin)
            dp = module.PCraftPlugin(self.app, self.session, self.plugins_data)
            self.loaded_plugins[plugin_name] = dp
            #            dp.run()
            #self.loaded_plugins[plugin_name] = dp
            
            # spec = importlib.util.spec_from_file_location(self._modularize_string_path(modfile),modfile)
            # module = importlib.util.module_from_spec(spec)
            # if module and loadfunc:
            #     loadfunc(plugin_name)
            # spec.loader.exec_module(module)(arguments_dealer)
            # self.loaded_plugins[plugin_name] = module

    def _modularize_string_path(self, strpath):
        return strpath.replace("/",".")[:-3]

    def get_loaded_plugins(self):
        return self.loaded_plugins

    def get_plugins_data(self):
        return self.plugins_data
