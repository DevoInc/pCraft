import pprint
import pyami
import time

from pcraft.Plugins import *
from pcraft.Functions import *

class Application:
    def __init__(self, scenariofile, pcap_out):
        self.literals = ["rule"] # FIXME, this should be defined by plugins
        self.ami = pyami.Ami()
        self.pcapout = pcap_out
        print("Scenariofile: [%s]" % scenariofile)
        self.plugins_loader, self.loaded_plugins = self.load_plugins(self.ami)
        self.ami.Parse(scenariofile, self.action_handler)
        self.start_time = int(self.ami.GetStartTime())
        self.scenariofile = scenariofile
        
    def action_handler(self, action):
        # print("Executing action %s using %s\n" % (action.Name(), action.Exec()))
        # print(action.Variables())
        for k, v in action.Variables().items():
            self.plugins_loader.plugins_data._set(k[1:], v) # we trim the $ sign for the key name
        self.loaded_plugins[action.Exec()].run(self.ami, action)
        
    def finalize(self):
        if self.start_time > 0:
            print("Start Time: %s" % time.ctime(self.start_time))
        sleep_cursor = self.ami.GetSleepCursor()
        print("Final Sleep Cursor: %d seconds; %d hours; %d days" % (int(sleep_cursor), int(sleep_cursor / 60 / 60), int(sleep_cursor / 60 / 60 / 24)))
            
    def load_plugins(self, _ami):
        plugins_loader = Plugins(ami=_ami, pcap_out=self.pcapout, app=self, loadfunc=self.print_loading_plugins)
        loaded_plugins = plugins_loader.get_loaded_plugins()
        print("All plugins loaded!")
        return plugins_loader, loaded_plugins

    def print_loading_plugins(self, plugin):
       print("Loading Plugin: %s" % plugin)

    def exec_plugin(self, plugin, ami, action):
        return plugin.run(ami, action)
        
        
