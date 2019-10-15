from scapy.all import Ether, IP, UDP, DNS, DNSQR, DNSRR
from . import _utils as utils

class PCraftPlugin(object):
    name = "DNSConnection"
    
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
        
        query = Ether() / IP(src=self.plugins_data._get("srcip"),dst=dstip) / UDP(sport=4096,dport=53)/DNS(rd=1, qd=DNSQR(qname=self.plugins_data._get("domain")))
        self.plugins_data.pcap.append(query)
        resp = Ether() / IP(dst=self.plugins_data._get("srcip"),src=dstip) / UDP(sport=53,dport=4096)/DNS(id=query[DNS].id, qr=1, qd=query[DNS].qd, an=DNSRR(rrname=query[DNS].qd.qname, rdata=dns_resp_ip))
        self.plugins_data.pcap.append(resp)
        
        return script["_next"], self.plugins_data
