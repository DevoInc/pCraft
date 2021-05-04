import random

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

    def __init__(self, ami, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        self.random_client_ip = utils.getRandomIP("192.168.0.0/16", ipfail="172.16.42.42")
        self.random_server_ip = utils.getRandomIP("10.0.0.0/8", ipfail="172.17.42.42")
        self.session = session

    def variable(self, varname, event=None):
        var = self.getvar(varname)
        if var:
            return var
        if varname == "$ip-src":
            return self.random_client_ip.get()
        elif varname == "$ip-dst":
            return self.random_client_ip.get()
        elif varname == "$protocol":
            return "udp"
        elif varname == "$resolver":
            return "1.1.1.1"
        elif varname == "$port-src":
            return str(random.randint(4096, 65534))
        elif varname == "$port-dst":
            return "53"

        print("Warning: unknown variable %s!" % varname)
        return None

    # def set_network_variables(self, vardict, event=None):
    #     if not "port-src" in vardict:
    #         vardict["port-src"] = self.variable("port-src", event)
    
    def run(self, ami, action):
        self.set_value_or_default(action, "ip-src", self.random_client_ip.get())
        self.set_value_or_default(action, "ip-dst", self.random_server_ip.get())
        self.set_value_or_default(action, "resolver", "1.1.1.1")
        self.set_value_or_default(action, "port-src", str(random.randint(4096, 65534))) 
        self.set_value_or_default(action, "port-dst", "53")
       # self.set_value_or_default(action, "domain", "example.com") # Default is never applied since it is a requirement

        query = Ether() / IP(src=self.getvar("ip-src"),dst=self.getvar("resolver")) / UDP(sport=int(self.getvar("port-src")),dport=int(self.getvar("port-dst")))/DNS(rd=1, qd=DNSQR(qname=self.getvar("domain")))
        self.plugins_data.AddPacket(action, query)
        resp = Ether() / IP(dst=self.getvar("ip-src"),src=self.getvar("resolver")) / UDP(sport=int(self.getvar("port-dst")),dport=int(self.getvar("port-src")))/DNS(id=query[DNS].id, qr=1, qd=query[DNS].qd, an=DNSRR(rrname=query[DNS].qd.qname, rdata=self.getvar("ip-dst")))
        self.plugins_data.AddPacket(action, resp)

        return self.plugins_data
