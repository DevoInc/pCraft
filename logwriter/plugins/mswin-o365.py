import random
from datetime import datetime
import uuid

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "mswin_o365"
    active_layer = "no-active-layer"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("mswin_o365.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass
        
    def template_to_log(self, packet, kvdict):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))

        event = self.retrieve_template("microsoft.o365", kvdict["event_id"], kvdict)
        event = frame_time.strftime(event)

        return event

    def run(self, cap, packet, pktid, kvdict):
        self.log_fp.write(self.template_to_log(packet, kvdict))
