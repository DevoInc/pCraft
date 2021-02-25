from pcraft.PluginsContext import PluginsContext

class PCraftPlugin(PluginsContext):
    name = "Void"

    def help(self):
        return ""

    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        
    def run(self, ami, action):
        return self.plugins_data

    
