import io
import sys
import json

import avro.schema

from avro.datafile import DataFileReader
from avro.io import DatumReader

SCHEMA = """{
    "type": "record",
    "name": "pcraftpipe",
    "fields": [
        {"name": "time",      "type": ["float", "null"], "default": "0"},
        {"name": "is_pcapng", "type": ["boolean", "null"], "default": false},
        {"name": "strmap",    "type": [{"type": "map", "values": "string"}, "null"]},
        {"name": "intmap",    "type": [{"type": "map", "values": "int"}, "null"]},
        {"name": "bytesmap",  "type": [{"type": "map", "values": "bytes"}, "null"]},
        {"name": "longmap",   "type": [{"type": "map", "values": "long"}, "null"]},
        {"name": "floatmap",  "type": [{"type": "map", "values": "float"}, "null"]},
        {"name": "doublemap", "type": [{"type": "map", "values": "double"}, "null"]},
        {"name": "pcapout",   "type": [{"type": "array", "items": "bytes"}, "null"]}
        ]
}"""



class PcraftPipe(object):
    def __init__(self):
        self.schema = avro.schema.parse(SCHEMA)
        self.reader = avro.io.DatumReader(self.schema)
        self.writer = avro.io.DatumWriter(self.schema)

    def decode_stdin(self):
        data = sys.stdin.buffer.read()
        raw_data = self.read(data)
        return raw_data
        
    def read(self, binbuf):
        bytes_reader = io.BytesIO(binbuf)
        decoder = avro.io.BinaryDecoder(bytes_reader)
        return self.reader.read(decoder)    
    
    def write(self, data):
        bytes_writer = io.BytesIO()
        encoder = avro.io.BinaryEncoder(bytes_writer)
        self.writer.write(data, encoder)
        raw_bytes = bytes_writer.getvalue()
        return raw_bytes

    def encode_stdout(self, data):
        sys.stdout.buffer.write(self.write(data))
    
    def test_write(self):
        data = {"pcapout": [], "strmap": {"hello": "dolly"}}
        return self.write(data)
    
