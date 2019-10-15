from IPy import IP as IP_y
from scapy.all import Ether, CookedLinux, IP, TCP, UDP, rdpcap
from . import _utils as utils
import pprint
import random

class PCraftPlugin(object):
    name = "TcpRst"

    def __init__(self, plugins_data):
        self.plugins_data = plugins_data
        
    def run(self, script=None):
        # pprint.pprint(script)
        port = script["dport"]
        ip = script["dstip"]
        all_ips = IP_y(ip)

        has_started = False
        ipstart = ""
        ipstop = ""
        try:
            ipstart = script["ipstart"]
        except:
            has_started = True
        try:
            ipstop = script["ipstop"]
        except:
            pass
        has_stoped = False

        
        for individual_ip in all_ips:
            if has_stoped:
                break

            if str(individual_ip).endswith(".0") or str(individual_ip).endswith(".255"):
                continue
            if not has_started:
                if str(individual_ip) != ipstart:
                    continue
                else:
                    has_started = True
            
            # SYN
            syn = Ether() / IP(src=script["srcip"], dst=str(individual_ip)) / TCP(dport=port, flags="S")
            self.plugins_data.pcap.append(syn)
            
            # RST-ACK
            rst_ack = Ether() / IP(src=individual_ip, dst=script["srcip"]) / TCP(sport=port, dport=syn[TCP].sport, flags="R""A")
            self.plugins_data.pcap.append(rst_ack)
            if str(individual_ip) == ipstop:
                has_stoped= True
            
            
        return script["_next"], self.plugins_data
