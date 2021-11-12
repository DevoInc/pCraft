#!/usr/bin/env python3
import os

from IPy import IP as IP_y
from scapy.all import Ether, CookedLinux, IP, TCP, UDP, rdpcap

from pcraft import io as PcraftIO
from pcraft.LibraryContext import *
from pcraft.Packet import *

class PcraftPcapWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        self.sleep_cursor = 0
        
    def run(self, event):
        self.sleep_cursor = 0

        to_replace = event["freplace"]
        
        pcapfile = event["variables"]["$filename"]

        pcap_import_only_replaced_packets = None
        if "$pcap_import_only_replaced_packets" in event["variables"]:
            if event["variables"]["$pcap_import_only_replaced_packets"].upper() == "TRUE":
                pcap_import_only_replaced_packets = True
        
        n_items_replaced = 0
        packets_injected = 0
        packets = rdpcap(pcapfile)
        last_packet = None
        seq = 0

        for packet in packets:
            packet_time = int(packet.time)
            sleep_delta = 0
            
            if packet_time > self.sleep_cursor:
                # print("%s > %s" % (packet_time, self.sleep_cursor))
                if self.sleep_cursor != 0:
                    sleep_delta = packet_time - self.sleep_cursor
                self.sleep_cursor = packet_time

            self.sleep_cursor += float(sleep_delta)
            # print("New sleep cursor:%f" % new_sleep_cursor)
            # action.SetSleepCursor(self.sleep_cursor + append_sleep)
            
            if CookedLinux in packet:
                packet = Ether() / packet.payload
                        
            try:
                del packet[IP].chksum
                del packet[TCP].chksum
                del packet[UDP].chksum
            except IndexError:
                pass

            if to_replace:
                ip_to_replace = None
                for k, v in to_replace.items():
                    we_replaced = False
                    ip_to_replace = k
                    ip_replacement = IP_y(v)

                    if packet.haslayer(IP):
                        if packet[IP].src == ip_to_replace:
                            packet[IP].src = str(ip_replacement)
                            n_items_replaced += 1
                            we_replaced = True
                        if packet[IP].dst == ip_to_replace:
                            packet[IP].dst = str(ip_replacement)
                            n_items_replaced += 1
                            we_replaced = True

                if we_replaced and pcap_import_only_replaced_packets:
                    pkt = PcraftIO.raw_packet_from_scapy(packet)
                    yield PcraftPacket("network", pkt)
                    packets_injected += 1
                else:
                    if not pcap_import_only_replaced_packets:
                        pkt = PcraftIO.raw_packet_from_scapy(packet)
                        yield PcraftPacket("network", pkt)

                        packets_injected += 1

                    # seq += 1
                last_packet = packet
                            
            else: # if to_replace
                pkt = PcraftIO.raw_packet_from_scapy(packet)
                yield PcraftPacket("network", pkt)
                packets_injected += 1
                
        # print("we replaced %d items" % ( n_items_replaced) )
        # print("Imported %d packets" % (packets_injected) )
