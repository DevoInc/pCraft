from scapy.all import Ether, IP, UDP, DNS, DNSQR, DNSRR
from . import _utils as utils

class PCraftPlugin(object):
    name = "DNSConnection"

    def help(self):
        helpstr="""
## DNSConnection

Create a DNS Connection towards a domain that was either set in a previous plugin, or 
being set in the local script scope.

### Examples

#### 1: Connect to a domain set previously from the plugin chain

```
dnsconnect:
  _plugin: DNSConnection
  _next: done
```

#### 2: Connect to a domain set in the local script scope

```
dnsconnect:
  _plugin: DNSConnection
  domain: "www.example.com"
  _next: done
```

"""
        return helpstr
    
    def __init__(self, plugins_data):
        self.plugins_data = plugins_data
        self.random_client_ip = utils.getRandomIP("192.168.0.0/16", ipfail="172.16.42.42")
        self.random_server_ip = utils.getRandomIP("10.0.0.0/8", ipfail="172.17.42.42")

    def run(self, script=None):
        try:
            srcip = self.plugins_data._get("srcip")
        except KeyError:
            self.plugins_data._set("srcip",self.random_client_ip.get())

        try:
            #if script["newip"]: # It must be configured from the loop, FIXME ASAP
            if self.plugins_data._get("newip"):
                self.plugins_data._set("srcip", self.random_client_ip.get())
        except:
            pass
            
        dstip=self.random_server_ip.get()
        dns_resp_ip = "199.34.228.66"
        self.plugins_data._set("dstip", dns_resp_ip)


        #
        # Replace Global variables from Local ones
        # 
        if "domain" in script:
            domain = script["domain"]
        else:
            domain = self.plugins_data._get("domain")

            
        query = Ether() / IP(src=self.plugins_data._get("srcip"),dst=dstip) / UDP(sport=4096,dport=53)/DNS(rd=1, qd=DNSQR(qname=domain))
        self.plugins_data.pcap.append(query)
        resp = Ether() / IP(dst=self.plugins_data._get("srcip"),src=dstip) / UDP(sport=53,dport=4096)/DNS(id=query[DNS].id, qr=1, qd=query[DNS].qd, an=DNSRR(rrname=query[DNS].qd.qname, rdata=dns_resp_ip))
        self.plugins_data.pcap.append(resp)
        
        return script["_next"], self.plugins_data
