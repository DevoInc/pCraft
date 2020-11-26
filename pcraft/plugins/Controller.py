from scapy.all import Ether, IP, TCP
from scapy.layers import http
from . import _utils as utils
import random
import os
import time

from pcraft.PluginsContext import PluginsContext

class PCraftPlugin(PluginsContext):
    name = "Controller"
    
    def help(self):
        helpstr="""
Controller, which helps to add special paquets for specific purposes out of pcap. For example to generate endpoint logs etc.

If we match a source and destination IP of 10.10.10.10 and source and destination port of 666 we know what to do.

If you do not know what this it, do not use it.

"""
        return helpstr
    
    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        self.seq = 0
        
    def run(self, ami, action):
        action_ptr = action
        kvstring=""
        afa = action.FieldActions()
        for field, action in afa.items():
            for actiontype, actionval in action.items():
                if actiontype == "set":
                    for k, v in actionval.items():
                        kvstring += "%s='''%s''' " % (field,k)
                        
        req = http.HTTPRequest(
            Path=b'/' + bytes(self.getvar("log_plugin").encode("utf-8")),
            User_Agent=b'' + bytes(kvstring.encode("utf-8"))
        )
        httpreq = Ether() / IP(src="10.10.10.10",dst="10.10.10.10") / TCP(sport=666,dport=666, flags="P""A", seq=self.seq) / req
        self.plugins_data.AddPacket(action_ptr, httpreq)

        self.seq += len(httpreq['TCP'].payload)
        if self.seq > 2147483647: # 2^32 - 1
            self.seq = 0
        
        return self.plugins_data

