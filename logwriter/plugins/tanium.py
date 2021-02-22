import random
from datetime import datetime
import uuid
import hashlib
import time
import json

from logwriter.LogContext import LogContext

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
        self.name = name
        self.pid = random.randint(100, 20000)
        self.ppid = random.randint(100, 20000)
        self.recorder_table_id = recorder_table_id
        self.recorder_unique_id = random.randint(100000, 900000)
        self.start_time = time.strftime("%Y-%m-%dT%H:%M:%S.000Z", time.localtime())
        self.user = "NT AUTHORITY\\SYSTEM"

    def jsonize(self):
        return json.dumps(self, default=lambda o: o.__dict__)

class LogPlugin(LogContext):
    name = "tanium"
    active_layer = "no-active-layer"

    def __init__(self, outpath):
        super().__init__(outpath)
        self.log_fp = self.openlog("tanium.log")

    def __del__(self):
        self.closelog()

    def validate_keys(self, kvdict):
        pass
        
    def template_to_log(self, packet, kvdict):
        frame_time = datetime.fromtimestamp(int(float(packet.sniff_timestamp)))

        event = self.retrieve_template("tanium", kvdict["event_id"], kvdict)
        event = frame_time.strftime(event)

        return event

    def run(self, cap, packet, pktid, kvdict):
        flow = kvdict["processflow"]
        allrefs = []
        for item in flow.split(";"):
            tf = TaniumFile(item)
            try:
                allrefs.append(TaniumProcess(allrefs[-1], tf))
            except IndexError:
                allrefs.append(TaniumProcess(None, tf))
                
        tanium_properties = allrefs[-1].jsonize()

        kvdict["properties"] = tanium_properties
        
        self.log_fp.write(self.template_to_log(packet, kvdict))
