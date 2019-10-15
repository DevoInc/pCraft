class PCraftPlugin(object):
    name = "GenerateNewDomain"
    
    def __init__(self, plugins_data):
        self.plugins_data = plugins_data

    def run(self, script=None):
        self.plugins_data._set("domain", "fred-replaceme.com")
        return script["_next"], self.plugins_data
