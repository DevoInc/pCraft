import random
from datetime import datetime
from logwriter.LogContext import LogContext
from dateutil import parser
from IPy import IP

class LogPlugin(LogContext):
    name = "syslog"
    active_layer = "ntp"
    
    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("corelight_ntp.log")
        
    def __del__(self):
        self.closelog()
    
    def validate_keys(self, kvdict):
        pass

    # Converts
    # From -> Feb  3, 2021 09:22:55.283947568 UTC
    # To   -> 2021-02-23T08:12:34.849311Z
    def translate_time(self, otime):
        date = parser.parse(str(otime))
        return date.strftime("%Y-%m-%dT%H:%M:%S.%fZ")

    def get_dstport(self, packet):
        if hasattr(packet, 'tcp'):
            return packet.tcp.dstport
        if hasattr(packet, 'udp'):
            return packet.udp.dstport

    def get_srcport(self, packet):
        if hasattr(packet, 'tcp'):
            return packet.tcp.srcport
        if hasattr(packet, 'udp'):
            return packet.udp.srcport
    
    def template_to_log(self, packet):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))        
        variables = {
            "flags": packet.ntp.flags,
            "flags_li": packet.ntp.flags_li,
            "version": packet.ntp.flags_vn,
            "mode": packet.ntp.flags_mode,
            "stratum": packet.ntp.stratum,
            "poll": packet.ntp.ppoll,
            "precision": packet.ntp.precision,
            "root_delay": packet.ntp.rootdelay,
            "root_disp": packet.ntp.rootdispersion,
            "ref_id": packet.ntp.refid,
        }

        try:
            variables["ref_time"] = self.translate_time(packet.ntp.reftime)
        except:
            pass

        try:
            variables["org_time"] = self.translate_time(packet.ntp.org),
        except:
            pass
        try:            
            variables["rec_time"] = self.translate_time(packet.ntp.rec),
        except:
            pass
        try:
            variables["xmt_time"] = self.translate_time(packet.ntp.xmt),
        except:
            pass    
        try:
            variables["keyid"] = packet.ntp.keyid,
        except:
            pass
        try:
            variables["mac"] = packet.ntp.mac,
        except:
            pass
        
        variables["orig_h"] = IP(packet.ip.src)
        variables["orig_p"] = self.get_srcport(packet)
        variables["resp_h"] = IP(packet.ip.dst)
        variables["resp_p"] = self.get_dstport(packet)
        
        event = self.retrieve_template("corelight", "ntp", variables)
        event = frame_time.strftime(event)

        return event

    def run(self, cap, packet, pktid, layer):
        return # disabling for now
        self.log_fp.write(self.template_to_log(packet))
        
