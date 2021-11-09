
#!/usr/bin/env python3
import json

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

from .fakeme import PcraftGenFakeNames

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.fake = PcraftGenFakeNames()
        
    def run(self, event, config, templates):
        fakenames = self.fake.get_fake_name(event)
        for k, v in fakenames.items():
            event["variables"][k] = v
            
        yield None
