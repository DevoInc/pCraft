#!/usr/bin/env python3
from scapy.all import Ether, IP, TCP

from pcraft import io as PcraftIO
from pcraft.LibraryContext import *

class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event):        
        self.set_vardict(event["variables"])
        
        syn = Ether() / IP(src=self.get_variable("$ip-src"), dst=self.get_variable("$ip-dst")) / TCP(dport=int(self.get_variable("$port-dst")), sport=int(self.get_variable("$port-src")), flags="S")
        pkt = PcraftIO.raw_packet_from_scapy(syn)
        yield PcraftPacket("network", pkt)

        
        rst_ack = Ether() / IP(src=self.get_variable("$ip-dst"), dst=self.get_variable("$ip-src")) / TCP(sport=syn[TCP].dport, dport=syn[TCP].sport, flags="R""A")
        pkt = PcraftIO.raw_packet_from_scapy(rst_ack)
        yield PcraftPacket("network", pkt)
