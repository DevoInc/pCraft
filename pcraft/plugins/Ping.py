from IPy import IP as IP_y
from scapy.all import *
from . import _utils as utils

from pcraft.PluginsContext import PluginsContext

class PCraftPlugin(PluginsContext):
    name = "Ping"

    required = ["ip-src", "ip-dst"]
    
    def help(self):
        helpstr="""
Ping and get an ECHO REPLY between two hosts.

### Examples

#### 1: Ping a host

```
ping:
  _plugin: Ping
  _next: done
```
"""
        return helpstr

    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        
    def run(self, script=None):
        # pprint.pprint(script)
        ip = script["ip-dst"]
        all_ips = IP_y(ip)

        has_started = False
        ipstart = ""
        ipstop = ""
        try:
            ipstart = script["ipstart"]
        except:
            has_started = True
        try:
            ipstop = script["ipstop"]
        except:
            pass
        has_stoped = False

        
        for individual_ip in all_ips:
            if has_stoped:
                break

            if str(individual_ip).endswith(".0") or str(individual_ip).endswith(".255"):
                continue
            if not has_started:
                if str(individual_ip) != ipstart:
                    continue
                else:
                    has_started = True
            
            # PING
            echo_request = Ether() / IP(src=script["ip-src"], dst=str(individual_ip)) / ICMP(type="echo-request")
            self.plugins_data.pcap.append(echo_request)
            echo_reply = Ether() / IP(src=str(individual_ip), dst=script["ip-src"]) / ICMP(type="echo-reply")
            self.plugins_data.pcap.append(echo_reply)
            if str(individual_ip) == ipstop:
                has_stoped= True
            
            
        return script["_next"], self.plugins_data
