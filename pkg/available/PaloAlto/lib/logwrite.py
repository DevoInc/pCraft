#!/usr/bin/env python3
import json
import random
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

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

        bytes_sent = random.randint(512, 8192)
        bytes_received = random.randint(256, 2048)

        event["variables"]["$Session ID"] = random.randint(123, 950432)

        event["variables"]["$Source Location"] = self.get_country_for_ip(event["variables"]["$ip-src"])
        event["variables"]["$Destination Location"] = self.get_country_for_ip(event["variables"]["$ip-dst"])
        event["variables"]["$Bytes Sent"] = str(bytes_sent)
        event["variables"]["$Bytes Received"] = str(bytes_received)
        event["variables"]["$Bytes"] = str(bytes_sent + bytes_received)

        event["variables"]["$Source VM UUID"] = self.gen_uuid_fixed(event, "$ip-src")
        event["variables"]["$Destination VM UUID"] = self.gen_uuid_fixed(event, "$ip-dst")

        logevent = template_get_event(templates, event_name, event["variables"])
        logevent = frame_time.strftime(logevent)
        
        yield bytes(logevent, "utf8")
