import random

from datetime import datetime

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        first_pid = random.randint(10000000000000,99000000000000)        
        event["variables"]["$ParentProcessId"] = str(first_pid)
        event["variables"]["$SourceProcessId"] = str(first_pid)
        event["variables"]["$SessionProcessId"] = str(first_pid + random.randint(10, 300))
        event["variables"]["$ProcessGroupId"] = str(first_pid + random.randint(300, 10000))
        event["variables"]["$TargetProcessId"] = str(first_pid + random.randint(5000, 30000))
        
        event["variables"]["$aid"] = self.gen_uuid(event["variables"]["$aip"])
        event["variables"]["$id"] = self.gen_uuid(event)
        event["variables"]["$MD5HashData"] = self.gen_md5()
        event["variables"]["$SHA256HashData"] = self.gen_sha256()
        
        event = template_get_event(templates, "processrollup2", event["variables"])
        event = frame_time.strftime(event)
        
        yield bytes(event, "utf8")
