import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__(service="dns")

    def run(self, event, config, templates):
        event["variables"]["$port-dst"] = self.get_variable("$port-dst")
        event["variables"]["$port-src"] = self.get_variable("$port-src")        
        event["variables"]["$ip-dst"] = self.get_variable("$ip-dst")
        event["variables"]["$ip-src"] = self.get_variable("$ip-src")
        
        yield None
