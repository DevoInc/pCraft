#!/usr/bin/env python3
import json
import random
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        event_name = "connection-opened"
        frame_time = datetime.fromtimestamp(event["time"])
        try:
            event_name = event["variables"]["$event_name"]
        except:
            pass

        event["variables"]["$n"] = random.randint(123, 950432)

        logevent = template_get_event(templates, event_name, event["variables"])
        logevent = frame_time.strftime(logevent)
        
        yield bytes(logevent, "utf8")
