import random
from datetime import datetime
import uuid

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "mswin_security"
    active_layer = "no-active-layer"
    logcalls = ["Auth.Login"]
    
    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("mswin_security.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        try:
            self.do_validate_keys("microsoft.windows.security.logstash14", kvdict["event_id"], kvdict)
        except:
            print("No such event id:%s" % kvdict["event_id"])
        
    def template_to_log(self, frame_time, kvdict):
        log_flavor = ""
        try:
            log_flavor = kvdict["log_flavor"]
        except:
            log_flavor = "logstash14"

        try:
            event = self.retrieve_template("microsoft.windows.security.%s" % (log_flavor), kvdict["event_id"], kvdict)
        except:
            print("No such event id:%s" % kvdict["event_id"])
            return None
        
        event = frame_time.strftime(event)

        return event
        
    def run(self, cap, packet, pktid, kvdict):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        log = self.template_to_log(frame_time, kvdict)
        if log:
            self.log_fp.write(log)

    def run_ccraft(self, event, kvdict, logcall=None):
        frame_time = datetime.fromtimestamp(int(event["time"]))

        if logcall:
            if logcall == "Auth.Login":
                kvdict = {"event_id": "4624",
                          "winlog_event_data_LogonGuid": uuid.uuid5(uuid.NAMESPACE_DNS, kvdict["$username"]),
                          "winlog_event_data_SubjectUserName": kvdict["$username"],
                          "winlog_event_data_TargetUserName": kvdict["$username"]}
            
        log = self.template_to_log(frame_time, kvdict)
        if log:
            self.log_fp.write(log)
        
    def run_buffer(self, action, event_time, kvdict):        
        frame_time = datetime.fromtimestamp(event_time)
        return self.template_to_log(frame_time, kvdict)
