from enum import Enum, Flag, auto

import communityid
import random

class Protocol(Enum):
    ICMP = 1
    TCP = 6
    UDP = 17
    ICMP6 = 58
    SCTP = 132

def protocol_to_string(protocol):
    if protocol == Protocol.TCP:
        return "tcp"
    if protocol == Protocol.UDP:
        return "udp"
    
class Flow(Flag):
    UNKNOWN = 0
    TO_CLIENT = auto()
    TO_SERVER = auto()
    FROM_CLIENT = auto()
    FROM_SERVER = auto()

class VirtualPacket(object):
    def __init__(self):
        self.packet_size = 0
        self.frame_time = 0
        self.layer = None
        self.ip_src = None
        self.ip_dst = None
        self.port_src = None
        self.post_dst = None
        self.packet_id = 0
        self.protocol = Protocol.TCP
        self.flow = Flow.UNKNOWN
        self.flow_id = 0
        self.cid = communityid.CommunityID()
        self.icmp_type = 10
        self.icmp_code = 8

    def __str__(self):
        pstr = "flowid={flowid},ip_src={ip_src},ip_dst={ip_dst},port_src={port_src},port_dst={port_dst}".format(
            flowid=self.flow_id,
            ip_src=self.ip_src,
            port_src=self.port_src,
            ip_dst=self.ip_dst,
            port_dst=self.port_dst
        )
        return pstr
        
    def get_flowid(self, protocol, ip_src, ip_dst, port_src, port_dst):
        flow_tuple = None
        if protocol == Protocol.TCP:
            try:
                flow_tuple = communityid.FlowTuple.make_tcp(ip_src, ip_dst, port_src, port_dst)
            except communityid.error.FlowTupleError:
                print("Error getting TCP source port/destination")
                flow_tuple = communityid.FlowTuple.make_tcp(ip_src, ip_dst, 4096, 80)
        if protocol == Protocol.UDP:
            try:
                flow_tuple = communityid.FlowTuple.make_udp(ip_src, ip_dst, port_src, port_dst)
            except communityid.error.FlowTupleError:
                print("Error getting UDP source port/destination")
                flow_tuple = communityid.FlowTuple.make_udp(ip_src, ip_dst, 4096, 53)
        if protocol == Protocol.ICMP:
            try:
                flow_tuple = communityid.FlowTuple.make_icmp(ip_src, ip_dst, self.icmp_type, self.icmp_code)
            except communityid.error.FlowTupleError:
                print("Error getting ICMP source port/destination")
                flow_tuple = communityid.FlowTuple.make_icmp(ip_src, ip_dst, self.icmp_type, self.icmp_code)

        if not flow_tuple:
            flow_tuple = communityid.FlowTuple.make_ip(ip_src, ip_dst, Protocol.TCP.value)

        computed = None
        try:
            computed = self.cid.calc(flow_tuple)
        except communityid.error.FlowTupleError:
            flow_tuple = communityid.FlowTuple.make_ip(ip_src, ip_dst, Protocol.TCP.value)
            computed = self.cid.calc(flow_tuple)

        return computed
        
    def build(self, layer, protocol, flow, ip_src, ip_dst, port_src, port_dst, packet_size=None, frame_time=None):
        self.layer = layer
        self.protocol = protocol
        self.flow = flow
        self.ip_src = ip_src
        self.ip_dst = ip_dst
        self.port_src = port_src
        self.port_dst = port_dst
        
        self.packet_id += 1
        if not packet_size:
            self.packet_size = random.randint(54, 512)
        self.flow_id = self.get_flowid(protocol, ip_src, ip_dst, port_src, port_dst)
