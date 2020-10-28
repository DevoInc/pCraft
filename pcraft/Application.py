import pprint
import pyami

from pcraft.Plugins import *
from pcraft.Functions import *

class Application:
    def __init__(self, scenariofile):
        self.literals = ["rule"] # FIXME, this should be defined by plugins
        self.plugins_loader, self.loaded_plugins = self.load_plugins()
        self.scenariofile = scenariofile
        self.ami = pyami.Ami()
        self.ami.Parse(scenariofile)
        self.actions = self.ami.GetActions()
        
    def load_plugins(self):
        plugins_loader = Plugins(app=self, loadfunc=self.print_loading_plugins)
        loaded_plugins = plugins_loader.get_loaded_plugins()
        print("All plugins loaded!")
        return plugins_loader, loaded_plugins

    def print_loading_plugins(self, plugin):
       print("Loading Plugin: %s" % plugin)

    def exec_plugin(self, plugin, ami, action):
        return plugin.run(ami, action)
        
        
