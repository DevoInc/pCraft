#!/usr/bin/env python3
import sys
import os
import json
import pprint
import re

kvmsg = re.compile("([a-zA-Z]+): (.*)")

def message_handler(message):
   retmsg = ""
   seq = 0
   for m in message:      
      seq += 1
      if m == "\n":
         # print("Got it at %d" % seq)
         break
   message_type = message[0:seq]
   retmsg += message_type
   # print("Message type:[%s]" % message_type)
   message_keyvals = message[seq:]
   kv = message_keyvals.split("\r\n")
   for item in kv:
      # print(item)
      res = kvmsg.match(item)
      if res:
#         print(res.group(1))
         retmsg += "%s: {{{%s}}}\r\n" % (res.group(1), res.group(1))
   # print(message[seq:])
   return retmsg[:-2] # We remove the trailing \r\n


def handle_one_ev(event):
   # print(event["SourceName"])
   # print(event["EventID"])

   try:
      os.makedirs(event["SourceName"])
   except FileExistsError:
      pass
   
   tmplfilepath = os.path.join(event["SourceName"], str(event["EventID"]) + ".tmpl")
   defaultfilepath = os.path.join(event["SourceName"], str(event["EventID"]) + ".default")
   defaultcsvpath = os.path.join(event["SourceName"], "default.csv")
   
   if os.path.exists(tmplfilepath):
      print("%s exists. Skip." % tmplfilepath)
      return

   if not os.path.exists(tmplfilepath):
      csvfp = open(defaultcsvpath, "w")
      csvfp.write("key,default_value\n")
      csvfp.close()

   tmplfp = open(tmplfilepath, "w")
   defaultfp = open(defaultfilepath, "w")

   defaultfp.write("key,default_value\n")
   
   newevent = {}
   for k,v in event.items():
      if isinstance(v, str):
         v = v.replace("\\","\\\\")
         v = v.replace("\"","\\\"")
      if k == "Message":
         newevent[k] = message_handler(v)
      elif k == "SourceName":
         newevent[k] = v
      elif k == "EventID":
         newevent[k] = v
      elif k == "EventTime":
         newevent[k] = "%Y-%m-%d %H:%M:%S"
      elif k == "EventReceivedTime":
         newevent[k] = "%Y-%m-%d %H:%M:%S"
      elif k == "UtcTime":
         newevent[k] = "%Y-%m-%d %H:%M:%S.000"
      else:
         defaultfp.write("%s,\"%s\"\n" % (k, v))
         newevent[k] = "{{{%s}}}" % k

   tmplfp.write(json.dumps(newevent) + "\n")

   tmplfp.close()
   defaultfp.close()
   
   return newevent

def handle_one_file(filename):
   print("Handling " + filename)
   log = open(filename, "r")
   logbuffer = log.readlines()
   for line in logbuffer:
      event = json.loads(line)
      new_event = handle_one_ev(event)
   log.close()

if __name__ == "__main__":
   source_dir=sys.argv[1]
   handle_one_file(source_dir)
