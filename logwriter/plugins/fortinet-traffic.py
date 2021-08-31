import random
from datetime import datetime
import os

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "fortinet-traffic"
    active_layer = "ip"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("fortinet_traffic.log")
                
    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass
        
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

    def get_protocol(self, packet):
        if hasattr(packet, 'tcp'):
            return 6
        if hasattr(packet, 'udp'):
            return 17

    def get_protocol_str(self, protostr):
        if protostr == 'tcp':
            return 6
        if protostr == 'udp':
            return 17
        
    def execute(self, cap, packet, pktid, layer):        
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        generate_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)) - 8)

        bytessent = random.randint(256, 83942)
        bytesreceived = random.randint(10, 1204323)

        packetssent = random.randint(5, 1356)
        packetsreceived = random.randint(5, 1356)

        duration = random.randint(10, 350)
        
        kvdict = {
            "src_int": "eni-1234",
            "src": packet.ip.src,
            "dst": packet.ip.dst,
            "src_port": self.get_srcport(packet),
            "dst_port": self.get_dstport(packet),
            "proto": self.get_protocol(packet),
            "sent_pkt": packetssent,
            "rcvd_pkt": packetsreceived,
            "bytes": bytessent + bytesreceived,
            "duration": duration,
        }

        event = self.retrieve_template("fortinet", "traffic", kvdict)
        event = frame_time.strftime(event)
        
        self.log_fp.write(event)
    
    def run(self, cap, packet, pktid, layer):
        self.execute(cap, packet, pktid, layer)

    def run_ccraft(self, event, kvdict):
        bytessent = random.randint(256, 83942)
        bytesreceived = random.randint(10, 1204323)

        packetssent = random.randint(5, 1356)
        packetsreceived = random.randint(5, 1356)
               
        event_time = str(int(event["time"]))
        frame_time = datetime.fromtimestamp(int(event_time))
        
        duration = random.randint(10, 350)

        variables = {
            "src_int": "eni-1234",
            "src": None,
            "dst": None,
            "src_port": None,
            "dst_port": None,
            "proto": None,
            "sent_pkt": packetssent,
            "rcvd_pkt": packetsreceived,
            "bytes": bytessent + bytesreceived,
            "duration": duration,
        }
        try:
            variables["src"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["dst"] = kvdict["$ip-dst"]
        except:
            pass
        try:
            variables["src_port"] = kvdict["$port-src"]
        except:
            pass
        try:
            variables["dst_port"] = kvdict["$port-dst"]
        except:
            pass
        try:
            variables["proto"] = self.get_protocol_str(kvdict["$protocol"])
        except:
            pass
        
        event = self.retrieve_template("fortinet", "traffic", variables)        
        bufevent = frame_time.strftime(event)
        
        self.log_fp.write(bufevent)

    def run_buffer(self, action, event_time, kvdict):
        action_exec = action.Exec()
        print("FIXME: Buffer run not supported in aws vpc flow")
        return ""
        
        
