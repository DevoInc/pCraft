#!/usr/bin/env python3
import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

from .libcs import *

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])
        
        event = build_variables(self, event)
        
        if "$TargetProcessId" in event["variables"]:
            event["variables"]["$ContextProcessId"] = event["variables"]["$TargetProcessId"]
            
        eventlog = template_get_event(templates, "NetworkConnectIP4", event["variables"])
        eventlog = frame_time.strftime(eventlog)

        # If we have the TargetProcessId defined, that means this network connection
        # was launched from a monitored process. Then we write the log. If not we skip.
        if "$TargetProcessId" in event["variables"]:
            yield bytes(eventlog, "utf8")
        else:
            yield None
