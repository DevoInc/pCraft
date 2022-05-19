#!/usr/bin/env python3
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.is_first = True
        
    def run(self, event, config, templates):
        if self.is_first:
            self.is_first = False
            header = template_get_header(templates, "accessw3c")
            yield bytes(header, "utf8")

        frame_time = datetime.fromtimestamp(event["time"])
        
        event = template_get_event(templates, "accessw3c", event["variables"])
        event = frame_time.strftime(event)

        yield bytes(event, "utf8")

