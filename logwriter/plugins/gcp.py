from datetime import datetime

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "gcp"
    active_layer = "no-active-layer"

    def __init__(self, outpath):
        super().__init__(outpath)

        self.logs = {}       
        self.logs["leaderelection"] = self.openlog("gcp_leaderelection.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass
        
    def template_to_log(self, frame_time, kvdict):
        eventtype = kvdict["eventtype"]

        if eventtype not in ["leaderelection"]:
            raise ValueError("eventType for google gcp must be in the list: leaderelection")
        
        event_template = "google.gcp"
        
        event = self.retrieve_template(event_template, eventtype, kvdict)        
        event = frame_time.strftime(event)

        return event

    def run(self, cap, packet, pktid, kvdict):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        self.logs["leaderelection"].write(self.template_to_log(frame_time, kvdict))

    def run_ccraft(self, event, kvdict):
        frame_time = datetime.fromtimestamp(int(event["time"]))
        self.logs["leaderelection"].write(self.template_to_log(frame_time, kvdict))
        
    def run_buffer(self, action, event_time, kvdict):        
        frame_time = datetime.fromtimestamp(event_time)
        return self.db_to_log(frame_time, kvdict)
