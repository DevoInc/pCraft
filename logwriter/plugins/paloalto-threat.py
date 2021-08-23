# Reference: https://docs.paloaltonetworks.com/pan-os/9-1/pan-os-admin/monitoring/use-syslog-for-monitoring/syslog-field-descriptions/traffic-log-fields.html
from IPy import IP
import random
from datetime import datetime
import uuid
import geoip2.database
import os

from logwriter.LogContext import LogContext


random_flag = ["0x80000000", "0x40000000", "0x20000000", "0x10000000", "0x08000000", "0x00008000", "0x00000400"]

class LogPlugin(LogContext):
    name = "paloalto_threat"
    active_layer = "no-active-layer"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("paloalto_threat.log")
        self.header = self.retrieve_template_header("paloalto.firewall.traffic", "9")
        self.first = True
        
        geodb = "GeoLite2-Country.mmdb"
        try:
            self.reader = geoip2.database.Reader(os.path.join(os.path.dirname(__file__),geodb))
        except FileNotFoundError:
            self.reader = None
            print("Please add GeoLite2-Country.mmdb in %s to have Country mapping support" % (os.path.dirname(__file__)))
            
        self.session_id = 121423
        
    def __del__(self):
        self.closelog()

    def get_country_from_ip(self, ip):
        try:
            response = self.reader.country(ip)
            return response.country.names["en"]
        except:
            return "Internal Networks"

    def validate_keys(self, kvdict):
        self.do_validate_keys("paloalto.firewall.threat", "9", kvdict)

    def template_to_log(self, frame_time, kvdict, layer=None):
        if not layer:
            if not "Sequence_Number" in kvdict:
                kvdict["Sequence_Number"] = str(random.randint(1, 65536))
            if not "Receive_Time" in kvdict:
                kvdict["Receive_Time"] = frame_time.strftime("%Y/%m/%d %H:%M:%S")
            if not "Generate_Time" in kvdict:
                kvdict["Generate_Time"] = frame_time.strftime("%Y/%m/%d %H:%M:%S")
            if not "Time_Logged" in kvdict:
                kvdict["Time_Logged"] = frame_time.strftime("%Y/%m/%d %H:%M:%S")
            if not "Sequence_Number" in kvdict:
                kvdict["Sequence_Number"] = str(random.randint(1, 65536))
            if not "Session_ID" in kvdict:
                kvdict["Session_ID"] = str(self.session_id)
        else:
            kvdict = {
                "Sequence_Number": str(random.randint(1, 65536)),
                "Receive_Time": frame_time.strftime("%Y/%m/%d %H:%M:%S"),
                "Generate_Time": frame_time.strftime("%Y/%m/%d %H:%M:%S"),
                "Time_Logged": frame_time.strftime("%Y/%m/%d %H:%M:%S"),
                "Session_ID": str(self.session_id)
            }
                
        event = self.retrieve_template("paloalto.firewall.threat", "9", kvdict)
        event = frame_time.strftime(event)

        self.session_id += 1
        
        self.log_fp.write(event)
    
    def run(self, cap, packet, pktid, layer):
        if self.first:
            if self.header:
                self.log_fp.write(header)
            self.first = False

        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        self.template_to_log(frame_time, None, layer=layer)

    def run_ccraft(self, event, kvdict):
        frame_time = datetime.fromtimestamp(int(event["time"]))

        if not "Source_IP" in kvdict:
            kvdict["Source_IP"] = kvdict["$ip-src"]

        if not "Destination_IP" in kvdict:
            kvdict["Destination_IP"] = kvdict["$ip-dst"]

        if not "Source_Port" in kvdict:
            kvdict["Source_Port"] = kvdict["$port-src"]

        if not "Destination_Port" in kvdict:
            kvdict["Destination_Port"] = kvdict["$port-dst"]

        try:
            if not "Source_Country" in kvdict:
                kvdict["Source_Country"] = self.get_country_from_ip(kvdict["$ip-src"])

                if not "Destination_Country" in kvdict:
                    kvdict["Destination_Country"] = self.get_country_from_ip(kvdict["$ip-src"])

                if not "URL/Filename" in kvdict:
                    kvdict["URL/Filename"] = self.get_country_from_ip(kvdict["$uri"])

                if not "Protocol" in kvdict:
                    kvdict["Protocol"] = kvdict["$protocol"]
        except:
            pass
                    
        self.template_to_log(frame_time, kvdict)


        
    def run_buffer(self, action, event_time, kvdict):
        variables = {}
        try:
            variables["Source_IP"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["Destination_IP"] = kvdict["$ip-dst"]
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
        try:
            variables["Protocol"] = kvdict["$protocol"]
        except:
            pass
        
        frame_time = datetime.fromtimestamp(event_time)
        return self.template_to_log(frame_time, variables)
        
        
