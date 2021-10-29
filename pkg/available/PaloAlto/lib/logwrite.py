#!/usr/bin/env python3
import json
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

        event = template_get_event(templates, event_name, event["variables"])
        event = frame_time.strftime(event)
        
        yield bytes(event, "utf8")
