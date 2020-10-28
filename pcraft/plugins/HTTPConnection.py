from scapy.all import Ether, IP, TCP
from pcraft.PluginsContext import PluginsContext
from . import _utils as utils
import random
import os
import time
import sys

class PCraftPlugin(PluginsContext):
    name = "HTTPConnection"
    required = ["ip-dst", "domain"]
    
    def help(self):
        helpstr="""
Creates an http request and response with a random content of a length of 122.

### Examples

#### 1: A Simple HTTP Connection
```
httpconnect:
  _plugin: HTTPConnection
  method: "GET"
  uri: "/index.php"
  user-agent: "Mozilla/5.0"
  _next: done
```
"""
        return helpstr
    
    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        self.plugins_data = plugins_data
        self.random_client_ip = utils.getRandomIP("192.168.0.0/16", ipfail="172.16.42.42")
        self.session = session
        
    def run(self, ami, action):
        self.set_value_or_default(action, "ip-src", self.random_client_ip.get())
        self.set_value_or_default(action, "ip-dst", "0.0.0.0")
        self.set_value_or_default(action, "domain", "www.example.com")
        self.set_value_or_default(action, "port-src", random.randint(4096,65534))
        self.set_value_or_default(action, "method", "GET") 
        self.set_value_or_default(action, "user", "") 
        self.set_value_or_default(action, "user-agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Pcraft/0.0.7") 
        self.set_value_or_default(action, "uri", "/")
        self.set_value_or_default(action, "resp-httpver", "HTTP/1.1")
        self.set_value_or_default(action, "resp-code", "200 OK")
        self.set_value_or_default(action, "resp-server", "nginx")
        self.set_value_or_default(action, "resp-content-type", "text/html")
        self.set_value_or_default(action, "resp-content", "<html><body>Hello, you!</body></html>")
        self.set_value_or_default(action, "client-headers", "") 
        self.set_value_or_default(action, "client-content", "") 

        
        # print("port src:%s" % self.getvar("port-src"))
        utils.append_tcp_three_way_handshake(self.session, self.plugins_data, self.getvar("port-src"))

        # print(action.Variables())
        print("HTTP Method:%s" % self.getvar("method"))
        
        user = self.getvar("user")
        if user != "":
            user = "\r\nUser: %s" % user
            
        httpreq_string = "{method} {uri} HTTP/1.1\r\nAccept: */*\r\nUser-Agent: {useragent}\r\nHost:{host}{user}\r\nConnection: Keep-Alive\r\n\r\n".format(
            method=self.getvar("method"),
            uri=self.getvar("uri"),
            useragent=self.getvar("user-agent"),
            host=self.getvar("domain"),
            user=user)

        if self.getvar("method").upper() == "POST":
            httpreq_string = "{method} {uri} HTTP/1.1\r\nAccept: */*\r\nUser-Agent: {useragent}\r\nHost:{host}{user}\r\nContent-Type:{contenttype}\r\nContent-Length:{contentlen}\r\n\r\n{content}".format(
                method=self.getvar("method"),
                uri=self.getvar("uri"),
                useragent=self.getvar("user-agent"),
                host=self.getvar("domain"),
                user=user,
                contenttype=self.getvar("client-content-type"),
                contentlen=len(self.getvar("client-content")),
                content=self.getvar("client-content"))

            if self.getvar("client-headers") != "":
                content = self.getvar("client-content")
                contentlen = 0
                if content != "":
                    contentlen = len(content)
                else:
                    raise ValueError("We have client-headers without client-content in a POST method!")
                headers_with_r_n = self.getvar("client-headers").replace("\n","\r\n")
                
                if headers_with_r_n[-1] == "\n":
                    headers_with_r_n += "Content-Length: %d\r\n\r\n" % contentlen
                else:
                    headers_with_r_n += "\r\nContent-Length: %d\r\n\r\n" % contentlen
                headers_with_r_n += content
                
                httpreq_string = "{method} {uri} HTTP/1.1\r\n{headers}".format(
                    method=self.getvar("method"),
                    uri=self.getvar("uri"),
                    headers=headers_with_r_n)
                                    
        datestr = time.strftime("%a, %d %b %Y %H:%M:%S %Z",time.gmtime())
        httpresp_string = "{httpver} {code}\r\nServer: {server}\r\nDate: {date}\r\nContent-Type: {contenttype}\r\nContent-Length: {contentlen}\r\nConnection: keep-alive\r\nX-Powered-By: PHP/5.3.11-1~dotde b0\r\n\r\n{content}".format(
            httpver=self.getvar("resp-httpver"),
            code=self.getvar("resp-code"),
            server=self.getvar("resp-server"),
            date=datestr,
            contenttype=self.getvar("resp-content-type"),
            contentlen=len(self.getvar("resp-content")),
            content=self.getvar("resp-content")) 
        
        # httpget_string = "POST /g.php HTTP/1.1\r\nAccept: */*\r\nUser-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.1)\r\nHost:" + self.plugins_data._get("domain") + "\r\nContent-Length:122\r\nConnection: Keep-Alive\r\nCache-Control: no-cache\r\n\r\n" + str(os.urandom(122))
        httpreq1 = Ether() / IP(src=self.getvar("ip-src"),dst=self.getvar("ip-dst")) / TCP(sport=self.getvar("port-src"),dport=80, flags="P""A") / httpreq_string

        self.session.append_to_session(httpreq1)
        httpreq1 = self.session.fix_seq_ack(httpreq1)    

        self.plugins_data.pcap.append(httpreq1)

        # self.session.append_to_session(httpreq1)
        
        ack = Ether() / IP(src=self.getvar("ip-src"),dst=self.getvar("ip-dst")) / TCP(sport=80, dport=self.getvar("port-src"), flags="A")

        self.session.append_to_session(ack)
        ack = self.session.fix_seq_ack(ack)
        self.plugins_data.pcap.append(ack)
        
        httpreq2 = Ether() / IP(src=self.getvar("ip-dst"),dst=self.getvar("ip-src")) / TCP(sport=80,dport=self.getvar("port-src"), flags="P""A") / httpresp_string

        self.session.append_to_session(httpreq2)
        httpreq2 = self.session.fix_seq_ack(httpreq2)

        self.plugins_data.pcap.append(httpreq2)

        # self.session.append_to_session(httpreq2)

        # self.session.debug_session()

        return self.plugins_data
