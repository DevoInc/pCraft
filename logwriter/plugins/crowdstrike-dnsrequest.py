import random
from datetime import datetime
from logwriter.LogContext import LogContext
import uuid

class LogPlugin(LogContext):
    name = "crowdstrike-dnsrequest"
    active_layer = "dns"
    
    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("crowdstrike_dnsrequest.log")
        
    def __del__(self):
        self.closelog()
    
    def validate_keys(self, kvdict):
        pass

    def get_platform(self):
        choice = ["Mac", "Mac", "Mac", "Mac", "Mac", "Win", "Win", "Win", "Win", "Win"]
        return choice[random.randint(1, 10)]
        
    def packet_to_log(self, packet):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))        
        variables = {}
        variables["ContextProcessId"] = random.randint(1000000000,9000000000)
        variables["ContextThreadId"] = random.randint(100000000,900000000)
        variables["ConfigStateHash"] = random.randint(10000000,90000000)        
        variables["aip"] = packet.ip.src
        variables["event_platform"] = self.get_platform()
        variables["id"] = str(uuid.uuid5(uuid.NAMESPACE_DNS, packet.ip.src))
        variables["DomainName"] = packet.dns.qry_name
        variables["ContextTimeStamp"] = str(int(float(packet.sniff_timestamp)))
        variables["timestamp"] = str(int(float(packet.sniff_timestamp)))        
        event = self.retrieve_template("crowdstrike", "DnsRequest", variables)

        return event

    def db_to_log(self, frame_time, kvdict):
        variables = {}
        try:
            variables["aip"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["DomainName"] = kvdict["$domain"]
        except:
            pass

        variables["timestamp"] = frame_time.timestamp()
        variables["ContextTimeStamp"] = str(frame_time.timestamp()) + ".000"
        
        event = self.retrieve_template("crowdstrike", "DnsRequest", variables)        
        
        return event

    def is_request(self, packet):
        if packet.dns.flags == "0x00000100":
            return True

        return False
    
    def run(self, cap, packet, pktid, layer):
        # fields = layer.field_names
        # for field in fields:
        #     print("%s -> %s" % (field, layer.get_field_value(field)))

        if self.is_request(packet):
            self.log_fp.write(self.packet_to_log(packet))

    def run_ccraft(self, event, kvdict):
        frame_time = datetime.fromtimestamp(int(event["time"]))
        self.log_fp.write(self.db_to_log(frame_time, kvdict))

    def run_buffer(self, action, event_time, kvdict):        
        frame_time = datetime.fromtimestamp(event_time)
        return self.db_to_log(frame_time, kvdict)
        
