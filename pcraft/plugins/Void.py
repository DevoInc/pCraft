from pcraft.PluginsContext import PluginsContext

class PCraftPlugin(PluginsContext):
    name = "Void"

    def help(self):
        return ""

    def __init__(self, ami, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        
    def run(self, ami, action):
        print(str(self.plugins_data))
        return self.plugins_data

    
