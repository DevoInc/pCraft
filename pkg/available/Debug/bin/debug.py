#!/usr/bin/env python3
import os

from IPy import IP as IP_y

from pcraft import io as PcraftIO
from pcraft.Defaults import PcraftDefaults

data = PcraftIO.get_stdin()

debugstr = str(data)

outdata = {"debug": debugstr}
PcraftIO.put_stdout(outdata)

