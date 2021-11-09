import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])
        
        event["variables"]["$eventID"] = self.gen_uuid(event, "$eventID")

        logevent = template_get_event(templates, event["variables"]["$event_id"], event["variables"])
        logevent = frame_time.strftime(logevent)

        yield bytes(logevent, "utf8")
