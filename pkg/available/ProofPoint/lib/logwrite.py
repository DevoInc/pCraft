#!/usr/bin/env python3
import json
from datetime import datetime
import random

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        
    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        if "$sendmail_pid" not in event["variables"]:
            event["variables"]["$sendmail_pid"] = random.randint(10000,65000)
        if "$sm_qid" not in event["variables"]:
            event["variables"]["$sm_qid"] = random.randint(10000,65000)
        if "$sm_pri" not in event["variables"]:
            event["variables"]["$sm_pri"] = random.randint(35000,65000)
        if "$sm_qid" not in event["variables"]:
            event["variables"]["$sm_qid"] = self.gen_string_withuppercase(14)
        if "$id" not in event["variables"]:
            event["variables"]["$id"] = self.gen_string_withuppercase(22)
            
        event = template_get_event(templates, "maillogoneline", event["variables"])
        event = frame_time.strftime(event)

        yield bytes(event, "utf8")
