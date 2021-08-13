import random
from datetime import datetime
import uuid

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "cloudtrail"
    active_layer = "no-active-layer"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.logs = {}
        
        self.logs["AwsConsoleSignIn"] = self.openlog("cloudtrail_awsconsolesignin.log")
        self.logs["AwsApiCall"] = self.openlog("cloudtrail_awsapicall.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass
        
    def template_to_log(self, frame_time, kvdict):
        eventtype = kvdict["eventType"]

        if eventtype not in ["AwsApiCall", "AwsConsoleAction", "AwsConsoleSignIn", "AwsServiceEvent"]:
            raise ValueError("eventType for cloudtrail must be in the list: AwsApiCall, AwsConsoleAction, AwsConsoleSignIn or AwsServiceEvent")
        
        eventsubtype = kvdict["eventSubType"]

        event_template = "aws.cloudtrail.%s." % (eventtype)
        
        event = self.retrieve_template(event_template, eventsubtype, kvdict)        
        event = frame_time.strftime(event)

        return event

    def run(self, cap, packet, pktid, kvdict):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        self.logs[kvdict["eventType"]].write(self.template_to_log(frame_time, kvdict))

    def run_ccraft(self, event, kvdict):
        frame_time = datetime.fromtimestamp(int(event["time"]))
        self.logs[kvdict["eventType"]].write(self.template_to_log(frame_time, kvdict))
        
    def run_buffer(self, action, event_time, kvdict):        
        frame_time = datetime.fromtimestamp(event_time)
        return self.db_to_log(frame_time, kvdict)
