#!/usr/bin/env python3
import sys
from LogWrite import LogWrite, LogRewrite
import pyami

def pcap2logs(pcap, logsdir, config_ami):
    writer = LogWrite(pcap, logsdir, "-f" in sys.argv)
    if writer.has_error:
        print("Error. Exiting.")
        sys.exit(1)

    writer.process()

    print("Writer process done, now rewriting from config")
    if config_ami:
        del(writer)
        rewriter = LogRewrite(pcap, logsdir, config_ami)
        rewriter.process()

def logs2logs(pcap, logsdir, config_ami):
    if config_ami:
        rewriter = LogRewrite(pcap, logsdir, config_ami)
        rewriter.process()
    else:
        print("Error, no configuration given to rewrite. Stopping.")
        
if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Syntax: %s file.pcap output_directory [config.ami] [-f]" % sys.argv[0])
        sys.exit(1)

    pcapfile = sys.argv[1]
    outdir = sys.argv[2]
    config_ami = None
    if len(sys.argv) > 3:
        if sys.argv[3] != "-f":
            config_ami = sys.argv[3]

    if "-s" in sys.argv:
        logs2logs(pcapfile, outdir, config_ami)
    else:            
        pcap2logs(pcapfile, outdir, config_ami)

