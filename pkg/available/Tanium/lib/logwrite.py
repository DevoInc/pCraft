#!/usr/bin/env python3
import json
from datetime import datetime
import random
import uuid
import hashlib
import time

from pcraft.LibraryContext import *
from pcraft.TemplateBuilder import template_get_event

class TaniumFile():
    def __init__(self, fullpath="", md5=None, sha1=None, sha256=None, size=None):
        self.fullpath = fullpath
        out = hashlib.md5(fullpath.encode("utf-8"))
        self.md5 = out.hexdigest()
        self.sha1 = sha1
        self.sha256 = sha256
        self.size = size

class TaniumProcess():
    def __init__(self, parent, _file, args=None, cwd=None, name=None, pid=None, ppid=None, recorder_table_id = None, recorder_unique_id="", start_time=None, user=None):
        if not parent:
            self.parent = { "pid": None }
        else:
            self.parent = parent
        self.file = _file
        self.args = _file.fullpath.split("\\")[-1]
        self.cwd = cwd
        if name:
            self.name = name
        else:
            self.name = _file.fullpath
        self.pid = random.randint(100, 20000)
        if parent:
            self.ppid = parent.pid
        else: 
            self.ppid = random.randint(100, 1000)
        self.recorder_table_id = recorder_table_id
        self.recorder_unique_id = str(random.randint(100000000000, 900000000000))
        if  start_time:
            self.start_time = time.strftime("%Y-%m-%dT%H:%M:%S.000Z", start_time)
        else:
            self.start_time = "%Y-%m-%dT%H:%M:%S.000Z"
        self.user = "NT AUTHORITY\\SYSTEM"

    def jsonize(self):
        return json.dumps(self, default=lambda o: o.__dict__)

class PcraftLogWriter(LibraryContext):
    def __init__(self):
        super().__init__()
        
    def run(self, event, config, templates):
        frame_time = datetime.fromtimestamp(event["time"])

        try:
            flow = event["variables"]["$processflow"]
        except:
            flow = "calc.exe"

        allrefs = []
        for item in flow.split(";"):
            tf = TaniumFile(item)
            try:
                allrefs.append(TaniumProcess(allrefs[-1], tf))
            except IndexError:
                allrefs.append(TaniumProcess(None, tf))
                
        tanium_properties = allrefs[-1].jsonize()
        if tanium_properties:
            event["variables"]["$properties"] = tanium_properties
        else:
            event["variables"]["$properties"] = ""
        
        event = template_get_event(templates, "threats", event["variables"])
        event = frame_time.strftime(event)

        yield bytes(event, "utf8")
