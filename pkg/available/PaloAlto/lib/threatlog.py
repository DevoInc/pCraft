#!/usr/bin/env python3
import json
import random
from datetime import datetime
import pathlib

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event, template_get_header

from .appidize import appid
from .filetypize import filetype
from .pacommon import *

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.is_first = True
        self.seq = random.randint(5000000000000000000,9000000000000000000)
        
    def detect(self, event):
        variables = {}
        
        if "$filename" in event["variables"]:
            file_suffix = pathlib.Path(event["variables"]["$filename"]).suffix[1:]
            try:
                fileinfo = filetype[file_suffix]
                variables["$URL/Filename"] = event["variables"]["$filename"]
                variables["$Threat/Content Type"] = "wildfire"
                variables["$Category"] = fileinfo["category"]
                variables["$Threat Id"] = "%s(%s)" % (fileinfo["name"], fileinfo["id"])
                variables["$Severity"] = "informational"
                variables["$Cloud"] = "wildfire.paloaltonetworks.com"                
                variables["$File Type"] = file_suffix
                variables["$File Digest"] = str(self.gen_sha256())
                variables["$Content Version"] = "WildFire-0"
                yield variables
            except:
                pass

        variables = {}
        if "$uri" in event["variables"]:
            variables["$URL/Filename"] = event["variables"]["$uri"]
            if len(event["variables"]["$uri"]) > 128:
                variables["$Threat ID"] = "HTTP GET Requests Long URI Anomaly(30800)"
                variables["$Severity"] = "low"
                variables["$Category"] = "low-risk"
                variables["$Threat/Content Type"] = "vulnerability"
                variables["$Threat Category"] = "overflow"                
                yield variables

    def fill_event(self, event):        
        event["variables"]["$Threat Category"] = "unknown"
        event["variables"]["$Session ID"] = random.randint(123, 950432)
        event["variables"]["$Type"] = "THREAT"
        event["variables"]["$FUTURE_USE"] = "1"
        event["variables"]["$PCAP_ID"] = "0"
        event["variables"]["$Action"] = "alert"
                
        packets = event["virtualpackets"]
        first_packet = packets[0]
        last_packet = packets[-1]
        bytes_sent = first_packet.packet_size
        bytes_received = last_packet.packet_size
        event["variables"]["$Source Location"] = self.get_country_for_ip(event["variables"]["$Source Address"])
        event["variables"]["$Destination Location"] = self.get_country_for_ip(event["variables"]["$Destination Address"])
        
        event["variables"]["$Source VM UUID"] = self.gen_uuid_fixed(event, first_packet.ip_src)
        event["variables"]["$Destination VM UUID"] = self.gen_uuid_fixed(event, first_packet.ip_dst)
        
        event["variables"]["$Application"] = guess_application(event)
        event["variables"]["$Sequence Number"] = self.seq
                
    def run(self, event, config, templates):
        event_name = "threat"

        self.fill_event(event)

        threats_detected = self.detect(event)
        for threats in threats_detected:
            self.seq += 1

            frame_time = datetime.fromtimestamp(event["time"])
            try:
                event_name = event["variables"]["$event_name"]
            except:
                pass                
            new_event = event
            
            if self.is_first:
                self.is_first = False
                header = template_get_header(templates, event_name)
                yield bytes(header, "utf8")
        
            for k,v in threats.items():
                new_event["variables"][k] = v
                               
            logevent = template_get_event(templates, event_name, new_event["variables"])
            logevent = frame_time.strftime(logevent)
                
            yield bytes(logevent, "utf8")
