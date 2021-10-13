#!/usr/bin/env python3
import sys
import pycapng


def eachpacket(block_counter, block_type, block_total_length, data):
    if block_type == pycapng.ENHANCED_PACKET_BLOCK:
        print("ENHANCED_PACKET_BLOCK")
    elif block_type == pycapng.CUSTOM_DATA_BLOCK:
        print("CUSTOM_DATA_BLOCK")
    elif block_type == pycapng.INTERFACE_DESCRIPTION_BLOCK:
        print("INTERFACE_DESCRIPTION_BLOCK")
    elif block_type == pycapng.SECTION_HEADER_BLOCK:
        print("SECTION_HEADER_BLOCK")
    else:
        print("Unhandled PcapNG Block")

pcapng = pycapng.PcapNG()

pcapng.OpenFile(sys.argv[1], "r")
pcapng.ForeachPacket(eachpacket)
pcapng.CloseFile()

