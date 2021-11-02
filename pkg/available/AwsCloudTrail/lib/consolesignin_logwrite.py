import json

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        event["variables"]["$eventID"] = self.get_uuid(event, "$eventID")
        event = template_get_event(templates, event["variables"]["$event_id"], event["variables"])
        yield bytes(event, "utf8")
