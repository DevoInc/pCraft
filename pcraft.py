#!/usr/bin/python3 -B
import sys
import os
import time
import argparse

import pyami

from pcraft.confnames import *

from pcraft.PackageManager import PackageManager
from pcraft.PcapBuilder import PcapBuilder
from pcraft.LogsBuilder import LogsBuilder


verbose = False                
def debug(message):
    if verbose:
        print(message)
                
class RunPcraft(object):
    def __init__(self, pkg, args):
        self.current_time = time.time()
        
        self.pkg = pkg
        self.args = args

        self.ami = pyami.Ami()
        self.ami_cache = self.args["script"]
        
        if not args["script"].endswith(".amic"):
            self.ami_cache = os.path.join(os.path.dirname(self.args["script"]), "." + os.path.basename(self.args["script"]) + "c")            
            self.build_cache()
        else:
            print("Reading cache file %s" % self.ami_cache)

        if self.args["pcap"]:
            self.build_pcap(self.args["pcap"])

        if self.args["log_folder"]:
            self.build_logs(self.args["log_folder"], self.args["force"])
            
    def build_cache(self):
        debug("Building cache: %s" % self.ami_cache)
        self.ami.Cache(self.args["script"], self.ami_cache)
        debug("Done building cache")

    def build_pcap(self, pcapfile):
        pcap_builder = PcapBuilder(self.pkg, self.ami_cache)
        pcap_builder.build(pcapfile)

    def build_logs(self, log_folder, force):
        logs = LogsBuilder(self.pkg, self.ami_cache, log_folder, force)
        logs.build()

        
if __name__ == "__main__":

    parser = argparse.ArgumentParser(exit_on_error=True)
    parser.add_argument("script", type=str, help="The script to run")
    parser.add_argument("-p", "--pcap", type=str, help="The pcap to build") 
    parser.add_argument("-l", "--log-folder", type=str, help="The log folder")
    parser.add_argument("-f", "--force", help="overwrite the log folder", action="store_true")
    parser.add_argument("-v", "--verbose", action="store_true")    
    args = parser.parse_args()
    vargs = vars(args)
    verbose = vargs["verbose"]
    
    if (not vargs["pcap"]) and (not vargs["log_folder"]):
        parser.print_usage()
        print("%s: error: argument -p/--pcap OR -l/--log-folder required" % sys.argv[0])
        sys.exit(1)
        
    pkg = PackageManager()
    pe = RunPcraft(pkg, vargs)
