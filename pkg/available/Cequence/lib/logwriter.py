#!/usr/bin/env python3
import os
import random
from datetime import datetime
import base64

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        
    def run(self, event, config, templates):
        event_name = "botdefense"
        
        frame_time = datetime.fromtimestamp(event["time"])

        try:
            if event["variables"]["$extractedData"] != "":
                event["variables"]["$extractedData"] = base64.b64encode(bytes(event["variables"]["$extractedData"], "utf8"))
        except KeyError:
            event["variables"]["$extractedData"] = ""
        
        newevent = template_get_event(templates, event_name, event["variables"])
        newevent = frame_time.strftime(newevent)

        yield bytes(newevent, "utf8")

