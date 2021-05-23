import struct
import socket
import sys
from datetime import datetime
import random
from pyfaup.faup import Faup
import os
import zipfile
from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "bluecoatproxysg"
    active_layer = "http"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.first = True
        self.log_fp = self.openlog("bluecoat_proxysg.log")
        self.faup_ctx = Faup()
        blacklist_archive = zipfile.ZipFile(os.path.join(os.path.dirname(__file__), "blacklist.all.zip"))
        blacklist_fp = blacklist_archive.open("blacklist.all", "r")
        
        self.catmap = {"ads": "Advertisement","adult": "Adult (X)","aggressive": "Aggressive","astrology": "Astrology","audio-video": "Audio/Video","bank": "Online bank","bitcoin": "Bitcoin Mining","blog": "Blog","celebrity": "Celebrity","chat": "Chat site","child": "Child","cleaning": "Cleanup, Antivirus etc","cooking":"Cooking","cryptojacking": "Cryptojacking","dangerous_material": "Dangerous kits","dating": "Dating","ddos": "DDos or Stresser","doh": "DNS over HTTP","download": "Software download","drugs": "Drug","educational_games": "Educational Games","filehosting": "File Hosting","financial": "Financial","forums": "Forums","gambling": "Gambling","games": "Games","hacking": "Hacking","jobsearch": "Job Search","lingerie": "Lingerie","malware": "Malware","manga": "Manga","marketingware": "Marketing Site","mixed_adult": "Unstructured Adult Sections","mobile-phone": "Mobile Phone","phishing": "Phishing","press": "Press","proxy": "Redirector Site","radio": "Radio","reaffected": "Owner Changed","remote-control": "User Desktop Remote Control","sect": "Sect","sexual_education": "Sexual Education","shopping": "Shopping","shortener": "URL shortener","social_networks": "Social Network","special": "Special","sports": "Sports","stalkerware": "Spying tools","translation": "Translation Site","update": "Software Update","vpn": "VPN","warez": "Warez DownloadZ","webmail": "Webmail"
}
        self.domains = {}
        for line in blacklist_fp.readlines():
            line = str(line)[:-3]
            cat, domain = line.split(":")
            cat = str(cat[2:])
#            print("Adding domain '%s' to cat '%s'" % (domain, cat))
            self.domains[domain] = cat
        blacklist_fp.close()
        
    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass

    def packet_to_log(self, packet):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))

        self.faup_ctx.decode(packet.http.request_full_uri)
        
        variables = {}
        try:
            variables["http_referer_original"] = packet.http.referer
        except AttributeError:
            pass
        try:
            variables["http_user_agent_original"] = packet.http.user_agent
            variables["cs(User-Agent)"] = packet.http.user_agent
        except AttributeError:
            pass
        variables["src_ip_addr"] = packet.ip.src
        variables["dst_ip_addr"] = packet.ip.dst
        variables["c-ip"] = packet.ip.src
        variables["s-ip"] = packet.ip.dst
        try:
            variables["http_request_method"] = packet.http.request_method
            variables["cs-method"] = packet.http.request_method
        except AttributeError:
            pass            
        variables["src_port_number"] = packet.tcp.srcport
        variables["dst_port_number"] = packet.tcp.dstport
        variables["cs-uri-port"] = packet.tcp.dstport

        protocol = "http"
        if str(packet.tcp.dstport) == "443" or str(packet.tcp.dstport) =="8443":
            protocol = "https"
        
        variables["network_application_protocol"] = protocol
        variables["cs-uri-scheme"] = protocol

        variables["event_duration"] = str(random.randrange(20,1000))
        variables["time-taken"] = variables["event_duration"]
        domain = self.faup_ctx.get_domain()
        variables["url_hostname"] = domain
        variables["cs-host"] = domain
        variables["url_path"] = self.faup_ctx.get_resource_path()
        if variables["url_path"] == None:
            variables["url_path"] = "-"

        variables["cs-uri-path"] =  variables["url_path"]

        variables["url_query"] = self.faup_ctx.get_query_string()
        if variables["url_query"] == None:
            variables["url_query"] = "-"

        variables["cs-uri-query"] = variables["url_query"]

        category = ""
        try:
            cat = self.domains[domain]
            category = self.catmap[cat]
        except:
            category = "Unclassified"            
        variables["url_category"] = category

        variables["cs-categories"] = category
        
        event_name = "main2"
        try:
            event_name = variables["event_name"]
        except:
            pass
        
        event = self.retrieve_template("bluecoat.proxysg", event_name, variables)        
        event = frame_time.strftime(event)

        return event

    def db_to_log(self, obj, frame_time, kvdict):
