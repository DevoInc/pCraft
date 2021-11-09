import hashlib
import json

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()

    def run(self, event, config, templates):
        event["variables"]["$eventID"] = self.gen_uuid(event, "$eventID")
        
        consistent_id = self.get_consistent_id(event["variables"]["$eventID"], 12)
        
        event["variables"]["$recipientAccountId"] = consistent_id
        event["variables"]["$userIdentity_accountId"] = consistent_id
        event["variables"]["$userIdentity_arn"] = "arn:aws:iam::%s:root" % consistent_id
        event["variables"]["$userIdentity_principalId"] = consistent_id
        
        event = template_get_event(templates, event["variables"]["$event_id"], event["variables"])
        yield bytes(event, "utf8")

