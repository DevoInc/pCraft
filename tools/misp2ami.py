#!/usr/bin/env python3
import json
import pprint
import sys
from pyfaup.faup import Faup

if len(sys.argv) < 2:
    print("Syntax: %s <misp.event.id.json>" % sys.argv[0])
    sys.exit(1)

fp = open(sys.argv[1], "r")
eventbuf = fp.read()
fp.close()

faupctx = Faup()

jevent = json.loads(eventbuf)['response']

attr_time = None

print("av 1")
amiid = 0
for event in jevent:
    for attr in event["Event"]["Attribute"]:
        amiid += 1
        attr_timestamp = int(attr["timestamp"])
        attr_type = attr["type"]
        attr_value = attr["value"]

        if not attr_time:
            attr_time = attr_timestamp
            print("start_time %d" % attr_time)
            
        if attr_type == "url":
            faupctx.decode(attr_value)
            domain = faupctx.get_host()
            uri = faupctx.get_resource_path()
            scheme = faupctx.get_scheme()
            port_dst = 80
            if scheme:
                if scheme.upper() == "HTTPS":
                    port_dst = 443
            # print(domain)
            print("action http%d {" % amiid)
            print("    $domain = \"%s\"" % domain)
            print("    $ip-dst = ip.gethostbyname($domain)")
            print("    $port-dst = %d" % port_dst)
            if uri and len(uri) > 0:
                print("    $uri    = \"%s\"" % (uri))
            print("    exec HTTPConnection")
            print("}")
            print("delete $port-dst")

        if attr_type == "domain":
            print("action dns%d {" % amiid)
            print("    $domain = \"%s\"" % attr_value)
            print("    $ip-dst = ip.gethostbyname($domain)")
            print("    exec DNSConnection")
            print("}")
            print("")
            
            

        
