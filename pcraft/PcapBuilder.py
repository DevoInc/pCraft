import sys
# import pyshark

import pycapng

from scapy.all import *

from avro.datafile import DataFileReader
from avro.io import DatumReader

from pcraft import io as PcraftIO
from pcraft.Sessionizer import *

PCAPNG_CUSTOM_PEN = 58353

class PcapBuilder(object):
    def __init__(self, pkg, ami_cache):
        self.pkg = pkg
        self.ami_cache = ami_cache

        self.pcapng = pycapng.PcapNG()
        self.avro_reader = DataFileReader(open(self.ami_cache, "rb"), DatumReader())

        self.session = Session()

    def build(self, pcapfile):
        self.pcapng.OpenFile(pcapfile, "w")

        for event in self.avro_reader:
            event_time = event["time"]
            
            pcapmod = self.pkg.get_pcap_module(event["exec"])
            if not pcapmod:
                print("Package module '%s' does not contain a pcap writer!" % event["exec"])
                sys.exit(1)

            
            for packet in pcapmod.run(event):
                pkt_type = packet.packet_type
                pkt = packet.packet_data
                if pkt_type == "network":
	            # We rebuild the packet because packets building can come from anything.
	            # We just see a buffer. We need to have a proper session, and the correct time.
                    scapy_pkt = Ether(pkt[16:])
	            # scapy_pkt.show()
                    if scapy_pkt.haslayer(TCP): # Fix the session
                        self.session.append_to_session(scapy_pkt)
                        scapy_pkt = self.session.fix_seq_ack(scapy_pkt)
	
                    pkt = PcraftIO.raw_packet_from_scapy(scapy_pkt)
                    pkt = pkt[2:] # FIXME: This is a hack because I cannot slice the scapy packet properly in the PcraftIO.raw_packet_from_scapy function

                    self.pcapng.WritePacketTime(pkt, event_time)
                elif pkt_type == "custom":     
                    self.pcapng.WriteCustom(PCAPNG_CUSTOM_PEN, pkt, "")
                elif pkt_type == "debug":
                    pass
                else:
                    print("Error: unknown packet type:%s. It must be either 'network' or 'custom'" % pkt_type)
                    sys.exit(1)
                    
        self.pcapng.CloseFile()


class Pcap2Logs(object):
    def __init__(self):
        pass
    # def _logwrite_network(self):
    #     if not self.pcap_shark:
    #         self.pcap_shark = pyshark.FileCapture(self.pcapout)

    #     for pkt in self.pcap_shark:
    #         self.packet_id += 1

    #         for layer in pkt.layers:
    #             layer_name = layer.layer_name
    #             # print("Searching plugin to match layer: %s" % layer_name)
    
