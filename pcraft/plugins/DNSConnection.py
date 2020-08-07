from scapy.all import Ether, IP, UDP, DNS, DNSQR, DNSRR
from pcraft.PluginsContext import PluginsContext
from . import _utils as utils

class PCraftPlugin(PluginsContext):
    name = "DNSConnection"
    required = ["domain"]
    
    def help(self):
        helpstr="""
Create a DNS Connection towards a domain that was either set in a previous plugin, or 
being set in the local script scope.

### Examples

#### 1: Connect to a domain set previously from the plugin chain

```
dnsconnect:
  _plugin: DNSConnection
  _next: done
```

#### 2: Connect to a domain set in the local script scope using 8.8.8.8 as our resolver

```
dnsconnect:
  _plugin: DNSConnection
  domain: "www.example.com"
  resolver: "8.8.8.8"
  _next: done
```

"""
        return helpstr

    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        self.random_client_ip = utils.getRandomIP("192.168.0.0/16", ipfail="172.16.42.42")
        self.random_server_ip = utils.getRandomIP("10.0.0.0/8", ipfail="172.17.42.42")

    def run(self, script=None):
        self.check_required(script, self.required)
        self.update_vars_from_script(script)

        self.set_value_or_default(script, "ip-src", self.random_client_ip.get())
        self.set_value_or_default(script, "ip-dst", self.random_server_ip.get())
        self.set_value_or_default(script, "resolver", "1.1.1.1")
        self.set_value_or_default(script, "domain", "example.com") # Default is never applied since it is a requirement

        try:
            #if script["newip"]: # It must be configured from the loop, FIXME ASAP
            if self.getvar("newip"):
                self.setvar("ip-src", self.random_client_ip.get())
        except:
            pass

            
        query = Ether() / IP(src=self.getvar("ip-src"),dst=self.getvar("resolver")) / UDP(sport=4096,dport=53)/DNS(rd=1, qd=DNSQR(qname=self.getvar("domain")))
        self.plugins_data.pcap.append(query)
        resp = Ether() / IP(dst=self.getvar("ip-src"),src=self.getvar("resolver")) / UDP(sport=53,dport=4096)/DNS(id=query[DNS].id, qr=1, qd=query[DNS].qd, an=DNSRR(rrname=query[DNS].qd.qname, rdata=self.getvar("ip-dst")))
        self.plugins_data.pcap.append(resp)

        if script:
            return script["_next"], self.plugins_data
        else:
            return None, self.plugins_data
        
