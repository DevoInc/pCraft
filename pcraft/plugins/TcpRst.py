from IPy import IP as IP_y
from scapy.all import Ether, CookedLinux, IP, TCP, UDP, rdpcap
from . import _utils as utils
import pprint
import random

from pcraft.PluginsContext import PluginsContext


class PCraftPlugin(PluginsContext):
    name = "TcpRst"
    required = ["ip-src", "ip-dst", "port-dst"]

    def help(self):
        helpstr="""
Send a exchange of SYN followed by RST-ACK between two hosts.

### Examples

#### 1: Send a SYN and receive a RST-ACK
```
rstack:
  _plugin: TcpRst
  ip-src: "192.168.0.42"
  ip-dst: "192.168.0.1"
  port-dst: 9876
  _next: done
```
"""
        return helpstr
    
    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        self.session = session
        
    def run(self, script=None):
        self.update_vars_from_script(script)
        # pprint.pprint(script)
        port = script["port-dst"]
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
            
            # SYN
            syn = Ether() / IP(src=script["ip-src"], dst=str(individual_ip)) / TCP(dport=port, flags="S")
            self.plugins_data.pcap.append(syn)
            
            # RST-ACK
            rst_ack = Ether() / IP(src=individual_ip, dst=script["ip-src"]) / TCP(sport=port, dport=syn[TCP].sport, flags="R""A")
            self.plugins_data.pcap.append(rst_ack)
            if str(individual_ip) == ipstop:
                has_stoped= True
            
            
        return script["_next"], self.plugins_data
