from scapy.all import Ether, IP as ScapyIP, TCP
from IPy import IP
import random

class getRandomIP:
    def __init__(self, network, ipfail=None):
        self.used_ips = []
        self.network = network
        self.ipfail = ipfail
        
    def get(self):        
        iplist = IP(self.network)
        
        sip = iplist[random.randint(0,len(iplist)-1)]        
        if sip not in self.used_ips:
            self.used_ips.append(sip)
            return str(sip)
        else:
            try:
                return self.get()
            except RecursionError:
                if ipfail:
                    return str(ipfail) # We have set an IP in case of failure, so we don't crash the program
                raise Exception("No more new IP can be pulled. Increase the Network size.")

        return "0.0.0.0"

def append_tcp_three_way_handshake(session, plugins_data, srcport=4096, dstport=80):
    syn = Ether() / ScapyIP(src=plugins_data._get("ip-src"),dst=plugins_data._get("ip-dst")) / TCP(sport=srcport, dport=dstport, flags="S")
    session.append_to_session(syn)
    syn = session.fix_seq_ack(syn)
    plugins_data.pcap.append(syn)    
    syn_ack = Ether() / ScapyIP(src=plugins_data._get("ip-dst"),dst=plugins_data._get("ip-src")) / TCP(sport=dstport, dport=srcport, ack=syn[TCP].seq + 1, flags="S""A")
    session.append_to_session(syn_ack)
    syn_ack = session.fix_seq_ack(syn_ack)
    plugins_data.pcap.append(syn_ack)
    ack = Ether() / ScapyIP(src=plugins_data._get("ip-src"),dst=plugins_data._get("ip-dst")) / TCP(sport=srcport, seq=syn_ack[TCP].ack, ack=syn_ack[TCP].ack, dport=dstport, flags="A")
    session.append_to_session(ack)
    ack = session.fix_seq_ack(ack)    
    plugins_data.pcap.append(ack)

    return ack
    
def append_tcp_three_way_handshake_reverse(session, plugins_data, srcport=4096, dstport=80):
    syn = Ether() / ScapyIP(src=plugins_data._get("ip-dst"),dst=plugins_data._get("ip-src")) / TCP(sport=srcport, dport=dstport, flags="S")
    plugins_data.pcap.append(syn)
    syn_ack = Ether() / ScapyIP(src=plugins_data._get("ip-src"),dst=plugins_data._get("ip-dst")) / TCP(sport=dstport, dport=srcport, ack=syn[TCP].seq + 1, flags="S""A")
    plugins_data.pcap.append(syn_ack)
    ack = Ether() / ScapyIP(src=plugins_data._get("ip-dst"),dst=plugins_data._get("ip-src")) / TCP(sport=srcport, seq=syn_ack[TCP].ack, ack=syn_ack[TCP].ack, dport=dstport, flags="A")
    plugins_data.pcap.append(ack)

    return ack
    
