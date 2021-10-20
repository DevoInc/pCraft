#!/usr/bin/env python3
from pcraft import io as PcraftIO
from pcraft.TemplateBuilder import template_get_event
import json
import pprint

data = PcraftIO.get_stdin()
# dataout = []

template = data["templates"][0]
valuesdict = data["strmap"]
event = template_get_event(template, valuesdict["event_id"], valuesdict)

print(str(event),end="")


# outdata = {"dataout": dataout}
# PcraftIO.put_stdout(outdata)
