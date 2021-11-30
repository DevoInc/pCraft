import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__(service="http")

    def run(self, event, config, templates):
        self.reset_virtualpackets()

        ip_src = self.get_variable("$ip-src")
        ip_dst = self.get_variable("$ip-dst")
        port_src = self.get_variable("$port-src")
        port_dst = self.get_variable("$port-dst")

        # SYN
        self.add_virtualpacket("tcp", Protocol.TCP, ip_src, ip_dst, port_src, port_dst, packet_size=54, frame_time=event["time"])
        # SYN|ACK
        self.add_virtualpacket("tcp", Protocol.TCP, ip_dst, ip_src, port_dst, port_src, packet_size=54, frame_time=event["time"])
        # ACK
        self.add_virtualpacket("tcp", Protocol.TCP, ip_src, ip_dst, port_src, port_dst, packet_size=54, frame_time=event["time"])

        # HTTP Request
        self.add_virtualpacket("tcp", Protocol.TCP, ip_src, ip_dst, port_src, port_dst, packet_size=random.randint(223, 320), frame_time=event["time"])
        
        # ACK
        self.add_virtualpacket("tcp", Protocol.TCP, ip_dst, ip_src, port_dst, port_src, packet_size=54, frame_time=event["time"])
        
        # HTTP Response
        self.add_virtualpacket("tcp", Protocol.TCP, ip_dst, ip_src, port_dst, port_src, packet_size=random.randint(268, 425), frame_time=event["time"])
        
        
        event["virtualpackets"] = self.get_virtualpackets()
        
        yield None
