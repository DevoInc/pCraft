#!/usr/bin/env python3
import sys
import os
import pprint
import subprocess
import envoy
import io
import base64
import time

import pyami

from pcraft.PackageManager import PackageManager
from pcraft.Pipe import PcraftPipe
from pcraft.utils import *
from pcraft import io as PcraftIO

PCAP_CONF = "pcap.conf"
LOG_CONF = "log.conf"
DEPENDENCIES_CONF = "dependencies.conf"

class PcraftExec(object):
    def __init__(self, pkg, amifile, pcapout=None):
        self.amifile = amifile
        self.pcapout = pcapout
        self.pkg = pkg
        self.current_time = time.time()
        
        self.ami = pyami.Ami()
        try:
            os.remove(pcapout)
        except FileNotFoundError:
            pass

        if self.pcapout:
            self.pcap_fp = open(self.pcapout, "wb")
            self.pcap_fp.write(PcraftIO.get_pcap_header())
        
        self.pipe = PcraftPipe()
        
        self.ami.Parse(amifile)
        self.start_time = int(self.ami.GetStartTime())
        if self.start_time <= 0:
            self.start_time = self.current_time - self.ami.GetSleepCursor()
        
        self.ami.Run(self.action_handler, None)

    def __del__(self):
        print("Closing pcap file")
        if self.pcapout:
            self.pcap_fp.close()
        
    def _get_process_to_execute(self, pkgname, action_exec):
        packages = self.pkg.get_packages()
        cmd = os.path.join(packages[pkgname]['dirpath'], "bin" ,packages[pkgname]['config'][PCAP_CONF][action_exec]['bin'])
        return cmd
        
    def action_handler(self, action, userdata):
        pkg_name = self.pkg.get_pkgname_from_action(action.Exec())
        strmap = {}
        for k, v in action.Variables().items():
            strmap[k[1:]] = v
            
        pipedata = {"time": self.start_time + action.GetSleepCursor(), "pcapout": [], "strmap": strmap}
        raw = self.pipe.write(pipedata)
        cmd = self._get_process_to_execute(pkg_name, action.Exec())

        process = subprocess.Popen(cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, env={"PYTHONPATH":"./"})
        process.stdin.write(raw)
        pstdout = process.communicate()[0]
        try:
            stdoutdec = self.pipe.read(pstdout)
        except IndexError:
            print("stdout write for package '%s' not serialized properly." % (pkg_name))
            return

        if self.pcapout:
            for pkt in stdoutdec["pcapout"]:
                self.pcap_fp.write(pkt)
                self.pcap_fp.flush()
        
        process.stdin.close()
        
        
if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Syntax: %s script.ami output.pcap" % sys.argv[0])
        sys.exit(1)

    pkg = PackageManager()
    pprint.pprint(pkg.get_packages())

    # print(">>>>>>")
    # print(pkg.get_pkgname_from_action("DNSConnection"))
    # print("<<<<")
    
    amifile = sys.argv[1]
    pcapout = sys.argv[2]

    pe = PcraftExec(pkg, amifile, pcapout)
    
    
    
