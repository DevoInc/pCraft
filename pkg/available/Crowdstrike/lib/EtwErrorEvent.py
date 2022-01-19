#!/usr/bin/env python3
import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        event = template_get_event(templates, "EtwErrorEvent", event["variables"])
        event = frame_time.strftime(event)
        
        yield bytes(event, "utf8")
