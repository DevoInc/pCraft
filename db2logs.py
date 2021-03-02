#!/usr/bin/env python3

import sys

from LogWrite import LogWrite, LogRewrite
import pyami

import avro.schema
from avro.datafile import DataFileReader
from avro.io import DatumReader

from LogWrite import LogWrite, LogRewrite


SCHEMA = """{
    "type": "record",
    "name": "event",
    "fields": [
        {"name": "time", "type": "int", "default": "0"},
        {"name": "exec", "type": "string", "default": "Void"},
        {"name": "variables", "type": {"type": "map", "name": "var", "values": "string"}},
        {"name": "fset", "type": {"type": "map", "values": "string"}},
        {"name": "freplace", "type": {"type": "map", "values": "string"}}
        ]
}"""

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Syntax: %s ccraft.db output_directory [-f]" % sys.argv[0])
        sys.exit(1)

    ccraftfile = sys.argv[1]
    outdir = sys.argv[2]
        
    writer = LogWrite(None, outdir, "-f" in sys.argv)
    if writer.has_error:
        print("Error. Exiting.")
        sys.exit(1)
   
    reader = DataFileReader(open(ccraftfile, "rb"), DatumReader())
    for event in reader:
        # {'time': 1614504320, 'exec': 'Void', 'variables': {'$domain': 'haute-voltige.io', '$index': '1', '$var': '1234'}, 'fset': {'myfield': 'abcd'}, 'freplace': {}}
        kvdict = event["fset"]

        writer.loaded_plugins[event["exec"]].validate_keys(kvdict)

        writer.loaded_plugins[event["exec"]].run_ccraft(event, kvdict)
        
        print(str(event))
    reader.close()
