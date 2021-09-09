from pcraft.PluginsContext import PluginsContext

class PCraftPlugin(PluginsContext):
    name = "LogCall"

    def help(self):
        return ""

    def __init__(self, ami, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        
    def run(self, ami, action):
        print("LogCall called from pcrafter; However it can only be used with ccraft!")
        return self.plugins_data
