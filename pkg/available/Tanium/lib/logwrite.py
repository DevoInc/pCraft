#!/usr/bin/env python3
import json
from datetime import datetime
import random
import uuid
import hashlib

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        
    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        if not "$tanium_mac_address" in event["variables"]:
            event["variables"]["$tanium_mac_address"] = self.get_consistent_macaddr(event["variables"]["$ip-src"])
        
        log_event = template_get_event(templates, "installedapps", event["variables"])
        log_event = frame_time.strftime(log_event)

        yield bytes(log_event, "utf8")

