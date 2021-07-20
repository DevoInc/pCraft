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
Send a exchange of SYN followed by SYN-ACK and ACK between two hosts.

### Examples

#### 1: Send a SYN and receive a SYN-ACK, then reply ACK
```
action synack {
        $ip-src = "192.168.0.42"
        $ip-dst = "192.168.0.1"
        $port-dst = 9876

        exec TcpSynAck
}
```
"""
        return helpstr
    
    def __init__(self, ami, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        self.session = session
        
    def run(self, ami, action):
        dstport = int(self.getvar("port-dst"))
        try:
            srcport = int(self.getvar("port-src"))
        except:
            srcport = random.randint(4096, 65534)
        
        # SYN
        syn = Ether() / IP(src=self.getvar("ip-src"), dst=self.getvar("ip-dst")) / TCP(dport=dstport, sport=srcport, flags="S")
        self.plugins_data.AddPacket(action, syn)
            
        # SYN-ACK
        syn_ack = Ether() / IP(src=self.getvar("ip-dst"), dst=self.getvar("ip-src")) / TCP(sport=dstport, dport=syn[TCP].sport, flags="S""A")
        self.plugins_data.AddPacket(action, syn_ack)

        # ACK
        ack = Ether() / IP(src=self.getvar("ip-src"), dst=self.getvar("ip-dst")) / TCP(sport=dstport, dport=syn[TCP].sport, flags="A")
        self.plugins_data.AddPacket(action, ack)
        
        return self.plugins_data
