from IPy import IP
import random
from datetime import datetime
import uuid
import geoip2.database
import os

from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "paloalto_firewall"
    active_layer = "ip"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("paloalto_firewall.log")
        
        geodb = "GeoLite2-Country.mmdb"
        self.reader = geoip2.database.Reader(os.path.join(os.path.dirname(__file__),geodb))
        
        self.first = True
        self.session_id = 121423
        
    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass
        
    def get_country_from_ip(self, ip):
        try:
            response = self.reader.country(ip)
            return response.country.names["en"]
        except:
            return ip

    def get_threat_type(self):
        number = random.randint(0, 10)
        if number <= 9:
            return "spyware"
        else:
            return "vulnerability"

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

    def get_seqid(self, packet):
        if hasattr(packet, 'tcp'):
            return packet.tcp.seq
        if hasattr(packet, 'udp'):
            return 0

    def get_protocol(self, packet):
        if hasattr(packet, 'tcp'):
            return "tcp"
        if hasattr(packet, 'udp'):
            return "udp"

    def get_url_filename(self, packet):
        if hasattr(packet, 'http'):
            try:
                if len(packet.http.request_uri) > 0:
                    return "%s/%s" % (packet.http.host, packet.http.request_uri)
            except AttributeError:
                pass
        return None

    def get_direction(self, packet):
        ipsrc = IP(packet.ip.src)
        ipdst = IP(packet.ip.dst)
        if ipsrc.iptype() == "PRIVATE" and ipdst.iptype() == "PUBLIC":
            return "client-to-server"
        if ipsrc.iptype() == "PUBLIC" and ipdst.iptype() == "PRIVATE":
            return "server-to-client"        
        
        return "client-to-server"        

    def execute(self, cap, packet, pktid, layer):
        if self.first:
            header = self.retrieve_template_header("paloalto.firewall", "traffic")
            if header:
                self.log_fp.write(header)
                self.first = False
        
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        generate_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)) - 8)
        
        kvdict = {
            "Receive_Time": frame_time.strftime("%Y/%m/%d %H:%M:%S"),
            "Threat/Content_Type": self.get_threat_type(),
            "Generate_Time": generate_time.strftime("%Y/%m/%d %H:%M:%S"),
            "Source_address": packet.ip.src,
            "Destination_address": packet.ip.dst,
            "Time_Logged": generate_time.strftime("%Y/%m/%d %H:%M:%S"),
            "Source_Port": self.get_srcport(packet),
            "Destination_Port": self.get_dstport(packet),
            "IP_Protocol": self.get_protocol(packet),
            "URL/Filename": self.get_url_filename(packet),
            "Direction": self.get_direction(packet),
            "Sequence_Number": self.get_seqid(packet),
            "Source_Country": self.get_country_from_ip(packet.ip.src),
            "Destination_Country": self.get_country_from_ip(packet.ip.dst),
            "url_idx": random.randint(1, 99),                        
        }
        self.session_id += 1

        event = self.retrieve_template("paloalto.firewall", "traffic", kvdict)
        event = frame_time.strftime(event)
        
        self.log_fp.write(event)
    
    def run(self, cap, packet, pktid, layer):

        if hasattr(packet, 'tcp'):
            if str(packet.tcp.flags) == "0x00000002" or str(packet.tcp.flags) =="0x00000012": # We only write TCP-SYN
                self.execute(cap, packet, pktid, layer)
        else:
            self.execute(cap, packet, pktid, layer)

