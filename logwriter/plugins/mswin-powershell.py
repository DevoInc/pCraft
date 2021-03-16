import random
from datetime import datetime
import uuid

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "mswin_powershell"
    active_layer = "no-active-layer"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("mswin_powershell.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        self.do_validate_keys("microsoft.windows.powershell.logstash14", kvdict["event_id"], kvdict)

    def template_to_log(self, frame_time, kvdict):

        log_flavor = ""
        try:
            log_flavor = kvdict["log_flavor"]
        except:
            log_flavor = "logstash14"
        
        event = self.retrieve_template("microsoft.windows.powershell.%s" % (log_flavor), kvdict["event_id"], kvdict)
        event = frame_time.strftime(event)

        return event

    def run(self, cap, packet, pktid, kvdict):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        self.log_fp.write(self.template_to_log(frame_time, kvdict))

    def run_ccraft(self, event, kvdict):
        frame_time = datetime.fromtimestamp(int(event["time"]))
        self.log_fp.write(self.template_to_log(frame_time, kvdict))
        
    def run_buffer(self, action, event_time, kvdict):        
        frame_time = datetime.fromtimestamp(event_time)
        return self.db_to_log(frame_time, kvdict)
