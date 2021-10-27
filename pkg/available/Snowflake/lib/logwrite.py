#!/usr/bin/env python3
import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        
    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        event_id = "logins"
        try:
            event_id = event["variables"]["$event_id"]
        except:
            pass

        try:
            if not "$USER_NAME" in event["variables"]:
                event["variables"]["$USER_NAME"] = event["variables"]["$username"]
        except:
            pass
        
        event = template_get_event(templates, event_id, event["variables"])
        event = frame_time.strftime(event)

        yield bytes(event, "utf8")
