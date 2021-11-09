import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__(service="dns")

    def run(self, event, config, templates):
        # if "$port-dst" not in event["variables"]:
        event["variables"]["$port-dst"] = self.get_variable("$port-dst")
        # if "$port-src" not in event["variables"]:
        event["variables"]["$port-src"] = self.get_variable("$port-src")        
        # if "$ip-dst" not in event["variables"]:
        event["variables"]["$ip-dst"] = self.get_variable("$resolver")
        # if "$ip-src" not in event["variables"]:
        event["variables"]["$ip-src"] = self.get_variable("$ip-src")

        event["variables"]["$protocol"] = self.get_variable("$protocol")

        yield None
