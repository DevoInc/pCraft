from scapy.all import Ether, IP, TCP
from . import _utils as utils
import random
import os
import time

class PCraftPlugin(object):
    name = "Controller"
    
    def help(self):
        helpstr="""
Controller, which helps to add special paquets for specific purposes out of pcap. For example to generate endpoint logs etc.

If we match a source and destination IP of 10.10.10.10 and source and destination port of 666 we know what to do.

If you do not know what this it, do not use it.

"""
        return helpstr
    
    def __init__(self, plugins_data):
        self.plugins_data = plugins_data

    def run(self, script=None):

        httpget_string = "GET {uri} HTTP/1.1\r\nAccept: */*\r\nUser-Agent: {useragent}\r\n\r\n".format(uri="/" + script["log_plugin"], useragent=script["kvdata"])
        
        httpreq = Ether() / IP(src="10.10.10.10",dst="10.10.10.10") / TCP(sport=666,dport=666) / httpget_string
        self.plugins_data.pcap.append(httpreq)
        
        return script["_next"], self.plugins_data

