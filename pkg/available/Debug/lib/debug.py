#!/usr/bin/env python3
from pcraft.LibraryContext import *
from pcraft.Packet import *

class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event):
        print(str(event["variables"]))
        yield PcraftPacket("debug", "")
        
class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        
    def run(self, event, config, templates):
        print(str(event))
        yield None
        
        
