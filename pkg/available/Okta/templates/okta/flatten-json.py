#!/usr/bin/env python3
import sys
import json
import pprint
from flatten_json import flatten, unflatten

if len(sys.argv) < 3:
    print("Syntax: %s json-input defaultcsv-file template-file" % sys.argv[0])
    sys.exit(1)

template = open(sys.argv[3], "w")

default_csv = open(sys.argv[2], "w")

jsonfp = open(sys.argv[1], "r")
for event in jsonfp.readlines():
    jsondata = json.loads(event)
    break


flat_data = flatten(jsondata)

default_csv.write("key,default_value\n")
newdict = {}
for k, v in flat_data.items():
    v = str(v)
    if k == "message":
        v = v.split(":")[0]
    default_csv.write(k)
    default_csv.write(",")    
    value = json.dumps(v)
    value = value.replace('\\"', '') # FIXME, otherwise produces invalid json
    default_csv.write(value)
    default_csv.write('\n')
    newdict[k] = "{{{%s}}}" % k

tmpl = unflatten(newdict)
template.write(json.dumps(tmpl) + "\n")

jsonfp.close()

default_csv.close()
template.close()

