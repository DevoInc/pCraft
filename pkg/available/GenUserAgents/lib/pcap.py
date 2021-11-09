#!/usr/bin/env python3
import json

from pcraft.LibraryContext import *

class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event):
        event["variables"]["$user-agent"] = self.get_random_user_agent()
            
        payload = bytes(json.dumps(event["variables"]), "utf8")

        yield "custom", payload
        
