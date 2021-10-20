#!/usr/bin/env python3
import os

from scapy.all import Ether, CookedLinux, IP, TCP, UDP, rdpcap
from IPy import IP as IP_y

from pcraft import io as PcraftIO
from pcraft.Defaults import PcraftDefaults

data = PcraftIO.get_stdin()
pcapout = []



outdata = {"pcapout": pcapout}
PcraftIO.put_stdout(outdata)

