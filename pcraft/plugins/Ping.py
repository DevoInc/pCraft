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

    def __init__(self, ami, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        self.plugins_data = plugins_data
        self.random_client_ip = utils.getRandomIP("192.168.0.0/16", ipfail="172.16.42.42")
        self.session = session

    def run(self, ami, action):
        self.set_value_or_default(action, "ip-src", self.random_client_ip.get())
        self.set_value_or_default(action, "ip-dst", self.random_client_ip.get())

        all_ips = IP_y(self.getvar("ip-dst"))

        has_started = False
        ipstart = self.getvar("ipstart")
        if ipstart == None:
            has_started = True

        ipstop = self.getvar("ipstop")
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
            echo_request = Ether() / IP(src=self.getvar("ip-src"), dst=str(individual_ip)) / ICMP(type="echo-request")
            self.plugins_data.AddPacket(action, echo_request)
            echo_reply = Ether() / IP(src=str(individual_ip), dst=self.getvar("ip-src")) / ICMP(type="echo-reply")
            self.plugins_data.AddPacket(action, echo_reply)
            if str(individual_ip) == ipstop:
                has_stoped= True


        return self.getvar("_next"), self.plugins_data
