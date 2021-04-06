import pprint
import pyami
import time
import os

from pcraft.Plugins import *
from pcraft.Functions import *

class Application:
    def __init__(self, scenariofile, pcap_out):
        self.literals = ["rule"] # FIXME, this should be defined by plugins
        self.ami = pyami.Ami()
        try:
            os.remove(pcap_out)
        except FileNotFoundError:
            pass
        
        self.pcapout = pcap_out
        print("Scenariofile: [%s]" % scenariofile)

        self.ami.Parse(scenariofile)
        ami_starttime = self.ami.GetStartTime()
        self.start_time = int(ami_starttime)
        self.scenariofile = scenariofile

        self.plugins_loader, self.loaded_plugins = self.load_plugins(self.ami)
        # print("Loaded plugins: %s" % self.loaded_plugins)
        # self.ami.Parse(scenariofile)
        self.ami.Run(self.action_handler, None)
        
    def action_handler(self, action, plugins):
        # print("Executing action %s using %s\n" % (action.Name(), action.Exec()))
        # print(action.Variables())
        for k, v in action.Variables().items():
            self.plugins_loader.plugins_data._set(k[1:], v) # we trim the $ sign for the key name
        # try:
        self.loaded_plugins[action.Exec()].run(self.ami, action)
        # except:
        #     print("Error with action name '%s' -> exec is '%s'" % (action.Name(), action.Exec()))
        
    def finalize(self):
        if self.start_time > 0:
            print("Start Time: %s" % time.ctime(self.start_time))
        sleep_cursor = self.ami.GetSleepCursor()
        print("Final Sleep Cursor: %d seconds; %d hours; %d days" % (int(sleep_cursor), int(sleep_cursor / 60 / 60), int(sleep_cursor / 60 / 60 / 24)))
        print("%s writing errors" % self.plugins_loader.plugins_data.writing_errors)
        
    def load_plugins(self, _ami):
        plugins_loader = Plugins(ami=_ami, pcap_out=self.pcapout, app=self, loadfunc=self.print_loading_plugins)
        loaded_plugins = plugins_loader.get_loaded_plugins()
        print("All plugins loaded!")
        return plugins_loader, loaded_plugins

    def print_loading_plugins(self, plugin):
       print("Loading Plugin: %s" % plugin)

    def exec_plugin(self, plugin, ami, action):
        return plugin.run(ami, action)
        
        
