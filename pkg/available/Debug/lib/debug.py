#!/usr/bin/env python3
from pcraft.LibraryContext import *

class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event):
        print(str(event["variables"]))
        yield "debug", ""
        
