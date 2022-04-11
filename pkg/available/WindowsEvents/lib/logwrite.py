#!/usr/bin/env python3
import json
from datetime import datetime
import random

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.RecordNumber = random.randint(100000, 110000)
        
    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        event["variables"]["$RecordNumber"] = str(self.RecordNumber)
        self.RecordNumber += 1
        event = template_get_event(templates, event["variables"]["$event_id"], event["variables"])
        event = frame_time.strftime(event)

        yield bytes(event, "utf8")
