#from scapy.all import Ether, IP, TCP
import communityid

class Session:
    is_new = False
    is_established = False
    is_finised = False
    
    def __init__(self):
        self.tcp_seqnum = 0
        self.cid = communityid.CommunityID()
        self.sessions = {}

    def append_to_session(self, packet):
        flowid = self.get_flowid(packet)
        try:
            last = self.sessions[flowid][-1]
            current_seq = 0
            current_ack = 0
            if last['tcp_segment_len'] == 0:
                current_seq = last['ack'] + 1
                current_ack = last['seq']
            else:
                current_seq = last['ack']
                current_ack = last['seq'] + last['tcp_segment_len']
            session_details = {'seq': current_seq, 'ack': current_ack, 'tcp_segment_len': len(packet['TCP']) - 20}
            self.sessions[flowid].append(session_details)            
        except KeyError:
            self.sessions[flowid] = []
            session_details = {'seq': 1, 'ack': 0, 'tcp_segment_len': len(packet['TCP']) - 20}
            self.sessions[flowid].append(session_details)

    def fix_seq_ack(self, packet):
        packet['TCP'].seq = self.get_seq(packet)
        packet['TCP'].ack = self.get_ack(packet)
        return packet
            
    def get_ack(self, packet):
        flowid = self.get_flowid(packet)
        return self.sessions[flowid][-1]['ack']

    def get_seq(self, packet):
        flowid = self.get_flowid(packet)
        return self.sessions[flowid][-1]['seq']

    def debug_session(self):
        for k,v in self.sessions.items():
            print("k:%s; v:%s" % (k, str(v)))
            
    def get_flowid(self, packet):
        tpl = communityid.FlowTuple.make_tcp(packet['IP'].src, packet['IP'].dst, packet['TCP'].sport, packet['TCP'].dport)
        return self.cid.calc(tpl)

    def get_seqnum(self, packet):
        seqnum = self.tcp_seqnum
        
        self.tcp_seqnum += len(packet['TCP'].payload)
        if self.tcp_seqnum > 2147483647: # 2^32 - 1
            self.tcp_seqnum = 0

        return seqnum

    def get_next(self):
        pass

