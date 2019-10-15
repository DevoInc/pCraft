class PluginsData(object):
    def __init__(self):
        self.pcap = []
        self.args = {}

    def _set(self, key, value):
        self.args[key] = value

    def _get(self, key):
        return self.args[key]

    def __str__(self):
        return str(self.args)
        
