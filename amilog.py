#!/usr/bin/env python3
import sys
from logwriter.TemplateBuilder import TemplateBuilder
from datetime import datetime
import pyami
import os
import shutil
import time

tb = TemplateBuilder()
logdir = ""
logs_fp = {}
current_time = time.time()
event_time = 0

def make_logsdir(dirname, force_mkdir=False):
    try:
        os.makedirs(dirname)
    except FileExistsError:
        if force_mkdir:
            shutil.rmtree(dirname)
            os.makedirs(dirname)
        else:
            print("Error: Cannot make directory %s: Directory already exists!" % dirname)
            return False
    except:
        print("Error: Cannot make directory %s" % dirname)
        return False

    return True

def action_handler(action):    
    if action.Exec() != "Controller":
        return
        # raise ValueError("Action exec must be Controller")

    action_time = event_time + action.GetSleepCursor()
    
    variables = action.Variables()
    field_actions = action.FieldActions()
    
    kvdict = {}
    for field, atype in field_actions.items():
        for at, aval in atype.items():
            if at == "set":
                for k, v in aval.items():
                    kvdict[field] = k

    try:
        event = tb.get_event(variables["$event_type"], variables["$event_template"], kvdict)
    except:
        print("Could not extract the right variables: $event_type and $event_template from action %s" % action.Name())
        return
    et = datetime.fromtimestamp(action_time)
    event = et.strftime(event)
    
    log_filename = os.path.join(logdir, variables["$event_type"].replace(".", "_") + ".log")
    try:
        logs_fp[variables["$event_type"]].write(event)
    except:
        logs_fp[variables["$event_type"]] = open(log_filename, "w")
        logs_fp[variables["$event_type"]].write(event)
    
if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Syntax: %s file.ami output_directory" % sys.argv[0])
        sys.exit(1)

    ami_file = sys.argv[1]
    logdir = sys.argv[2]

    make_logsdir(logdir, "-f" in sys.argv)
    
    ami = pyami.Ami()
    if ami.GetStartTime() > 0:
        event_time = ami.GetStartTime()
    else:
        event_time = current_time - ami.GetSleepCursor()
        
    ami.Parse(ami_file, action_handler)

