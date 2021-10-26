#!/usr/bin/env python3
import os
import random
import zipfile
from datetime import datetime

from pyfaup.faup import Faup

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
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
        
    def run(self, event, config, templates):        
        frame_time = datetime.fromtimestamp(event["time"])
        event_name = "main2"
        try:
            event_name = event["variables"]["$event_name"]
        except:
            pass
        
        if not "$domain" in event["variables"]:
            raise ValueError("Error, bluecoat proxysg requires a domain variable to be set for %s" % str(event["exec"]))

        protocol = "http"
        try:
            protocol = event["variables"]["$protocol"]
        except:
            pass

        portdst = 80
        try:
            portdst = event["variables"]["$port-dst"]
            if portdst == 443 or portdst == 8443:
                protocol = "https"
        except:
            pass
        
        uri = "/"
        try:
            uri = event["variables"]["$uri"]
        except:
            pass
        
        full_uri = protocol + "://" + event["variables"]["$domain"] + uri
        self.faup_ctx.decode(full_uri)

        event["variables"]["$http_response_body_bytes"] = str(random.randint(230, 4096))
        event["variables"]["$http_request_body_bytes"] = str(random.randint(20, 2048))
        try:
            event["variables"]["$http_referer_original"] = event["variables"]["$referer"]
        except:
            pass
        try:
            event["variables"]["$http_user_agent_original"] = event["variables"]["$user-agent"]
            event["variables"]["$cs(User-Agent)"] = event["variables"]["$user-agent"]
        except:
            pass

        try:
            event["variables"]["$src_ip_addr"] = event["variables"]["$ip-src"]
            event["variables"]["$c-ip"] = event["variables"]["$ip-src"]
        except:
            pass
        try:
            event["variables"]["$dst_ip_addr"] = event["variables"]["$ip-dst"]
            event["variables"]["$s-ip"] = event["variables"]["$ip-dst"]
        except:
            pass        
        try:
            event["variables"]["$http_request_method"] = event["variables"]["$method"]
            event["variables"]["$cs-method"] = event["variables"]["$method"]
        except:
            pass

        try:
            event["variables"]["$src_port_number"] = event["variables"]["$port-src"]
        except:
            pass        

        try:
            event["variables"]["$dst_port_number"] = event["variables"]["$port-dst"]
            event["variables"]["$cs-uri-port"] = event["variables"]["$port-dst"]
        except:
            pass
        event["variables"]["$network_application_protocol"] = protocol
        event["variables"]["$cs-uri-scheme"] = protocol
        
        event["variables"]["$event_duration"] = str(random.randrange(20,1000))
        event["variables"]["$time-taken"] = str(random.randrange(20,1000))
        
        try:
            if event["variables"]["$resptime"] != "":
                event["variables"]["$event_duration"] = event["variables"]["$resptime"]
                event["variables"]["$time-taken"] = event["variables"]["$resptime"]
        except:
            pass

        try:
            if event["variables"]["$statuscode"] != "":
                event["variables"]["$http_status_code"] = event["variables"]["$statuscode"]
                event["variables"]["$sc-status"] = event["variables"]["$statuscode"]
        except:
            pass

        domain = self.faup_ctx.get_domain()
        event["variables"]["$url_hostname"] = domain
        event["variables"]["$cs-host"] = domain
        event["variables"]["$url_path"] = self.faup_ctx.get_resource_path()
        if event["variables"]["$url_path"] == None:
            event["variables"]["$url_path"] = "-"
        event["variables"]["$cs-uri-path"] =  event["variables"]["$url_path"]
            
        event["variables"]["$url_query"] = self.faup_ctx.get_query_string()
        if event["variables"]["$url_query"] == None:
            event["variables"]["$url_query"] = "-"
        category = ""

        event["variables"]["$cs-uri-query"] = event["variables"]["$url_query"]
        
        try:
            event["variables"]["$url_category"] = event["variables"]["$classification"]
        except:        
            try:
                cat = self.domains[domain]
                category = self.catmap[cat]
            except:
                category = "Unclassified"            
            event["variables"]["$url_category"] = category

        event["variables"]["$cs-categories"] = event["variables"]["$url_category"]

        
        event = template_get_event(templates, event_name, event["variables"])
        event = frame_time.strftime(event)

        yield bytes(event, "utf8")

