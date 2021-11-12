#!/usr/bin/env python3
from scapy.all import Ether, IP, UDP, DNS, DNSQR, DNSRR, Raw

from pcraft import io as PcraftIO
from pcraft.LibraryContext import *
from pcraft.Packet import *

class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__(service="dns")
        
    def run(self, event):
        self.set_vardict(event["variables"])
        # Query
        dns_query = Ether() / IP(src=self.get_variable("$ip-src"),dst=self.get_variable("$resolver")) / UDP(sport=int(self.get_variable("$port-src")),dport=int(self.get_variable("$port-dst")))/DNS(rd=1, qd=DNSQR(qname=self.get_mand_variable("$domain")))
        pkt = PcraftIO.raw_packet_from_scapy(dns_query)
        yield PcraftPacket("network", pkt)

        # Response
        dns_response = Ether() / IP(dst=self.get_variable("$ip-src"),src=self.get_variable("$resolver")) / UDP(sport=int(self.get_variable("$port-dst")),dport=int(self.get_variable("$port-src")))/DNS(id=dns_query[DNS].id, qr=1, qd=dns_query[DNS].qd, an=DNSRR(rrname=dns_query[DNS].qd.qname, rdata=self.get_variable("$ip-dst")))
        pkt = PcraftIO.raw_packet_from_scapy(dns_response)
        yield PcraftPacket("network", pkt)

