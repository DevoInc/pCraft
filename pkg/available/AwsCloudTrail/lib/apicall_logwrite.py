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

        if "$portrange" in event["variables"]:
            portfrom, portto = event["variables"]["$portrange"].split("-")
            event["variables"]["$requestParameters_portRange"] = "{\"from\": %s, \"to\": %s}" % (portfrom, portto)
        else:
            event["variables"]["$requestParameters_portRange"] = "{}"

        event = template_get_event(templates, event["variables"]["$event_id"], event["variables"])
        event = frame_time.strftime(event)
        
        yield bytes(event, "utf8")
