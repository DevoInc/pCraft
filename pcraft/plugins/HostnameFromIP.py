import struct
import socket
import sys

from pcraft.PluginsContext import PluginsContext

vowels = ['a','e','i','o','u','y','a','e','i','o']
consonants = ['p','b','c','z','m','f','d','s','t','r']

class PCraftPlugin(PluginsContext):
    name = "HostnameFromIP"
    
    def help(self):
        helpstr="""
Generates a Hostname from an IP address. The name will be sonsistent.

### Examples

#### 1: Creates the variable hostname from an IP

```
namefromip:
  _plugin: HostnameFromIP
  ip: $ip-src
  _next: done
```
"""
        return helpstr

    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)

    def run(self, script=None):
        ipaddr = script["ip"]

        try:
            iptoint=struct.unpack("!I", socket.inet_pton(socket.AF_INET, ipaddr))[0]
        except OSError: # illegal IP address string passed to inet_pton
            iptoint=struct.unpack("!IIII", socket.inet_pton(socket.AF_INET6, ipaddr))[0]
    
        ipstr = str(iptoint)
        outstr = ""
        pos = 0
        for i in ipstr:
            n = int(i)
            if pos % 2:
                outstr += vowels[n]
            else:
                outstr += consonants[n]

            pos += 1
        
        self.plugins_data._set("hostname", outstr)
        
        return script["_next"], self.plugins_data


if __name__ == "__main__":
        ipaddr = sys.argv[1]

        try:
            iptoint=struct.unpack("!I", socket.inet_pton(socket.AF_INET, ipaddr))[0]
        except OSError: # illegal IP address string passed to inet_pton
            iptoint=struct.unpack("!IIII", socket.inet_pton(socket.AF_INET6, ipaddr))[0]
    
        ipstr = str(iptoint)
        outstr = ""
        pos = 0
        for i in ipstr:
            n = int(i)
            if pos % 2:
                outstr += vowels[n]
            else:
                outstr += consonants[n]

            pos += 1


        print(outstr)
        
