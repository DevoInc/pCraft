#from scapy.all import Ether, IP, TCP

class Session:
    is_new = False
    is_established = False
    is_finised = False
    
    def __init__(self):
        self.tcp_seqnum = 0

    def get_seqnum(self, packet):
        seqnum = self.tcp_seqnum
        
        self.tcp_seqnum += len(packet['TCP'].payload)
        if self.tcp_seqnum > 2147483647: # 2^32 - 1
            self.tcp_seqnum = 0

        return seqnum

    def get_next(self):
        pass