#        print(str(kvdict))
        if not "$domain" in kvdict:
            raise ValueError("Error, bluecoat proxysg requires a domain variable to be set for %s" % str(obj))
        
        protocol = "http"
        try:
            protocol = kvdict["$protocol"]
        except:
            pass

        portdst = 80
        try:
            portdst = kvdict["$port-dst"]
            if portdst == 443 or portdst == 8443:
                protocol = "https"
        except:
            pass
        
        uri = "/"
        try:
            uri = kvdict["$uri"]
        except:
            pass
        
        try:
            full_uri = protocol + "://" + kvdict["$domain"] + uri
        except:
            pass
        
        self.faup_ctx.decode(full_uri)
        
        variables = {}

        variables["http_response_body_bytes"] = str(random.randint(230, 4096))
        variables["http_request_body_bytes"] = str(random.randint(20, 2048))
        
        try:
            variables["http_referer_original"] = kvdict["$referer"]
        except:
            pass
        try:
            variables["http_user_agent_original"] = kvdict["$user-agent"]
            variables["cs(User-Agent)"] = kvdict["$user-agent"]
        except:
            pass

        try:
            variables["src_ip_addr"] = kvdict["$ip-src"]
            variables["c-ip"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["dst_ip_addr"] = kvdict["$ip-dst"]
            variables["s-ip"] = kvdict["$ip-dst"]
        except:
            pass        
        try:
            variables["http_request_method"] = kvdict["$method"]
            variables["cs-method"] = kvdict["$method"]
        except:
            pass

        try:
            variables["src_port_number"] = kvdict["$port-src"]
        except:
            pass        

        try:
            variables["dst_port_number"] = kvdict["$port-dst"]
            variables["cs-uri-port"] = kvdict["$port-dst"]
        except:
            pass
        variables["network_application_protocol"] = protocol
        variables["cs-uri-scheme"] = protocol
        
        variables["event_duration"] = str(random.randrange(20,1000))
        variables["time-taken"] = str(random.randrange(20,1000))
        
        try:
            if kvdict["$resptime"] != "":
                variables["event_duration"] = kvdict["$resptime"]
                variables["time-taken"] = kvdict["$resptime"]
        except:
            pass

        try:
            if kvdict["$statuscode"] != "":
                variables["http_status_code"] = kvdict["$statuscode"]
                variables["sc-status"] = kvdict["$statuscode"]
        except:
            pass

        domain = self.faup_ctx.get_domain()
        variables["url_hostname"] = domain
        variables["cs-host"] = domain
        variables["url_path"] = self.faup_ctx.get_resource_path()
        if variables["url_path"] == None:
            variables["url_path"] = "-"
        variables["cs-uri-path"] =  variables["url_path"]
            
        variables["url_query"] = self.faup_ctx.get_query_string()
        if variables["url_query"] == None:
            variables["url_query"] = "-"
        category = ""

        variables["cs-uri-query"] = variables["url_query"]
        
        try:
            variables["url_category"] = kvdict["$classification"]
        except:        
            try:
                cat = self.domains[domain]
                category = self.catmap[cat]
            except:
                category = "Unclassified"            
            variables["url_category"] = category

        variables["cs-categories"] = variables["url_category"]

        event_name = "main2"
        try:
            event_name = variables["event_name"]
        except:
            pass        
        event = self.retrieve_template("bluecoat.proxysg", event_name, variables)        
        event = frame_time.strftime(event)

        return event
    
    def is_request(self, layer):
        try:
            method = layer.request_method
            if layer.user_agent:
                return True
        except:
            pass
        return False

    def run(self, cap, packet, pktid, layer):
        # fields = layer.field_names
        # for field in fields:
        #     print("%s -> %s" % (field, layer.get_field_value(field)))
        if hasattr(packet, 'ip'):
            if hasattr(packet, 'http'):
                if self.is_request(layer):
                    if self.first:
                        header = self.retrieve_template_header("bluecoat.proxysg", "main2")
                        if header:
                            self.log_fp.write(header)
                            self.first = False

                    self.log_fp.write(self.packet_to_log(packet))
            
    def run_ccraft(self, event, kvdict):
        if self.first:
            header = self.retrieve_template_header("bluecoat.proxysg", "main2")
            if header:
                self.log_fp.write(header)
                self.first = False
        frame_time = datetime.fromtimestamp(int(event["time"]))
        self.log_fp.write(self.db_to_log(event, frame_time, kvdict))

    def run_buffer(self, action, event_time, kvdict):
        if self.first:
            header = self.retrieve_template_header("bluecoat.proxysg", "main2")
            if header:
                self.log_fp.write(header)
                self.first = False
  
        frame_time = datetime.fromtimestamp(event_time)
        return self.db_to_log(action, frame_time, kvdict)
        
        
