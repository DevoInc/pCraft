import random
from datetime import datetime
from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "syslog"
    active_layer = "syslog"
    
    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("syslog.log")
        print("opening syslog.log")
        
    def __del__(self):
        self.closelog()
    
    def validate_keys(self, kvdict):
        pass

    def template_to_log(self, packet):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))        

        variables = {"msg": packet.syslog.msg}
        try:
            variables["timestamp_rfc3164"] = packet.syslog.timestamp_rfc3164
        except:
            pass
        try:
            variables["hostname"] = packet.syslog.hostname
        except:
            pass
        try:
            variables["procid"] = packet.syslog.procid
        except:
            pass
        try:
            variables["msgid"] = packet.syslog.msgid
        except:
            pass
        try:
            variables["facility"] = packet.syslog.facility
        except:
            pass
        try:
            variables["level"] = packet.syslog.level
        except:
            pass
        
        event = self.retrieve_template("syslog", "msg", variables)
        event = frame_time.strftime(event)

        return event

    def run(self, cap, packet, pktid, layer):
        self.log_fp.write(self.template_to_log(packet))

