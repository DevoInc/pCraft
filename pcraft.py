#!/usr/bin/env python3
import sys
import os
import pprint
import subprocess
import io
import base64
import time
import shutil

import pyami
import pycapng

from pcraft.PackageManager import PackageManager
from pcraft.Pipe import PcraftPipe
from pcraft.utils import *
from pcraft import io as PcraftIO
from pcraft.Sessionizer import *

from scapy.all import *

PCAP_CONF = "pcap.conf"
LOG_CONF = "log.conf"
DEPENDENCIES_CONF = "dependencies.conf"

PCAPNG_CUSTOM_PEN = 58353

class PcraftExec(object):
    def __init__(self, pkg, amifile, pcapout=None, outdir=None, force_mkdir=False):
        self.has_error = False
        self.output_dir = outdir
        try:
            os.makedirs(self.output_dir)
        except FileExistsError:
            if force_mkdir:
                shutil.rmtree(self.output_dir)
                os.makedirs(self.output_dir)
            else:
                print("Error: Cannot make directory %s: Directory already exists!" % self.output_dir)
                self.has_error = True
                return
        except:
            print("Error: Cannot make directory %s" % self.output_dir)
            self.has_error = True
            return

        self.amifile = amifile
        self.pcapout = pcapout
        self.pkg = pkg
        self.current_time = time.time()
        self.session = Session()
        self.variables_built_by_plugins = {}

        self.pcapng = pycapng.PcapNg()
        self.ami = pyami.Ami()
        try:
            os.remove(pcapout)
        except FileNotFoundError:
            pass

        if self.pcapout:
            self.pcapng.OpenFile(self.pcapout, "w")
            # self.pcap_fp = open(self.pcapout, "wb")
            # self.pcap_fp.write(PcraftIO.get_pcap_header())
        
        self.pipe = PcraftPipe()
        
        self.ami.Parse(amifile)
        self.start_time = int(self.ami.GetStartTime())
        if self.start_time <= 0:
            self.start_time = self.current_time - self.ami.GetSleepCursor()

        print("Writing PcapNG file...")
        self.ami.Run(self.action_handler, None)
        self._close_pcap_file()
        print("Writing Logs...")
        self.logwrite()
        
    def __del__(self):
        pass
    
    def _close_pcap_file(self):
        if self.pcapout:
            self.pcapng.CloseFile()
        
    def _get_pcap_process_to_execute(self, pkgname, action_exec):
        packages = self.pkg.get_packages()
        cmd = os.path.join(packages[pkgname]['dirpath'], "bin" ,packages[pkgname]['config'][PCAP_CONF][action_exec]['bin'])
        return cmd
        
    def action_handler(self, action, userdata):
        pkg_name = self.pkg.get_pkgname_from_action(action.Exec())
        strmap = {}
        for k, v in self.variables_built_by_plugins.items():
            strmap[k] = v
        #
        # We do not want to carry the variable for source/dest port if created by plugins outsite of the plugin
        # However keeping the default source/dest ip is helpful!
        #
        try:
            del strmap["port-src"]
            del strmap["port-dst"]
        except:
            pass
            
        for k, v in action.Variables().items():
            strmap[k[1:]] = v

        # print(str(strmap))
            
        pipedata = {"time": self.start_time + action.GetSleepCursor(), "pcapout": [], "strmap": strmap}
        raw = self.pipe.write(pipedata)
        cmd = self._get_pcap_process_to_execute(pkg_name, action.Exec())

        process = subprocess.Popen(cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, env={"PYTHONPATH":"./"})
        process.stdin.write(raw)
        pstdout = process.communicate()[0]
        try:
            stdoutdec = self.pipe.read(pstdout)
        except IndexError:
            print("stdout write for package '%s' not serialized properly." % (pkg_name))
            return

        try:
            debugstr = stdoutdec["strmap"]["debug"] 
            print("DEBUG>>>")
            print(debugstr)
            print("<<<<<<")
        except:
            pass

        try:
            for k, v in stdoutdec["strmap"].items():
                # print("k:%s v:%s" % (k, v))
                if k in strmap:
                    pass
                else:
                    # print("%s is not in the strmap" % k)
                    self.variables_built_by_plugins[k] = v
        except:
            pass

        # FIXME: I first read pcapout, then dataout; This is no problem since
        # a plugin writing pcap != a plugin writing data (non-network stuff)
        # however if we want to do both AND we need to preserve time, we may
        # need another structure to keep buffers in time order.
        if self.pcapout:
            if stdoutdec["pcapout"]:
                for pkt in stdoutdec["pcapout"]:
	            # We rebuild the packet because packets building can come from anything.
	            # We just see a buffer. We need to have a proper session, and the correct time.
                    scapy_pkt = Ether(pkt[16:])
	            # scapy_pkt.show()
                    if scapy_pkt.haslayer(TCP): # Fix the session
                        self.session.append_to_session(scapy_pkt)
                        scapy_pkt = self.session.fix_seq_ack(scapy_pkt)
	
	            # We fix the time
	            # TODO: Fix time here
                    pkt = PcraftIO.raw_packet_from_scapy(scapy_pkt)
                    self.pcapng.WritePacket(pkt, "")

            if stdoutdec["dataout"]:
                for d in stdoutdec["dataout"]:
                    self.pcapng.WriteCustom(PCAPNG_CUSTOM_PEN, d, "")
                
        process.stdin.close()

    def logwrite(self):
        print("Writing logs from pcap file: %s to directory %s" % (self.pcapout, self.output_dir))
        self.pcapfp = self.pcapng.OpenFile(self.pcapout, "r")
        
if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Syntax: %s script.ami output.pcap outdir" % sys.argv[0])
        sys.exit(1)

    pkg = PackageManager()
    pprint.pprint(pkg.get_packages())

    # print(">>>>>>")
    # print(pkg.get_pkgname_from_action("DNSConnection"))
    # print("<<<<")
    
    amifile = sys.argv[1]
    pcapout = sys.argv[2]
    outdir  = sys.argv[3]

    pe = PcraftExec(pkg, amifile, pcapout, outdir, "-f" in sys.argv)
    
    
    
