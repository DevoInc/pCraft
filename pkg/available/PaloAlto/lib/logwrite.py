#!/usr/bin/env python3
import json
import random
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

from .appidize import appid
from .pacommon import *

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.is_first = True

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

        event["variables"]["$Application"] = guess_application(event)
        
        logevent = template_get_event(templates, event_name, event["variables"])
        logevent = frame_time.strftime(logevent)
        
        yield bytes(logevent, "utf8")
