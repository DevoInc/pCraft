#!/usr/bin/env python3
from scapy.all import Ether, IP, TCP

from pcraft import utils
from pcraft import io as PcraftIO
from pcraft.LibraryContext import *
from pcraft.Packet import *

class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event):
        self.set_vardict(event["variables"])
        
        syn, syn_ack, ack = utils.get_tcp_three_way_handshake(self.get_variable("$ip-src"),
                                                              self.get_variable("$ip-dst"),
                                                              int(self.get_variable("$port-src")),
                                                              int(self.get_variable("$port-dst")))

        pkt = PcraftIO.raw_packet_from_scapy(syn)
        yield PcraftPacket("network", pkt)
        pkt = PcraftIO.raw_packet_from_scapy(syn_ack)
        yield PcraftPacket("network", pkt)
        pkt = PcraftIO.raw_packet_from_scapy(ack)
        yield PcraftPacket("network", pkt)


