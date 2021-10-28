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

        print(event)
        
        username = None
        try:
            username = event["variables"]["$username"]
        except:
            pass

        if username:
            if not "$owner_login" in event["variables"]:
                event["variables"]["$owner_login"] = username
        
        event = template_get_event(templates, event["variables"]["$event_id"], event["variables"])
        event = frame_time.strftime(event)

        yield bytes(event, "utf8")