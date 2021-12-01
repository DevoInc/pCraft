#!/usr/bin/env python3
import json
import random
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

from .appidize import appid

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.is_first = True

    def guess_application(self, event):
        # We will need to parse appidize standard_ports and check the domain to map more applications
        if event["variables"]["$Protocol"] == "udp":
            if event["variables"]["$Destination Port"] == "53" or event["variables"]["$Source Port"] == "53":
                return "dns"

        if event["variables"]["$Protocol"] == "tcp":
            if event["variables"]["$Destination Port"] == "80" or event["variables"]["$Source Port"] == "80":
                return "web-browsing"

        if event["variables"]["$Protocol"] == "tcp":
            if event["variables"]["$Destination Port"] == "443" or event["variables"]["$Source Port"] == "443":
                return "web-browsing"

        # If unknown, return the most likely possiblity
        return "web-browsing"
            
    def run(self, event, config, templates):
        event_name = "traffic"
        if self.is_first:
            self.is_first = False
            header = template_get_header(templates, event_name)
            yield bytes(header, "utf8")

        frame_time = datetime.fromtimestamp(event["time"])
        try:
            event_name = event["variables"]["$event_name"]
        except:
            pass

        event["variables"]["$Session ID"] = random.randint(123, 950432)

        packets = event["virtualpackets"]
        first_packet = packets[0]
        last_packet = packets[-1]
        bytes_sent = first_packet.packet_size
        bytes_received = last_packet.packet_size
        event["variables"]["$Source Location"] = self.get_country_for_ip(event["variables"]["$Source Address"])
        event["variables"]["$Destination Location"] = self.get_country_for_ip(event["variables"]["$Destination Address"])
        event["variables"]["$Bytes Sent"] = str(bytes_sent)
        event["variables"]["$Bytes Received"] = str(bytes_received)
        event["variables"]["$Bytes"] = str(bytes_sent + bytes_received)

        event["variables"]["$Source VM UUID"] = self.gen_uuid_fixed(event, first_packet.ip_src)
        event["variables"]["$Destination VM UUID"] = self.gen_uuid_fixed(event, first_packet.ip_dst)

        event["variables"]["$Application"] = self.guess_application(event)
        
        logevent = template_get_event(templates, event_name, event["variables"])
        logevent = frame_time.strftime(logevent)
        
        yield bytes(logevent, "utf8")
