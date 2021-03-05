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
        self.bluecoat_fp = self.openlog("bluecoat_proxysg.log")
        self.faup_ctx = Faup()
        blacklist_archive = zipfile.ZipFile(os.path.join(os.path.dirname(__file__), "blacklist.all.zip"))
        blacklist_fp = blacklist_archive.open("blacklist.all", "r")
        
        self.catmap = {"ads": "Advertisement","adult": "Adult (X)","aggressive": "Aggressive","astrology": "Astrology","audio-video": "Audio/Video","bank": "Online bank","bitcoin": "Bitcoin Mining","blog": "Blog","celebrity": "Celebrity","chat": "Chat site","child": "Child","cleaning": "Cleanup, Antivirus etc","cooking":"Cooking","cryptojacking": "Cryptojacking","dangerous_material": "Dangerous kits","dating": "Dating","ddos": "DDos or Stresser","doh": "DNS over HTTP","download": "Software download","drugs": "Drug","educational_games": "Educational Games","filehosting": "File Hosting","financial": "Financial","forums": "Forums","gambling": "Gambling","games": "Games","hacking": "Hacking","jobsearch": "Job Search","lingerie": "Lingerie","malware": "Malware","manga": "Manga","marketingware": "Marketing Site","mixed_adult": "Unstructured Adult Sections","mobile-phone": "Mobile Phone","phishing": "Phishing","press": "Press","proxy": "Redirector Site","radio": "Radio","reaffected": "Owner Changed","remote-control": "User Desktop Remote Control","sect": "Sect","sexual_education": "Sexual Education","shopping": "Shopping","shortener": "URL shortener","social_networks": "Social Network","special": "Special","sports": "Sports","stalkerware": "Spying tools","translation": "Translation Site","update": "Software Update","vpn": "VPN","warez": "Warez DownloadZ","webmail": "Webmail"
}
        self.domains = {}
        for line in blacklist_fp.readlines():
            line = str(line)
            cat, domain = line.split(":")
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
        except AttributeError:
            pass
        variables["src_ip_addr"] = packet.ip.src
        variables["dst_ip_addr"] = packet.ip.dst
        try:
            variables["http-request-method"] = packet.http.request_method
        except AttributeError:
            pass            
        variables["dst_port_number"] = packet.tcp.dstport
        variables["event_duration"] = str(random.randrange(20,1000))
        domain = self.faup_ctx.get_domain()
        variables["url_hostname"] = domain
        variables["url_path"] = self.faup_ctx.get_resource_path()
        if variables["url_path"] == None:
            variables["url_path"] = "-"
        variables["url_query"] = self.faup_ctx.get_query_string()
        if variables["url_query"] == None:
            variables["url_query"] = "-"
        category = ""
        try:
            cat = self.domains[domain]
            category = self.catmap[cat]
        except:
            category = "Unclassified"            
        variables["url_category"] = category
        
        event = self.retrieve_template("bluecoat.proxysg", "main", variables)        
        event = frame_time.strftime(event)

        return event

    def db_to_log(self, frame_time, kvdict):
#        print(str(kvdict))
        if not "$domain" in kvdict:
            raise ValueError("Error, bluecoat proxysg requires a domain variable to be set")
        
        protocol = "http"
        try:
            protocol = kvdict["$protocol"]
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
        try:
            variables["http_referer_original"] = kvdict["$referer"]
        except:
            pass
        try:
            variables["http_user_agent_original"] = kvdict["$user-agent"]
        except:
            pass

        try:
            variables["src_ip_addr"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["dst_ip_addr"] = kvdict["$ip-dst"]
        except:
            pass        
        try:
            variables["http-request-method"] = kvdict["$method"]
        except:
            pass

        try:
            variables["dst_port_number"] = kvdict["$port-dst"]
        except:
            pass        
        variables["event_duration"] = str(random.randrange(20,1000))
        
        variables["url_hostname"] = self.faup_ctx.get_domain()
        variables["url_path"] = self.faup_ctx.get_resource_path()
        if variables["url_path"] == None:
            variables["url_path"] = "-"
        variables["url_query"] = self.faup_ctx.get_query_string()
        if variables["url_query"] == None:
            variables["url_query"] = "-"
        category = ""
        try:
            cat = self.domains[domain]
            category = self.catmap[cat]
        except:
            category = "Unclassified"            
        variables["url_category"] = category
        
        event = self.retrieve_template("bluecoat.proxysg", "main", variables)        
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
        if hasattr(packet, 'ip'):
            if hasattr(packet, 'http'):
                if self.is_request(layer):
                    # fields = layer.field_names
                    # for field in fields:
                    #     print("%s -> %s" % (field, layer.get_field_value(field)))
                    
                    self.bluecoat_fp.write(self.packet_to_log(packet))
            
    def run_ccraft(self, event, kvdict):
        frame_time = datetime.fromtimestamp(int(event["time"]))
        self.bluecoat_fp.write(self.db_to_log(frame_time, kvdict))
