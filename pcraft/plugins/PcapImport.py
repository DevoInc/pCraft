from IPy import IP as IP_y
from scapy.all import Ether, CookedLinux, IP, TCP, UDP, rdpcap
from . import _utils as utils
import time
import pprint
import os

from pcraft.PluginsContext import PluginsContext


class PCraftPlugin(PluginsContext):
    name = "PcapImport"
    required = ["filename"]

    def help(self):
        helpstr="""
Import a PCAP in the current flow.

### Examples

#### Import a pcap 'phishing.pcap', and replace a bunch of IP addresses

```
importphishing:
  _plugin: PcapImport
  filename: phishing.pcap
  replace: {"ip": {"192.168.0.42": "10.0.0.43",
                   "172.16.32.45": "10.0.0.53",
                   "192.168.0.12": "192.168.0.254",
                  }}
  _next: done
```
"""
        return helpstr
        
    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)
        
    def run(self, script=None):
        # pprint.pprint(script)
        pcap_in = os.path.join(script["__dir"], script["filename"])
        print("Importing PCAP: %s" % pcap_in)

        n_items_replaced = 0
        packets_injected = 0
        
        replace = None
        ip_list = None
        payload_list = None
        try:
            replace = script["replace"]
            ip_list = replace["ip"]            
            payload_list = replace["payload"]
        except:
            pass # That means we have no definition to replace, we won't replace then

        packets = rdpcap(pcap_in)
        last_packet = None
        seq = 0
        for packet in packets:
            packet.time = time.time()
#            print(packet.time)
            if CookedLinux in packet:
                packet = Ether() / packet.payload
                        
            try:
                del packet[IP].chksum
                del packet[TCP].chksum
                del packet[UDP].chksum
            except IndexError:
                pass

            # if packet.haslayer(TCP):
            #     packet[TCP].seq = seq
            #     if packet[TCP].flags == 18: # S|A
            #         print("we have SYN ACK")
            #         packet[TCP].ack = last_packet.seq

            # if payload_list:
            #     payload_sizediff = 0
            #     for k, v in payload_list.items():
            #         if packet.haslayer(TCP):
            #             payload_before = len(packet[TCP].payload)
            #             packet[TCP].payload = str(packet[TCP].payload).replace(k, v)
            #             payload_sizediff += len(packet[TCP].payload) - payload_before
            #             print("Replaced %s by %s in TCP" % (k,v))
            #         if packet.haslayer(UDP):
            #             payload_before = len(packet[UDP].payload)
            #             packet[UDP].payload = str(packet[UDP].payload).replace(k, v)
            #             payload_sizediff += len(packet[UDP].payload) - payload_before
            #             print("Replaced %s by %s in UDP" % (k,v))


            #     packet[IP].len = packet[IP].len + payload_sizediff
                    
            if ip_list:
                ip_to_replace = None
                for k, v in ip_list.items():
                    ip_to_replace = k
                    ip = IP_y(v)

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
                
                    for individual_ip in ip:
#                        print("We replace %s with %s" % (ip_to_replace, individual_ip))
                        if has_stoped:
                            break
                    
                        if str(individual_ip).endswith(".0") or str(individual_ip).endswith(".255"):
                            continue
                        if not has_started:
                            if str(individual_ip) != ipstart:
                                continue
                            else:
                                has_started = True
                        

                        if packet.haslayer(IP):
                            if packet[IP].src == ip_to_replace:
                                packet[IP].src = str(individual_ip)
                                n_items_replaced += 1
                            if packet[IP].dst == ip_to_replace:
                                packet[IP].dst = str(individual_ip)
                                n_items_replaced += 1
                        # else:
                        #     print("No IP Layer")

                        if str(individual_ip) == ipstop:
                            has_stoped = True
                            
                self.plugins_data.pcap.append(packet)
                packets_injected += 1

                    # seq += 1
                last_packet = packet
                            
            else: # if ip_list
                self.plugins_data.pcap.append(packet)
                packets_injected += 1
                
        print("%s replaced %d items" % ( self.name, n_items_replaced) )
        print("Imported %d packets" % (packets_injected) )
            
        return script["_next"], self.plugins_data
