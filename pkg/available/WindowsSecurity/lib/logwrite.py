#!/usr/bin/env python3
import json

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        event = template_get_event(templates, event["variables"]["$event_id"], event["variables"])
        yield bytes(event, "utf8")
