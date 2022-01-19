#!/usr/bin/env python3
import sys
import os
import json
import pprint
from flatten_json import flatten, unflatten

def handle_one_event(event):
   eventname = event["event_simpleName"]
   
   filepath = os.path.join(event["event_simpleName"] + ".tmpl")
   defaultfilepath = os.path.join(event["event_simpleName"] + ".default")

   template = open(filepath, "w")
   default_csv = open(defaultfilepath, "w")

   flat_data = flatten(event)

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

def handle_one_file(filename):
   print("Handling " + filename)
   log = open(filename, "r")
   logbuffer = log.read()
   # The log data does not contain and array and has a last ',' with the last event written.
   newlogbuffer = "[" + logbuffer[:len(logbuffer)-2] + "]" 
   jsondata = json.loads(newlogbuffer)
   log.close()

   event = jsondata[0]
   handle_one_event(event)

if __name__ == "__main__":
   source_dir=sys.argv[1]
   for root, dirs, files in os.walk(source_dir):
      for name in files:
         if name.endswith(".json"):
            handle_one_file(os.path.join(root, name))
