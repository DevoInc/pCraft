import json
from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__(service="http")

    def run(self, event, config, templates):
        self.set_variables_if_generated(event, ["$port-dst", "$port-src", "$ip-dst", "$ip-src", "$protocol"])
        
        yield None
