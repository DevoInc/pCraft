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
from pcraft.SendData import *

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
        self.cachefile = None
        self.sleep_cursor = self.ami.GetGroupSleepCursor("_global")
        self.ami.DebugSleepCursor()
        self.count_tracker = 1
#        print("Final Sleep Cursor: %d seconds; %d hours; %d days" % (int(self.sleep_cursor), int(self.sleep_cursor / 60 / 60), int(self.sleep_cursor / 60 / 60 / 24)))
        
        if not args["script"].endswith(".amic"):
            self.ami_cache = os.path.join(os.path.dirname(self.args["script"]), "." + os.path.basename(self.args["script"]) + "c")
            self.build_cache(erase_cache=self.args["erasecache"])
        else:
            print("Reading cache file %s" % self.ami_cache)

        if self.args["pcap"]:
            self.build_pcap(self.args["pcap"])

        log_files = None
        if self.args["log_folder"]:
            log_files = self.build_logs(self.args["log_folder"], self.args["force"], self.args["no_triggers"])

        if self.args["log_folder"] and self.args["send_data"]:
            target = self.args["send_data"]
            if target.startswith("s3:"):
                bucket = target.split(":")[1]
                print("Sending data to s3 bucket %s" % bucket)
                push_to_s3(bucket, log_files)

    def get_cache_filename(self, cachefile):
        if os.path.exists(cachefile):
            newcachefile = self.ami_cache + "_" + str(self.count_tracker)
            self.count_tracker += 1
            return self.get_cache_filename(newcachefile)
        else:
            return cachefile
                
    def build_cache(self, erase_cache=True):
        self.cachefile = self.ami_cache
        if not erase_cache:
            self.cachefile = self.get_cache_filename(self.ami_cache)
            
        debug("Building cache: %s" % self.cachefile)
        self.ami.Cache(self.args["script"], self.cachefile)
        debug("Done building cache")

    def build_pcap(self, pcapfile):
        pcap_builder = PcapBuilder(self.pkg, self.cachefile)
        pcap_builder.build(pcapfile)

    def build_logs(self, log_folder, force, triggers):
        logs = LogsBuilder(self.pkg, self.cachefile, log_folder, force, triggers)
        return logs.build()

        
if __name__ == "__main__":

    try:
        parser = argparse.ArgumentParser(exit_on_error=True)
    except TypeError: # Some argparse versions do not have the exit_on_error option and throw a TypeError
        parser = argparse.ArgumentParser()
        
    parser.add_argument("script", type=str, help="The script to run")
    parser.add_argument("-c", "--erasecache", help="overwrite cache file (defaults to true)", action="store_false")
    parser.add_argument("-p", "--pcap", type=str, help="The pcap to build") 
    parser.add_argument("-l", "--log-folder", type=str, help="The log folder")
    parser.add_argument("-f", "--force", help="overwrite the log folder", action="store_true")
    parser.add_argument("-t", "--no-triggers", help="Do not run automatic triggers", action="store_false")
    parser.add_argument("-s", "--send-data", type=str, help="Send Data")
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
