import random
from datetime import datetime
import uuid
import pprint

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "suricata"
    active_layer = "no-active-layer"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("suricata_fast.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass
        
    def template_to_log(self, frame_time, kvdict):
        try:
            kvdict["sip"] = kvdict["$ip-src"]
        except:
            pass
        try:
            kvdict["dip"] = kvdict["$ip-dst"]
        except:
            pass
        try:
            kvdict["sport"] = kvdict["$port-src"]
        except:
            pass
        try:
            kvdict["dport"] = kvdict["$port-dst"]
        except:
            pass

        event = self.retrieve_template("suricata", "fast", kvdict)
        
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
