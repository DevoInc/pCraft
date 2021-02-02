import pprint
import pyami
import time

from pcraft.Plugins import *
from pcraft.Functions import *

class Application:
    def __init__(self, scenariofile):
        self.literals = ["rule"] # FIXME, this should be defined by plugins
        self.ami = pyami.Ami()
        print("Scenariofile: [%s]" % scenariofile)
        self.ami.Parse(scenariofile)
        self.start_time = int(self.ami.GetStartTime())
        self.plugins_loader, self.loaded_plugins = self.load_plugins(self.ami)
        self.scenariofile = scenariofile
        self.actions = self.ami.GetActions()

    def finalize(self):
        if self.start_time > 0:
            print("Start Time: %s" % time.ctime(self.start_time))
        sleep_cursor = self.ami.GetSleepCursor()
        print("Final Sleep Cursor: %d seconds; %d hours; %d days" % (int(sleep_cursor), int(sleep_cursor / 60 / 60), int(sleep_cursor / 60 / 60 / 24)))
            
    def load_plugins(self, _ami):
        plugins_loader = Plugins(ami=_ami, app=self, loadfunc=self.print_loading_plugins)
        loaded_plugins = plugins_loader.get_loaded_plugins()
        print("All plugins loaded!")
        return plugins_loader, loaded_plugins

    def print_loading_plugins(self, plugin):
       print("Loading Plugin: %s" % plugin)

    def exec_plugin(self, plugin, ami, action):
        return plugin.run(ami, action)
        
        
