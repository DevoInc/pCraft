#!/usr/bin/env python3
import pyshark
import sys
from datetime import datetime
from pyfaup.faup import Faup
import ipaddress

pcap_file = sys.argv[1]

faup_ctx = Faup()

current_time = 0
sleep_cursor = 0

cap = pyshark.FileCapture(pcap_file)
count = 0

domains = []

try:
    for packet in cap:
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))
        if hasattr(packet, 'http'):
            try:
                full_uri = packet.http.request_full_uri
            except AttributeError:
                continue

            if current_time == 0:
                current_time = frame_time.timestamp()
            else:
                if frame_time.timestamp() - current_time:
                    sleep_cursor = frame_time.timestamp() - current_time
                    current_time = frame_time.timestamp()

            if (sleep_cursor > 0):
                print("sleep %d" % (sleep_cursor))
                    
            faup_ctx.decode(full_uri)
            domain = faup_ctx.get_domain()
            if domain in domains:
                domains.append(domain)
            else:
                try:
                    ip = ipaddress.ip_address(domain)
                except ValueError:
                    print("action DNS%d {" % (count))
                    print("    exec DNSConnection")
                    print("    $ip-dst = \"%s\"" % packet.ip.src)
                    print("    $domain = \"%s\"" % domain)
                    print("}\n")
                
            print("action HTTP%d {" % (count))
            print("    exec HTTPConnection")
            print("    $method = \"%s\"" % packet.http.request_method)
            print("    $ip-src = \"%s\"" % packet.ip.src)
            print("    $ip-dst = \"%s\"" % packet.ip.src)
            print("    $domain = \"%s\"" % domain)
            print("    $uri = \"%s\"" % (faup_ctx.get_resource_path()))
            print("}")        
    
            count += 1
except:
    pass

