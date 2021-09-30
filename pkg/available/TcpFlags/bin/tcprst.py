#!/usr/bin/env python3
from scapy.all import Ether, IP, TCP

from pcraft import io as PcraftIO
from pcraft.Defaults import PcraftDefaults

data = PcraftIO.get_stdin()
defaults = PcraftDefaults(data, service="http")

pcapout = []

syn = Ether() / IP(src=defaults.get_variable("ip-src"), dst=defaults.get_variable("ip-dst")) / TCP(dport=int(defaults.get_variable("port-dst")), sport=int(defaults.get_variable("port-src")), flags="S")
pkt = PcraftIO.raw_packet_from_scapy(syn)
pcapout.append(pkt)

rst_ack = Ether() / IP(src=defaults.get_variable("ip-dst"), dst=defaults.get_variable("ip-src")) / TCP(sport=syn[TCP].dport, dport=syn[TCP].sport, flags="R""A")
pkt = PcraftIO.raw_packet_from_scapy(rst_ack)
pcapout.append(pkt)

outdata = {"pcapout": pcapout, "strmap": defaults.get_built_variables()}
PcraftIO.put_stdout(outdata)
