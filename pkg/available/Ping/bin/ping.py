#!/usr/bin/env python3
import os

from IPy import IP as IP_y

from scapy.all import Ether, IP, ICMP

from pcraft import io as PcraftIO
from pcraft.Defaults import PcraftDefaults

data = PcraftIO.get_stdin()
defaults = PcraftDefaults(data, service="icmp")
pcapout = []

echo_request = Ether() / IP(src=defaults.get_variable("ip-src"), dst=defaults.get_variable("ip-dst")) / ICMP(type="echo-request")
pkt = PcraftIO.raw_packet_from_scapy(echo_request)
pcapout.append(pkt)

echo_reply = Ether() / IP(src=defaults.get_variable("ip-dst"), dst=defaults.get_variable("ip-src")) / ICMP(type="echo-reply")
pkt = PcraftIO.raw_packet_from_scapy(echo_reply)
pcapout.append(pkt)

outdata = {"pcapout": pcapout}
PcraftIO.put_stdout(outdata)

