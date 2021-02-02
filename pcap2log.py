#!/usr/bin/env python3
import sys
from LogWrite import LogWrite

def pcap2logs(pcap, logsdir):
    writer = LogWrite(pcap, logsdir, "-f" in sys.argv)
    if writer.has_error:
        print("Error. Exiting.")
        sys.exit(1)
        
    writer.process()    


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Syntax: %s file.pcap output_directory" % sys.argv[0])
        sys.exit(1)

    pcapfile = sys.argv[1]
    outdir = sys.argv[2]
        
    pcap2logs(pcapfile, outdir)

