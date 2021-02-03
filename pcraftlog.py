#!/usr/bin/env python3
import sys
import os
import random
import csv
import ipaddress

from scapy.all import wrpcap
from scapy.utils import PcapWriter

import pyami

from pcraft.Application import *
from LogWrite import LogWrite

def ami2pcap(amifile, pcap):
    app = Application(scenariofile=amifile, pcap_out=pcap)
    plugins_loader = app.plugins_loader
    loaded_plugins = app.loaded_plugins
    
    print("Opening Script File %s" % amifile)
    scenario_file = app.scenariofile

    # print("Executing %d actions" % len(app.actions))
    
    for action in app.actions:
        for k, v in action.Variables().items():
            plugins_loader.plugins_data._set(k[1:], v) # we trim the $ sign for the key name
        loaded_plugins[action.Exec()].run(app.ami, action)
        
    wrpcap(pcap, plugins_loader.get_plugins_data().pcap)
    app.finalize()

def pcap2logs(pcap, logsdir):
    writer = LogWrite(pcap, logsdir, "-f" in sys.argv)
    if writer.has_error:
        print("Error. Exiting.")
        sys.exit(1)
        
    writer.process()    

    # replace_fp = open("replacer.csv", "r")
    # replace_reader = csv.DictReader(replace_fp)
    # for row in replace_reader:
    #     print(row["ip"])
    #     str(ip) for ip in ipaddress.IPv4Network('192.0.2.0/28')]    
        
    
if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Syntax: %s script.ami output_directory" % sys.argv[0])
        sys.exit(1)

    amifile = sys.argv[1]
    outdir = sys.argv[2]
    tmppcap = str(random.randrange(100000,99999999)) + ".pcap"    
        
    ami2pcap(amifile, tmppcap)
    pcap2logs(tmppcap, outdir)

    os.unlink(tmppcap)
    
