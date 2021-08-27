#!/usr/bin/env python3
import sys
import os
import json
import pprint
from flatten_json import flatten, unflatten


source_file=sys.argv[1]

cloudtrail_log = open(source_file, "r")

jsondata = json.loads(cloudtrail_log.read())

for e in jsondata["Records"]:
    # print(str(e))
    # print(e["eventType"])
    # print(e["eventName"])
    try:
        os.mkdir(e["eventType"])
    except:
        pass

    filepath = os.path.join(e["eventType"], e["eventName"] + ".tmpl")
    defaultfilepath = os.path.join(e["eventType"], e["eventName"] + ".default")
    if not os.path.exists(filepath):
        print("The file %s does not exists. Building it!" % (filepath))
        template = open(filepath, "w")
        default_csv = open(defaultfilepath, "w")
        
        flat_data = flatten(e)

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

        default_csv.close()
        template.close()
        
cloudtrail_log.close()
