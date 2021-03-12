# Reference: https://docs.paloaltonetworks.com/pan-os/9-1/pan-os-admin/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/traffic-log-fields.html
from IPy import IP
import random
from datetime import datetime
import uuid
import geoip2.database
import os

from logwriter.LogContext import LogContext


flags_mapping = { "0x80000000": "session has a packet capture (PCAP)",
                  "0x40000000": "option is enabled to allow a client to use multiple paths to connect to a destination host",
                  "0x20000000": "file is submitted to WildFire for a verdict",
                  "0x10000000": "enterprise credential submission by end user detected",
                  "0x08000000": "source for the flow is an allow list and not subject to recon protection",
                  "0x02000000": "IPv6 session",
                  "0x01000000": "SSL session is decrypted (SSL Proxy)",
                  "0x00800000": "session is denied via URL filtering",
                  "0x00400000": "session has a NAT translation performed",
                  "0x00200000": "user information for the session was captured through Captive Portal",
                  "0x00100000": "application traffic is on a non-standard destination port",
                  "0x00080000": "X-Forwarded-For value from a proxy is in the source user field",
                  "0x00040000": "log corresponds to a transaction within a http proxy session (Proxy Transaction)",
                  "0x00020000": "Client to Server flow is subject to policy based forwarding",
                  "0x00010000": "Server to Client flow is subject to policy based forwarding",
                  "0x00008000": "session is a container page access (Container Page)",
                  "0x00002000": "session has a temporary match on a rule for implicit application dependency handling. Available in PAN-OS 5.0.0 and above.",
                  "0x00000800": "symmetric return is used to forward traffic for this session",
                  "0x00000400": "decrypted traffic is being sent out clear text through a mirror port",
                  "0x00000100": "payload of the outer tunnel is being inspected"
                 }

random_flag = ["0x80000000", "0x40000000", "0x20000000", "0x10000000", "0x08000000", "0x00008000", "0x00000400"]

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
        if number <= 7:
            return "end"
        else if number == 8:
            return "deny"
        else if number == 9:
            return "drop"
        else if number == 10:
            return "start"

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
            header = self.retrieve_template_header("paloalto.firewall.traffic", "9")
            if header:
                self.log_fp.write(header)
                self.first = False
        
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        generate_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)) - 8)

        bytessent = random.randint(256, 83942)
        bytesreceived = random.randint(10, 1204323)
        
        kvdict = {
            "Session_ID": random.randint(124, 950432),
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
            "Source_Location": self.get_country_from_ip(packet.ip.src),
            "Destination_Location": self.get_country_from_ip(packet.ip.dst),
            "url_idx": random.randint(1, 99),
            "Bytes": bytessent + bytesreceived,
            "Bytes_Sent": bytessent,
            "Bytes_Received": bytesreceived,
        }
        self.session_id += 1

        event = self.retrieve_template("paloalto.firewall.traffic", "9", kvdict)
        event = frame_time.strftime(event)
        
        self.log_fp.write(event)
    
    def run(self, cap, packet, pktid, layer):
        if hasattr(packet, 'tcp'):
            if str(packet.tcp.flags) == "0x00000002" or str(packet.tcp.flags) =="0x00000012": # We only write TCP-SYN
                self.execute(cap, packet, pktid, layer)
        else:
            self.execute(cap, packet, pktid, layer)

    def run_ccraft(self, event, kvdict):
        if self.first:
            header = self.retrieve_template_header("paloalto.firewall.traffic", "9")
            if header:
                self.log_fp.write(header)
                self.first = False
                
        event_time = str(int(event["time"]))
        frame_time = datetime.fromtimestamp(int(event_time))
        variables = {
            "Flags": random_flag[random.randint(0, len(random_flag)],
            "Receive_Time": frame_time.strftime("%Y/%m/%d %H:%M:%S"),
            "Threat/Content_Type": self.get_threat_type(),
            "Generate_Time": frame_time.strftime("%Y/%m/%d %H:%M:%S"),
            "Source_address": None,
            "Destination_address": None,
            "Time_Logged": frame_time.strftime("%Y/%m/%d %H:%M:%S"),
            "Source_Port": None,
            "Destination_Port": None,
            "IP_Protocol": None,
            "URL/Filename": None,
            "Direction": "client-to-server",
            "Sequence_Number": random.randint(1, 65536),
            "Source_Country": None,
            "Destination_Country": None,
            "url_idx": random.randint(1, 99),                        
        }
        try:
            variables["Source_address"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["Destination_address"] = kvdict["$ip-dst"]
        except:
            pass
        try:
            variables["Source_Port"] = kvdict["$port-src"]
        except:
            pass
        try:
            variables["Destination_Port"] = kvdict["$port-dst"]
        except:
            pass
        try:
            variables["Source_Country"] = self.get_country_from_ip(kvdict["$ip-src"])
        except:
            pass
        try:
            variables["Destination_Country"] = self.get_country_from_ip(kvdict["$ip-src"])
        except:
            pass
        try:
            variables["URL/Filename"] = self.get_country_from_ip(kvdict["$uri"])
        except:
            pass

        # print(str(event))
        
        variables["IP_Protocol"] = "tcp"
        if event["exec"] == "DNSConnection":
            variables["IP_Protocol"] = "udp"
        
        event = self.retrieve_template("paloalto.firewall", "traffic", variables)
        
        event = frame_time.strftime(event)
        
        self.log_fp.write(event)
