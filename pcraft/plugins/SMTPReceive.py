from scapy.all import Ether, IP, TCP
from . import _utils as utils
import random
import os
import time

class PCraftPlugin(object):
    name = "SMTPReceive"
    
    def __init__(self, app, session, plugins_data):
        self.plugins_data = plugins_data
        self.random_client_ip = utils.getRandomIP("192.168.0.0/16", ipfail="172.16.42.42")
        self.random_server_ip = utils.getRandomIP("10.0.0.0/8", ipfail="172.17.42.42")

    def run(self, script=None):
        try:
            ipsrc = self.plugins_data._get("ip-src")
        except KeyError:
            self.plugins_data._set("ip-src", self.random_client_ip.get())
        # print("Create a HTTP connection from %s to %s" % (inobj["ip-src"],inobj["domain"]))

        self.plugins_data._set("ip-dst", self.random_server_ip.get())

        
        srcport = random.randint(4096,65534)
        last_ack = utils.append_tcp_three_way_handshake_reverse(self.plugins_data, srcport, dstport=25)

        fp = open(script["file"], "r")
        bufstring = fp.read()
        fp.close()

        for k,v in script["replace"].items():
            bufstring = bufstring.replace(k, self.plugins_data._get(v))

#        print(bufstring)

        smtp_message = Ether() / IP(src=self.plugins_data._get("ip-dst"),dst=self.plugins_data._get("ip-src")) / TCP(sport=srcport,dport=25, seq=last_ack[TCP].ack, ack=last_ack[TCP].seq, flags="P""A") / bufstring
        self.plugins_data.pcap.append(smtp_message)
        
        return script["_next"], self.plugins_data

