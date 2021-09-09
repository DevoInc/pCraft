from datetime import datetime
from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "gcp"
    active_layer = "no-active-layer"
    logcalls = ["Auth.Login"]
    
    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("gcp.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass

    def template_to_log(self, frame_time, kvdict):
        event = self.retrieve_template("google.gcp", "login_password", kvdict)
        event = frame_time.strftime(event)
        
        return event
        
    def run(self, cap, packet, pktid, kvdict):
        pass
    
    def run_ccraft(self, event, kvdict, logcall=None):
        frame_time = datetime.fromtimestamp(int(event["time"]))
        
        if logcall:
            if logcall == "Auth.Login":
                try:                    
                    kvdict["actor_email"] = kvdict["$username"]
                except:
                    pass
                try:                    
                    kvdict["ipAddress"] = kvdict["$ip-src"]
                except:
                    pass
            
        log = self.template_to_log(frame_time, kvdict)
        if log:
            self.log_fp.write(log)
        
