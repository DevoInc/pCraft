#!/usr/bin/env python3
import time
from scapy.all import Ether, IP, TCP

from pcraft import utils
from pcraft import io as PcraftIO
from pcraft.LibraryContext import *
from pcraft.Packet import *

class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__(service="http")

    def run(self, event):
        self.set_vardict(event["variables"])
        
        syn, syn_ack, ack = utils.get_tcp_three_way_handshake(self.get_variable("$ip-src"),
                                                          self.get_variable("$ip-dst"),
                                                          int(self.get_variable("$port-src")),
                                                          int(self.get_variable("$port-dst")))
        pkt = PcraftIO.raw_packet_from_scapy(syn)
        yield PcraftPacket("network", pkt)
        pkt = PcraftIO.raw_packet_from_scapy(syn_ack)
        yield PcraftPacket("network", pkt)
        pkt = PcraftIO.raw_packet_from_scapy(ack)
        yield PcraftPacket("network", pkt)

        # HTTP Request
        httpreq_string = self.build_http_request_string()
        http_request = Ether() / IP(src=self.get_variable("$ip-src"),dst=self.get_variable("$ip-dst")) / TCP(sport=int(self.get_variable("$port-src")), dport=int(self.get_variable("$port-dst")), flags="P""A") / httpreq_string
        pkt = PcraftIO.raw_packet_from_scapy(http_request)
        yield PcraftPacket("network", pkt)

        # HTTP Response
        ack = Ether() / IP(src=self.get_variable("$ip-src"),dst=self.get_variable("$ip-dst")) / TCP(sport=int(self.get_variable("$port-dst")), dport=int(self.get_variable("$port-src")), flags="A")
        pkt = PcraftIO.raw_packet_from_scapy(ack)
        yield PcraftPacket("network", pkt)

        httpresp_string = self.build_http_response_string()
        http_response = Ether() / IP(src=self.get_variable("$ip-dst"),dst=self.get_variable("$ip-src")) / TCP(sport=int(self.get_variable("$port-dst")),dport=int(self.get_variable("$port-src")), flags="P""A") / httpresp_string
        pkt = PcraftIO.raw_packet_from_scapy(http_response)
        yield PcraftPacket("network", pkt)
        
    def set_user(self):
        user = self.get_variable("$user")
        if user:
            user = "\r\nUser: %s" % user
        else:
            user = ""

        return user
        
    def build_http_request_string(self):
        user = self.set_user()

        httpreq_string = "{method} {uri} HTTP/1.1\r\nAccept: */*\r\nUser-Agent: {useragent}\r\nHost:{host}{user}\r\nConnection: Keep-Alive\r\n\r\n".format(
            method=self.get_variable("$method"),
            uri=self.get_variable("$uri"),
            useragent=self.get_variable("$user-agent"),
            host=self.get_variable("$domain"),
            user=user)
    
        if self.get_variable("$method").upper() == "POST":
            httpreq_string = "{method} {uri} HTTP/1.1\r\nAccept: */*\r\nUser-Agent: {useragent}\r\nHost:{host}{user}\r\nContent-Type:{contenttype}\r\nContent-Length:{contentlen}\r\n\r\n{content}".format(
                method=self.get_variable("$method"),
                uri=self.get_variable("$uri"),
                useragent=self.get_variable("$user-agent"),
                host=self.get_variable("$domain"),
                user=user,
                contenttype=self.get_variable("$client-content-type"),
                contentlen=len(self.get_variable("$client-content")),
                content=self.get_variable("$client-content"))
    
            if self.get_variable("$client-headers") != "":
                content = self.get_variable("$client-content")
                contentlen = 0
                if content != "":
                    contentlen = len(content)
                else:
                    raise ValueError("We have client-headers without client-content in a POST method!")
                headers_with_r_n = self.get_variable("$client-headers").replace("\n","\r\n")
                
                if headers_with_r_n[-1] == "\n":
                    headers_with_r_n += "Content-Length: %d\r\n\r\n" % contentlen
                else:
                    headers_with_r_n += "\r\nContent-Length: %d\r\n\r\n" % contentlen
                headers_with_r_n += content
                
                httpreq_string = "{method} {uri} HTTP/1.1\r\n{headers}".format(
                    method=self.get_variable("$method"),
                    uri=self.get_variable("$uri"),
                    headers=headers_with_r_n)
    
        
        return httpreq_string    
    
    def build_http_response_string(self):
        datestr = time.strftime("%a, %d %b %Y %H:%M:%S %Z",time.gmtime())
        httpresp_string = "{httpver} {code}\r\nServer: {server}\r\nDate: {date}\r\nContent-Type: {contenttype}\r\nContent-Length: {contentlen}\r\nConnection: keep-alive\r\nX-Powered-By: PHP/5.3.11-1~dotde b0\r\n\r\n{content}".format(
            httpver=self.get_variable("$resp-httpver"),
            code=self.get_variable("$resp-code"),
            server=self.get_variable("$resp-server"),
            date=datestr,
            contenttype=self.get_variable("$resp-content-type"),
            contentlen=len(self.get_variable("$resp-content")),
            content=self.get_variable("$resp-content")) 

        return httpresp_string
