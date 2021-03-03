#!/usr/bin/env python3

import sys
from avro.datafile import DataFileReader
from avro.io import DatumReader

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Syntax: %s ccraft.db" % sys.argv[0])
        sys.exit(1)

    ccraftfile = sys.argv[1]
    reader = DataFileReader(open(ccraftfile, "rb"), DatumReader())
    for event in reader:
        print(event)

        
