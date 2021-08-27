import random
from datetime import datetime
import os

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "aws-vpc-flow"
    active_layer = "ip"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("aws-vpc_flow.log")
                
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
        
        kvdict = {
            "version": 2,
            "account_id": random.randint(100000000000, 900000000000),
            "interface": "eni-1234",
            "ip_src": packet.ip.src,
            "ip_dst": packet.ip.dst,
            "port_src": self.get_srcport(packet),
            "port_dst": self.get_dstport(packet),
            "protocol": self.get_protocol(packet),
            "bytes": bytessent + bytesreceived,
            "starttime": str(int(float(packet.sniff_timestamp))),
            "endtime": str(int(float(packet.sniff_timestamp)) + random.randint(10, 1000)),
            "action": "ACCEPT",
            "status": "OK",
        }

        event = self.retrieve_template("aws.vpc", "flow", kvdict)
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
        
        variables = {
            "version": 2,
            "account_id": random.randint(100000000000, 900000000000),
            "interface": "eni-1234",
            "ip_src": None,
            "ip_dst": None,
            "port_src": None,
            "port_dst": None,
            "protocol": None,
            "bytes": bytessent + bytesreceived,
            "starttime": str(int(float(frame_time))),
            "endtime": str(int(float(frame_time)) + random.randint(10, 1000)),
            "action": "ACCEPT",
            "status": "OK",
        }
        try:
            variables["ip_src"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["ip_dst"] = kvdict["$ip-dst"]
        except:
            pass
        try:
            variables["port_src"] = kvdict["$port-src"]
        except:
            pass
        try:
            variables["port_dst"] = kvdict["$port-dst"]
        except:
            pass
        try:
            variables["protocol"] = self.get_protocol_str(kvdict["$protocol"])
        except:
            pass
        
        event = self.retrieve_template("aws.vpc", "flow", variables)        
        bufevent = frame_time.strftime(event)
        
        self.log_fp.write(bufevent)

    def run_buffer(self, action, event_time, kvdict):
        action_exec = action.Exec()
        print("FIXME: Buffer run not supported in aws vpc flow")
        return ""
        
        
