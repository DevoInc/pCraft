import random
from datetime import datetime
from logwriter.LogContext import LogContext

class LogPlugin(LogContext):
    name = "named"
    active_layer = "dns"
    
    def __init__(self, outpath):
        super().__init__(outpath)
        self.named_log_fp = self.openlog("bind_query.log")
        self.seq = 0
        
    def __del__(self):
        self.closelog()
    
    def template_to_log(self, packet):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))        
        variables = {}
        variables["sequence"] = str(self.seq)
        variables["src_ip_addr"] = packet.ip.src

        if hasattr(packet, 'tcp'):
            sport = packet.tcp.srcport
        if hasattr(packet, 'udp'):
            sport = packet.udp.srcport
        variables["src_port_number"] = sport

        variables["dns_query_name"] = packet.dns.qry_name
        query_type = "E"
        if packet.dns.qry_type == "1":
            query_type = "A"
        variables["dns_query_type"] = query_type
        query_class = "EE"
        if packet.dns.qry_class == "0x00000001":
            query_class = "IN"
        variables["dns_query_class"] = query_class
        
        event = self.retrieve_template("isc.named", "query", variables)        
        event = frame_time.strftime(event)
        
        return event

    def is_request(self, packet):
        if packet.dns.flags == "0x00000100":
            return True

        return False
        
    def run(self, cap, packet, pktid, layer):
        # fields = layer.field_names
        # for field in fields:
        #     print("%s -> %s" % (field, layer.get_field_value(field)))

        if self.is_request(packet):
            self.named_log_fp.write(self.template_to_log(packet))
            self.seq += 1
        
