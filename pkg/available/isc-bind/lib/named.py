#!/usr/bin/env python3
import random
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.seq = 0
        
    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(int(event["time"]))

        event["variables"]["$sequence"] = self.seq
        try:
            event["variables"]["$src_ip_addr"] = event["variables"]["$ip-src"]
        except:
            pass

        try:
            event["variables"]["$src_port_number"] = event["variables"]["$port-src"]
        except:
            event["variables"]["$src_port_number"] = random.randint(4096, 65534)

        try:
            event["variables"]["$dns_query_name"] = event["variables"]["$domain"]
        except:
            pass

        try:
            event["variables"]["$dns_query_type"] = event["variables"]["$dns-query-type"]
        except:
            pass

        try:
            event["variables"]["$dns_query_class"] = event["variables"]["$dns-query-class"]
        except:
            pass
        try:
            event["variables"]["$resolver"] = event["variables"]["$resolver"]
        except:
            pass

        event = template_get_event(templates, "query", event["variables"])
        event = frame_time.strftime(event)

        self.seq += 1
        yield bytes(event, "utf8")

