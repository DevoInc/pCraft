import random
from datetime import datetime
import uuid

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "mswin_o365"
    active_layer = "no-active-layer"
    logcalls = ["Auth.Login"]

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("mswin_o365.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass
        
    def template_to_log(self, frame_time, kvdict):
        event = self.retrieve_template("microsoft.o365", "exchange", kvdict)
        event = frame_time.strftime(event)

        return event

    def run(self, cap, packet, pktid, kvdict):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        self.log_fp.write(self.template_to_log(frame_time, kvdict))

    def run_ccraft(self, event, kvdict, logcall=None):

        if logcall:
            if logcall == "Auth.Login":
                frame_time = datetime.fromtimestamp(int(event["time"]))
                try:                    
                    kvdict["UserId"] = kvdict["$username"]
                except:
                    pass
                try:                  
                    kvdict["Actor_1_ID"] = kvdict["$username"]
                except:
                    pass
                try:                    
                    kvdict["Actor_0_ID"] = str(uuid.uuid5(uuid.NAMESPACE_DNS, kvdict["$username"]))
                except:
                    pass
                try:                    
                    kvdict["ActorIpAddress"] = kvdict["$ip-src"]
                except:
                    pass
                try:                    
                    kvdict["ClientIP"] = kvdict["$ip-src"]
                except:
                    pass
                
                event = self.retrieve_template("microsoft.azure.activedirectory", "UserLoggedIn", kvdict)
                event = frame_time.strftime(event)
                self.log_fp.write(event)
            else:
                frame_time = datetime.fromtimestamp(int(event["time"]))
                self.log_fp.write(self.template_to_log(frame_time, kvdict))
                
    def run_buffer(self, action, event_time, kvdict):        
        frame_time = datetime.fromtimestamp(event_time)
        return self.db_to_log(frame_time, kvdict)
