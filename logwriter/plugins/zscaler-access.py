import struct
import socket
import sys
from datetime import datetime
import random
from pyfaup.faup import Faup
import os
from logwriter.LogContext import LogContext
import re
import zipfile

class LogPlugin(LogContext):
    name = "zscaleraccess"
    active_layer = "http"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.logfp = self.openlog("zscaler_access.log")
        self.event_id = 555000222003330000
        
        self.faup_ctx = Faup()
        blacklist_archive = zipfile.ZipFile(os.path.join(os.path.dirname(__file__), "blacklist.all.zip"))
        blacklist_fp = blacklist_archive.open("blacklist.all", "r")

        self.user_rex = re.compile(r"User: ([a-zA-Z0-9@\+-\.]+)")        
        #
        # This is a mapping between the blacklist category we are using and how
        # the proxy itself maps those websites categories
        # using: https://dsi.ut-capitole.fr/documentations/cache/squidguard_en.html#contrib
        # All the ones ending with # mean they have match our blacklist and we could properly map.
        self.catmap = {"ads": "Advertisement",
                       "adult": "Adult (X)",
                       "aggressive": "Aggressive",
                       "astrology": "Astrology",
                       "audio-video": "Music and Audio Streaming", #
                       "bank": "Finance", #
                       "bitcoin": "Bitcoin Mining",
                       "blog": "Blogs", #
                       "celebrity": "Celebrity",
                       "chat": "Chat site",
                       "child": "Child",
                       "cleaning": "Corporate Marketing",
                       "cooking":"Cooking",
                       "cryptojacking": "Cryptojacking",
                       "dangerous_material": "Dangerous kits",
                       "dating": "Dating",
                       "ddos": "DDos or Stresser",
                       "doh": "DNS over HTTP",
                       "download": "Software download",
                       "drugs": "Drug",
                       "educational_games": "Educational Games",
                       "filehosting": "FileHost",
                       "financial": "Financial",
                       "forums": "Discussion Forums", #
                       "gambling": "Gambling",
                       "games": "Entertainment", #
                       "hacking": "Hacking",
                       "jobsearch": "Job/Employment Search", #
                       "lingerie": "Lingerie",
                       "malware": "Malware",
                       "manga": "Entertainment", #
                       "marketingware": "Marketing Site",
                       "mixed_adult": "Unstructured Adult Sections",
                       "mobile-phone": "Mobile Phone",
                       "phishing": "Phishing",
                       "press": "News and Media", #
                       "proxy": "Redirector Site",
                       "radio": "Radio",
                       "reaffected": "Owner Changed",
                       "remote-control": "Remote Access Tools",
                       "sect": "Sect",
                       "sexual_education": "Sexual Education",
                       "shopping": "Classifieds", #
                       "shortener": "URL shortener",
                       "social_networks": "Social Network",
                       "special": "Special",
                       "sports": "Sports",
                       "stalkerware": "Spying tools",
                       "translation": "Translators", #
                       "update": "Software Update",
                       "vpn": "VPN",
                       "warez": "Warez DownloadZ",
                       "webmail": "Webmail"
        }
        self.supercatmap = {
            "Entertainment": "Entertainment/Recreation",
            "Music and Audio Streaming": "Entertainment/Recreation",
            "Other Entertainment/Recreation": "Entertainment/Recreation",
            "Radio Stations": "Entertainment/Recreation",
            "Video Streaming": "Entertainment/Recreation",
            "Television/Movies": "Entertainment/Recreation",
            "News and Media": "News and Media",
            "Classifieds": "Business and Economy",
            "Corporate Marketing": "Business and Economy",
            "Finance": "Business and Economy",
            "Online Trading, Brokerage, Insurance": "Business and Economy",
            "Other Business and Economy": "Business and Economy",
            "Professional Services": "Business and Economy",
            "Continuing Education/Colleges": "Education",
            "History": "Education",
            "K-12": "Education",
            "Other Education": "Education",
            "Reference Sites": "Education",
            "Science/Tech": "Education",
            "Advertising": "Information Technology",
            "CDN": "Information Technology",
            "DNS over HTTPS": "Information Technology",
            "FileHost": "Information Technology",
            "Image Host": "Information Technology",
            "Operating System and Software Updates": "Information Technology",
            "Other Information Technology": "Information Technology",
            "Portals": "Information Technology",
            "Safe Search Engine": "Information Technology",
            "Shareware Download": "Information Technology",
            "Translators": "Information Technology",
            "Web Host": "Information Technology",
            "Web Search": "Information Technology",
            "Blogs": "Internet Communication",
            "Discussion Forums": "Internet Communication",
            "Internet Services": "Internet Communication",
            "Online Chat": "Internet Communication",
            "Other Internet Communication": "Internet Communication",
            "Peer-to-Peer Site": "Internet Communication",
            "Remote Access Tools": "Internet Communication",
            "Webmail": "Internet Communication",
            "Web Conferencing": "Internet Communication",
            "Job/Employment Search": "Job/Employment Search",
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
        scheme = self.faup_ctx.get_scheme()
        proto = scheme.upper()
        if proto == "HTTPS":
            proto = "SSL"

        variables = {}

        variables["clientpublicip"] = self.client_public_ipv4
        variables["event-id"] = str(self.event_id)
        variables["clientip"] = packet.ip.src
        variables["serverip"] = packet.ip.dst
        variables["protocol"] = proto
        variables["requestsize"] = str(len(packet))
        try:
            variables["refererurl"] = packet.http.referer
        except:
            pass

        try:
            variables["useragent"] = packet.http.user_agent
        except:
            pass

        str_http = str(packet.http)
        user_match = self.user_rex.search(str_http)
        if user_match:
            user = user_match.group(1)
            variables["user"] = user

        variables["url"] = packet.http.request_full_uri
        variables["hostname"] = self.faup_ctx.get_host()
        category = ""
        domain = self.faup_ctx.get_domain()
        try:
            cat = self.domains[domain]
            category = self.catmap[cat]
        except:
            category = "Unclassified"            
        variables["urlcategory"] = category

        supercategory = ""
        try:
            supercategory = self.supercatmap[category]
        except:
            supercategory = "User-Defined"            
        variables["urlsupercategory"] = supercategory
        variables["urlclass"] = supercategory

        event = self.retrieve_template("zscaler", "proxy", variables)
        event = frame_time.strftime(event)
        
        return event
        
    def db_to_log(self, frame_time, kvdict):    
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
        scheme = self.faup_ctx.get_scheme()
        proto = scheme.upper()
        if proto == "HTTPS":
            proto = "SSL"

        variables = {}

        try:
            variables["clientpublicip"] = kvdict["$ip-src"]
        except:
            pass
        
        variables["event-id"] = str(self.event_id)
        try:
            variables["clientip"] = kvdict["$ip-src"]
        except:
            pass
        try:
            variables["serverip"] = kvdict["$ip-dst"]
        except:
            pass
        
        variables["protocol"] = proto
        variables["requestsize"] = str(len(full_uri) + 242) # say 242 is about the header size
        try:
            variables["refererurl"] = kvdict["$referer"]
        except:
            pass

        try:
            variables["useragent"] = kvdict["$user-agent"]
        except:
            pass

        try:
            variables["user"] = kvdict["$user"]
        except:
            pass

        try:
            variables["url"] = full_uri
        except:
            pass
        
        variables["hostname"] = self.faup_ctx.get_host()
        category = ""
        domain = self.faup_ctx.get_domain()
        try:
            cat = self.domains[domain]
            category = self.catmap[cat]
        except:
            category = "Unclassified"            
        variables["urlcategory"] = category

        supercategory = ""
        try:
            supercategory = self.supercatmap[category]
        except:
            supercategory = "User-Defined"            
        variables["urlsupercategory"] = supercategory
        variables["urlclass"] = supercategory

        event = self.retrieve_template("zscaler", "proxy", variables)
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
                self.event_id += 1
                if self.is_request(layer):
                    # print(str(packet))
                    # fields = layer.field_names
                    # for field in fields:
                    #     print("%s -> %s" % (field, layer.get_field_value(field)))                    
                    self.logfp.write(self.packet_to_log(packet))
                        
    def run_ccraft(self, event, kvdict):
        frame_time = datetime.fromtimestamp(int(event["time"]))
        self.logfp.write(self.db_to_log(frame_time, kvdict))
