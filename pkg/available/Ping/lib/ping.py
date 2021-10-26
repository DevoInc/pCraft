#!/usr/bin/env python3
from scapy.all import Ether, IP, ICMP

from pcraft import io as PcraftIO


class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event):        
        self.set_vardict(event["variables"])

        echo_request = Ether() / IP(src=self.get_variable("$ip-src"), dst=self.get_variable("$ip-dst")) / ICMP(type="echo-request")
        pkt = PcraftIO.raw_packet_from_scapy(echo_request)
        yield "network", pkt

        echo_reply = Ether() / IP(src=self.get_variable("$ip-dst"), dst=self.get_variable("$ip-src")) / ICMP(type="echo-reply")
        pkt = PcraftIO.raw_packet_from_scapy(echo_reply)
        yield "network", pkt
