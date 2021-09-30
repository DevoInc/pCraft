#!/usr/bin/env python3
from scapy.all import Ether, IP, TCP
from pcraft import utils
from pcraft import io as PcraftIO
from pcraft.Defaults import PcraftDefaults
import time


data = PcraftIO.get_stdin()
defaults = PcraftDefaults(data, service="http")

pcapout = []

#
# <functions>
#
def add_three_way_handshake():
    syn, syn_ack, ack = utils.get_tcp_three_way_handshake(defaults.get_variable("ip-src"),
                                                          defaults.get_variable("ip-dst"),
                                                          int(defaults.get_variable("port-src")),
                                                          int(defaults.get_variable("port-dst")))
    pkt = PcraftIO.raw_packet_from_scapy(syn)
    pcapout.append(pkt)
    pkt = PcraftIO.raw_packet_from_scapy(syn_ack)
    pcapout.append(pkt)
    pkt = PcraftIO.raw_packet_from_scapy(ack)
    pcapout.append(pkt)

def set_user():
    user = defaults.get_variable("user")
    if user:
        user = "\r\nUser: %s" % user
    else:
        user = ""

    return user
        
def build_http_request_string():
    httpreq_string = "{method} {uri} HTTP/1.1\r\nAccept: */*\r\nUser-Agent: {useragent}\r\nHost:{host}{user}\r\nConnection: Keep-Alive\r\n\r\n".format(
        method=defaults.get_variable("method"),
        uri=defaults.get_variable("uri"),
        useragent=defaults.get_variable("user-agent"),
        host=defaults.get_variable("domain"),
        user=user)

    if defaults.get_variable("method").upper() == "POST":
        httpreq_string = "{method} {uri} HTTP/1.1\r\nAccept: */*\r\nUser-Agent: {useragent}\r\nHost:{host}{user}\r\nContent-Type:{contenttype}\r\nContent-Length:{contentlen}\r\n\r\n{content}".format(
            method=defaults.get_variable("method"),
            uri=defaults.get_variable("uri"),
            useragent=defaults.get_variable("user-agent"),
            host=defaults.get_variable("domain"),
            user=user,
            contenttype=defaults.get_variable("client-content-type"),
            contentlen=len(defaults.get_variable("client-content")),
            content=defaults.get_variable("client-content"))

        if defaults.get_variable("client-headers") != "":
            content = defaults.get_variable("client-content")
            contentlen = 0
            if content != "":
                contentlen = len(content)
            else:
                raise ValueError("We have client-headers without client-content in a POST method!")
            headers_with_r_n = defaults.get_variable("client-headers").replace("\n","\r\n")
            
            if headers_with_r_n[-1] == "\n":
                headers_with_r_n += "Content-Length: %d\r\n\r\n" % contentlen
            else:
                headers_with_r_n += "\r\nContent-Length: %d\r\n\r\n" % contentlen
            headers_with_r_n += content
            
            httpreq_string = "{method} {uri} HTTP/1.1\r\n{headers}".format(
                method=defaults.get_variable("method"),
                uri=defaults.get_variable("uri"),
                headers=headers_with_r_n)

    
    return httpreq_string    

def build_http_response_string():
    datestr = time.strftime("%a, %d %b %Y %H:%M:%S %Z",time.gmtime())
    httpresp_string = "{httpver} {code}\r\nServer: {server}\r\nDate: {date}\r\nContent-Type: {contenttype}\r\nContent-Length: {contentlen}\r\nConnection: keep-alive\r\nX-Powered-By: PHP/5.3.11-1~dotde b0\r\n\r\n{content}".format(
        httpver=defaults.get_variable("resp-httpver"),
        code=defaults.get_variable("resp-code"),
        server=defaults.get_variable("resp-server"),
        date=datestr,
        contenttype=defaults.get_variable("resp-content-type"),
        contentlen=len(defaults.get_variable("resp-content")),
        content=defaults.get_variable("resp-content")) 

    return httpresp_string
    
#
# </functions>
#

add_three_way_handshake()
user = set_user()

# HTTP Request
httpreq_string = build_http_request_string()
http_request = Ether() / IP(src=defaults.get_variable("ip-src"),dst=defaults.get_variable("ip-dst")) / TCP(sport=int(defaults.get_variable("port-src")), dport=int(defaults.get_variable("port-dst")), flags="P""A") / httpreq_string
pkt = PcraftIO.raw_packet_from_scapy(http_request)
pcapout.append(pkt)

# HTTP Response
ack = Ether() / IP(src=defaults.get_variable("ip-src"),dst=defaults.get_variable("ip-dst")) / TCP(sport=int(defaults.get_variable("port-dst")), dport=int(defaults.get_variable("port-src")), flags="A")
pkt = PcraftIO.raw_packet_from_scapy(ack)
pcapout.append(pkt)

httpresp_string = build_http_response_string()
http_response = Ether() / IP(src=defaults.get_variable("ip-dst"),dst=defaults.get_variable("ip-src")) / TCP(sport=int(defaults.get_variable("port-dst")),dport=int(defaults.get_variable("port-src")), flags="P""A") / httpresp_string
pkt = PcraftIO.raw_packet_from_scapy(http_response)
pcapout.append(pkt)

outdata = {"pcapout": pcapout, "strmap": defaults.get_built_variables()}
# outdata = {"pcapout": pcapout, "strmap": {"debug": httpreq_string}}
PcraftIO.put_stdout(outdata)

