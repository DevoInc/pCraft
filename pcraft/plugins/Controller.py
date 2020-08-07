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
        
    def run(self, script=None):
        self.update_vars_from_script(script)
        try:
            seq = self.plugins_data._get("seq")
        except KeyError:
            seq = 0
            
        req = http.HTTPRequest(
            Path=b'/' + bytes(script["log_plugin"].encode("utf-8")),
            User_Agent=b'' + bytes(script["kvdata"].encode("utf-8"))
        )
        httpreq = Ether() / IP(src="10.10.10.10",dst="10.10.10.10") / TCP(sport=666,dport=666, flags="P""A", seq=seq) / req
        self.plugins_data.pcap.append(httpreq)

        seq += len(httpreq['TCP'].payload)
        if seq > 2147483647: # 2^32 - 1
            seq = 0
        self.plugins_data._set("seq", seq)
        
        return script["_next"], self.plugins_data

