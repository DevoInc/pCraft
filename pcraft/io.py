import io
from scapy.utils import PcapWriter, wrpcap
from . import Pipe

pp = Pipe.PcraftPipe()

def get_pcap_header():
    return bytes([0xd4,0xc3,0xb2,0xa1,0x02,0x00,0x04,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x01,0x00,0x00,0x00])

def raw_packet_from_scapy(scapy_pkt):
    fd = io.BytesIO()
    with PcapWriter(fd, sync=True) as writer:
        writer.write(scapy_pkt)
        writer.flush()
        return fd.getvalue()[24:]
        # return fd.getvalue()[54:]
        # return fd.getvalue()
    
def get_stdin():
    return pp.decode_stdin()

def put_stdout(data):
    return pp.encode_stdout(data)
