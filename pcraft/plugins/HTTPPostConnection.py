from scapy.all import Ether, IP, TCP
from . import _utils as utils
import random
import os
import time
from pcraft.PluginsContext import PluginsContext

class PCraftPlugin(PluginsContext):
    name = "HTTPPostConnection"
    required = ["ip-src", "ip-dst", "domain"]
    
    def help(self):
        helpstr="""
Creates an http request and response with a random content of a length of 122.

### Examples

#### 1: A Simple HTTP POST Request
```
httpconnect:
  _plugin: HTTPConnection
  _next: done
```
"""
        return helpstr
    
    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        self.random_client_ip = utils.getRandomIP("192.168.0.0/16", ipfail="172.16.42.42")

    def run(self, script=None):
        try:
            ipsrc = self.plugins_data._get("ip-src")
        except KeyError:
            self.plugins_data._set("ip-src", self.random_client_ip.get())
        # print("Create a HTTP connection from %s to %s" % (inobj["ip-src"],inobj["domain"]))

        srcport = random.randint(4096,65534)
        last_ack = utils.append_tcp_three_way_handshake(self.plugins_data, srcport)

        httpget_string = "POST /g.php HTTP/1.1\r\nAccept: */*\r\nUser-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.1)\r\nHost:" + self.plugins_data._get("domain") + "\r\nContent-Length:122\r\nConnection: Keep-Alive\r\nCache-Control: no-cache\r\n\r\n" + str(os.urandom(122))
        httpreq1 = Ether() / IP(src=self.plugins_data._get("ip-src"),dst=self.plugins_data._get("ip-dst")) / TCP(sport=srcport,dport=80, seq=last_ack[TCP].ack, ack=last_ack[TCP].seq, flags="P""A") / httpget_string
        self.plugins_data.pcap.append(httpreq1)

        # Add the ACK To last http frame
        # "Wed, 09 May 2012 21:35:50 GMT"
        datestr = time.strftime("%a, %d %b %Y %H:%M:%S %Z",time.gmtime())
        httpget_string = "HTTP/1.1 200 OK\r\nServer: nginx\r\bDate: " + datestr + "\r\nContent-Type: text/html\r\nTransfer-Encoding: chunked\r\nConnection: keep-alive\r\nX-Powered-By: PHP/5.3.11-1~dotde b\r0\r\n\r\n" 
        httpreq2 = Ether() / IP(src=self.plugins_data._get("ip-dst"),dst=self.plugins_data._get("ip-src")) / TCP(sport=80,dport=srcport, seq=httpreq1[TCP].ack, ack=httpreq1[TCP].seq + 1, flags="P""A") / httpget_string
        self.plugins_data.pcap.append(httpreq2)
        
        
        return script["_next"], self.plugins_data

