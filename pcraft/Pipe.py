import io

import avro.schema

from avro.datafile import DataFileReader
from avro.io import DatumReader

SCHEMA = """{
    "type": "record",
    "name": "pcraftpipe",
    "fields": [
        {"name": "time",      "type": ["int", "null"], "default": "0"},
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
    # pipe = PcraftPipe()
    # rawdata = pipe.test_write()
    # print(pipe.read(rawdata))

    def __init__(self):
        self.schema = avro.schema.parse(SCHEMA)
        self.reader = avro.io.DatumReader(self.schema)
        self.writer = avro.io.DatumWriter(self.schema)

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
    
    def test_write(self):
        data = {"pcapout": [], "strmap": {"hello": "dolly"}}
        return self.write(data)
    
