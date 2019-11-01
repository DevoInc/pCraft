from IPy import IP as IP_y
from scapy.all import *
from . import _utils as utils

class PCraftPlugin(object):
    name = "Ping"

    def __init__(self, plugins_data):
        self.plugins_data = plugins_data
        
    def run(self, script=None):
        # pprint.pprint(script)
        ip = script["ip-dst"]
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
            
            # PING
            echo_request = Ether() / IP(src=script["ip-src"], dst=str(individual_ip)) / ICMP(type="echo-request")
            self.plugins_data.pcap.append(echo_request)
            echo_reply = Ether() / IP(src=str(individual_ip), dst=script["ip-src"]) / ICMP(type="echo-reply")
            self.plugins_data.pcap.append(echo_reply)
            if str(individual_ip) == ipstop:
                has_stoped= True
            
            
        return script["_next"], self.plugins_data
