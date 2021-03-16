import time
from scapy.utils import PcapWriter

class PluginsData(object):
    def __init__(self, ami, pcapout):
        self.pcap = []
        self.args = {}
        self.current_time = time.time()
        self.ami = ami

        # print("Start time:" + time.ctime(int(self.ami.GetStartTime())))
        
        if self.ami.GetStartTime() > 0:            
            self.packet_time = self.ami.GetStartTime()
        else:
            self.packet_time = self.current_time - self.ami.GetSleepCursor()

        self.outpcap = PcapWriter(pcapout, append=True, sync=True)        
        self.outpcap_endpoint = PcapWriter("endpoint_" + pcapout, append=True, sync=True)
        self.packets_counter = 0
        self.writing_errors = 0
        
    def AddPacket(self, action, pkt):
        self.packets_counter += 1

        # print("Packet Time:%d" % int(self.packet_time))
        # print("Action Sleep Cursor:%d" % int(action.GetSleepCursor()))
        
        # pkt.time = self.packet_time + action.GetSleepCursor()
        pkt.time = self.packet_time + self.ami.GetSleepCursor() + action.GetSleepCursor()
        
        try:
            self.outpcap.write(pkt)
        except:
            self.writing_errors += 1
#        self.pcap.append(pkt)

    def AddEndpointPacket(self, action, pkt):
        self.packets_counter += 1

        # print("Packet Time:%d" % int(self.packet_time))
        # print("Action Sleep Cursor:%d" % int(action.GetSleepCursor()))
        
        # pkt.time = self.packet_time + action.GetSleepCursor()
        pkt.time = self.packet_time + self.ami.GetSleepCursor() + action.GetSleepCursor()
        
        try:
            self.outpcap_endpoint.write(pkt)
        except:
            self.writing_errors += 1
#        self.pcap.append(pkt)


    def _set(self, key, value):
        self.args[key] = value

    def _get(self, key):
        return self.args[key]

    def __str__(self):
        return str(self.args)
        
