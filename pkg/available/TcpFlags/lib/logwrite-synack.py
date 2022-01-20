#!/usr/bin/env python3
import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        self.reset_virtualpackets()

        ip_src = self.get_variable("$ip-src")
        ip_dst = self.get_variable("$ip-dst")
        port_src = self.get_variable("$port-src")
        port_dst = self.get_variable("$port-dst")

        # Request
        self.add_virtualpacket("ip", Protocol.TCP, Flow.FROM_CLIENT|Flow.TO_SERVER, ip_src, ip_dst, port_src, port_dst, packet_size=60, frame_time=event["time"])
        # Reply
        self.add_virtualpacket("ip", Protocol.TCP, Flow.FROM_SERVER|Flow.TO_CLIENT, ip_dst, ip_src, port_dst, port_src, packet_size=60, frame_time=event["time"])
        # ACK to reply
        self.add_virtualpacket("ip", Protocol.TCP, Flow.FROM_CLIENT|Flow.TO_SERVER, ip_src, ip_dst, port_src, port_dst, packet_size=52, frame_time=event["time"])
        
        event["virtualpackets"] = self.get_virtualpackets()
        event["variables"]["$__layer__"] = "ip"

        
        yield None
