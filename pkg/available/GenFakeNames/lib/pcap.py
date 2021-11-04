#!/usr/bin/env python3
import json

from pcraft.LibraryContext import *
from .fakeme import PcraftGenFakeNames

class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.fake = PcraftGenFakeNames()

    def run(self, event):
        fakenames = self.fake.get_fake_name(event)
        for k, v in fakenames.items():
            event["variables"][k] = v
        
        payload = bytes(json.dumps(event["variables"]), "utf8")

        yield "custom", payload
        

