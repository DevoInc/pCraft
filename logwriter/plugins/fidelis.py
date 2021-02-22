import random
from datetime import datetime
from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "fidelis"
    active_layer = "no-active-layer"
    
    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("fidelis_cybersecurity.log")
        
    def __del__(self):
        self.closelog()
    
    def validate_keys(self, kvdict):
        pass

    def template_to_log(self, packet, kvdict):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))        

        log_flavor = ""
        try:
            log_flavor = kvdict["log_flavor"]
        except:
            log_flavor = "logstash14"
        
        event = self.retrieve_template("fidelis.cef0", "default", kvdict)
        event = frame_time.strftime(event)

        return event

    def run(self, cap, packet, pktid, kvdict):
        self.log_fp.write(self.template_to_log(packet, kvdict))

