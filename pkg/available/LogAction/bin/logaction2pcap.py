#!/usr/bin/env python3
from pcraft import io as PcraftIO
import json

data = PcraftIO.get_stdin()
dataout = []

d = json.dumps(data["strmap"])
dataout.append(bytes(d, "utf8"))

outdata = {"dataout": dataout}
PcraftIO.put_stdout(outdata)
