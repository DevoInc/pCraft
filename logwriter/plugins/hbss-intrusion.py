import random
from datetime import datetime
import uuid

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "mcafee_intrusion"
    active_layer = "no-active-layer"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("hbss_intrusion.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass
        # self.do_validate_keys("mcafee.hbss", "intrusion", kvdict)               
        
    def template_to_log(self, frame_time, kvdict):
        event = self.retrieve_template("mcafee.hbss", "intrusion", kvdict)
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
