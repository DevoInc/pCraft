#!/usr/bin/env python3
from scapy.all import Ether, IP, TCP

from pcraft import io as PcraftIO
from pcraft.Defaults import PcraftDefaults
from pcraft import utils

data = PcraftIO.get_stdin()
defaults = PcraftDefaults(data, service="http")

pcapout = []

syn, syn_ack, ack = utils.get_tcp_three_way_handshake(defaults.get_variable("ip-src"),
                                                      defaults.get_variable("ip-dst"),
                                                      int(defaults.get_variable("port-src")),
                                                      int(defaults.get_variable("port-dst")))

pkt = PcraftIO.raw_packet_from_scapy(syn)
pcapout.append(pkt)
pkt = PcraftIO.raw_packet_from_scapy(syn_ack)
pcapout.append(pkt)
pkt = PcraftIO.raw_packet_from_scapy(ack)
pcapout.append(pkt)

outdata = {"pcapout": pcapout, "strmap": defaults.get_built_variables()}
PcraftIO.put_stdout(outdata)
