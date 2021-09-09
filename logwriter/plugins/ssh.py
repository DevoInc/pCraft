from datetime import datetime
from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "ssh"
    active_layer = "no-active-layer"
    logcalls = ["Auth.Login"]
    
    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("syslog_ssh.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass

    def template_to_log(self, frame_time, kvdict):
        event = self.retrieve_template("syslog.ssh", "connection-withkey", kvdict)
        event = frame_time.strftime(event)
        
        return event
        
    def run(self, cap, packet, pktid, kvdict):
        pass
    
    def run_ccraft(self, event, kvdict, logcall=None):
        frame_time = datetime.fromtimestamp(int(event["time"]))

        print("Run ccraft for SSH! \o/")
        
        if logcall:
            if logcall == "Auth.Login":
                kvdict = {}
                try:                    
                    kvdict["username"] = kvdict["$username"]
                except:
                    pass
                try:                    
                    kvdict["srcip"] = kvdict["$ip-src"]
                except:
                    pass
            
        log = self.template_to_log(frame_time, kvdict)
        if log:
            self.log_fp.write(log)
        
