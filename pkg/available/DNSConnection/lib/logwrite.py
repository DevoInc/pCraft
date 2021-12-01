import json
from datetime import datetime
import random

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__(service="dns")

    def run(self, event, config, templates):
        self.reset_virtualpackets()

        ip_src = self.get_variable("$ip-src")
        resolver = self.get_variable("$resolver")
        port_src = self.get_variable("$port-src")
        port_dst = self.get_variable("$port-dst")

        # Request
        self.add_virtualpacket("dns", Protocol.UDP, Flow.FROM_CLIENT|Flow.TO_SERVER, ip_src, resolver, port_src, port_dst, packet_size=55, frame_time=event["time"])
        # Reply
        self.add_virtualpacket("dns", Protocol.UDP, Flow.FROM_SERVER|Flow.TO_CLIENT, resolver, ip_src, port_dst, port_src, packet_size=random.randint(75, 120), frame_time=event["time"])

        event["virtualpackets"] = self.get_virtualpackets()
        event["variables"]["$__layer__"] = "dns"
        
        yield None
