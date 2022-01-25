import random

from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

from .libcs import *

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])
        
        event = build_variables(self, event)
        event = build_pid_variables(self, event)
        
        event = template_get_event(templates, "ProcessRollup2", event["variables"])
        event = frame_time.strftime(event)
        
        yield bytes(event, "utf8")
