#!/usr/bin/env python3
from scapy.all import Ether, IP, UDP, DNS, DNSQR, DNSRR, Raw
from pcraft import utils
from pcraft import io as PcraftIO
from pcraft.Defaults import PcraftDefaults

data = PcraftIO.get_stdin()

defaults = PcraftDefaults(data, service="dns")

pcapout = []

# Query
dns_query = Ether() / IP(src=defaults.get_variable("ip-src"),dst=defaults.get_variable("resolver")) / UDP(sport=int(defaults.get_variable("port-src")),dport=int(defaults.get_variable("port-dst")))/DNS(rd=1, qd=DNSQR(qname=defaults.get_mand_variable("domain")))

dns_query.time = data["time"]
pkt = PcraftIO.raw_packet_from_scapy(dns_query)
pcapout.append(pkt)

# Response
dns_response = Ether() / IP(dst=defaults.get_variable("ip-src"),src=defaults.get_variable("resolver")) / UDP(sport=int(defaults.get_variable("port-dst")),dport=int(defaults.get_variable("port-src")))/DNS(id=dns_query[DNS].id, qr=1, qd=dns_query[DNS].qd, an=DNSRR(rrname=dns_query[DNS].qd.qname, rdata=defaults.get_variable("ip-dst")))
dns_response.time = data["time"]
pkt2 = PcraftIO.raw_packet_from_scapy(dns_response)
pcapout.append(pkt2)

outdata = {"pcapout": pcapout, "strmap": defaults.get_built_variables()}
PcraftIO.put_stdout(outdata)

