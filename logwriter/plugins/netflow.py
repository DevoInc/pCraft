import random
from datetime import datetime

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "netflow"
    active_layer = "ip"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("netflow_v9.log")
        
        self.flowseq = 673559668
        
    def __del__(self):
        self.closelog()

    def get_flowseq(self):
        self.flowseq = self.flowseq + 1
        return str(self.flowseq)
        
    def get_dstport(self, packet):
        if hasattr(packet, 'tcp'):
            return packet.tcp.dstport
        if hasattr(packet, 'udp'):
            return packet.udp.dstport
        return ""
        
    def get_srcport(self, packet):
        if hasattr(packet, 'tcp'):
            return packet.tcp.srcport
        if hasattr(packet, 'udp'):
            return packet.udp.srcport        
        return ""        
        
    def validate_keys(self, kvdict):
        pass
        
    def run(self, cap, packet, pktid, layer):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        generate_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        
        kvdict = {
            "srcip": packet.ip.src,
            "dstip": packet.ip.dst,
            "srcport": self.get_srcport(packet),
            "dstport": self.get_dstport(packet),
            "headerdate": str(int(float(packet.sniff_timestamp))) + "000",
            "firstdate": str(int(float(packet.sniff_timestamp))) + "000", 
            "lastdate": str(int(float(packet.sniff_timestamp))) + "000",
            "bytes": str(random.randint(108, 5000)),
            "flowseq": self.get_flowseq(),            
        }

        event = self.retrieve_template("netflow", "v9", kvdict)
        event = frame_time.strftime(event)
        
        self.log_fp.write(event)

    def run_ccraft(self, event, kvdict):
        event_time = str(int(event["time"]))
        variables = {}
        try:
            variables["srcip"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["dstip"] = kvdict["$ip-dst"]
        except:
            pass
        try:
            variables["srcport"] = kvdict["$port-src"]
        except:
            variables["srcport"] = str(random.randint(5000, 65530))
        try:
            variables["dstport"] = kvdict["$port-dst"]
        except:
            variables["dstport"] = str(random.randint(5000, 65530))            
        try:
            variables["nexthop"] = kvdict["$nexthop"]
        except:
            pass
        try:
            variables["bnh"] = kvdict["$bnh"]
        except:
            pass
        

        variables["headerdate"] = event_time + "000"
        variables["firstdate"] = event_time + "000"
        variables["lastdate"] = event_time + "000"
        variables["bytes"] = str(random.randint(108, 5000))
        variables["flowseq"] = self.get_flowseq()

        event = self.retrieve_template("netflow", "v9", variables)

        frame_time = datetime.fromtimestamp(int(event_time))
        event = frame_time.strftime(event)
        
        self.log_fp.write(event)
        
    def run_buffer(self, action, event_time, kvdict):
        action_exec = action.Exec()
        
        event_time = str(event_time)
        variables = {}
        try:
            variables["srcip"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["dstip"] = kvdict["$ip-dst"]
        except:
            pass
        try:
            variables["srcport"] = kvdict["$port-src"]
        except:
            variables["srcport"] = str(random.randint(5000, 65530))
        try:
            variables["dstport"] = kvdict["$port-dst"]
        except:
            variables["dstport"] = str(random.randint(5000, 65530))

        try:
            proto = kvdict["$protocol"]
            proto_n = 0
            if proto == "tcp":
                proto_n = 6                
            elif proto == "udp":
                proto_n = 17
            elif proto == "icmp":
                proto_n = 1
                
            variables["proto"] = str(proto_n)
        except:
            pass
            
        variables["headerdate"] = event_time + "000"
        variables["firstdate"] = event_time + "000"
        variables["lastdate"] = event_time + "000"
        variables["bytes"] = str(random.randint(108, 5000))
        variables["flowseq"] = self.get_flowseq()

        event = self.retrieve_template("netflow", "v9", variables)

        frame_time = datetime.fromtimestamp(int(event_time))
        event = frame_time.strftime(event)
        
        return event
        
