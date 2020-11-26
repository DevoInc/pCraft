import time

class PluginsData(object):
    def __init__(self, ami):
        self.pcap = []
        self.args = {}
        self.current_time = time.time()
        self.ami = ami

    def AddPacket(self, pkt):    
        self.pcap.append(pkt)
        
    def _set(self, key, value):
        self.args[key] = value

    def _get(self, key):
        return self.args[key]

    def __str__(self):
        return str(self.args)
        
