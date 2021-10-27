import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        try:                    
            event["variables"]["$targets_0_login"] = event["variables"]["$username"]
        except:
            pass
        try:                    
            event["variables"]["$targets_0_displayName"] = event["variables"]["$username"]
        except:
            pass
        try:                    
            event["variables"]["$actors_0_displayName"] = event["variables"]["$username"]
        except:
            pass
        try:                    
            event["variables"]["$actors_1_ipAddress"] = event["variables"]["$ip-src"]
        except:
            pass
        try:                    
            event["variables"]["$actors_0_login"] = event["variables"]["$username"]
        except:
            pass
        try:
            event["variables"]["$actors_1_id"] = event["variables"]["$user-agent"]
        except:
            pass
        try:
            event["variables"]["$action_requestUri"] = event["variables"]["$uri"]
        except:
            pass
        
        event = template_get_event(templates, "events", event["variables"])
        event = frame_time.strftime(event)

        yield bytes(event, "utf8")
