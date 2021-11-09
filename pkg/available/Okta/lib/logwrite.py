import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        # if "@" not in event["variables"]["$actors_0_login"]:
        #     event["variables"]["$actors_0_login"] += "@" + event["variables"]["$domain"]

        # if "@" not in event["variables"]["$targets_0_login"]:
        #     event["variables"]["$actors_0_login"] += "@" + event["variables"]["$domain"]
            
        logevent = template_get_event(templates, "events", event["variables"])
        logevent = frame_time.strftime(logevent)

        yield bytes(logevent, "utf8")
