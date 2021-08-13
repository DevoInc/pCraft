import os
import difflib
import math

from logwriter.TemplateBuilder import TemplateBuilder

class LogContext(object):
    def __init__(self, outpath, templates_dir=None):
        self.outpath = outpath
        if not templates_dir:
            self.templates = TemplateBuilder(os.path.join(os.path.dirname(__file__), "templates"))
        else:
            self.templates = TemplateBuilder(templates_dir)

        self.client_public_ipv4 = "93.184.216.34"
        self.fp = None
        self.logfiles = {}
        
    def openlog(self, filename):
        if self.outpath:
            logfilename = os.path.join(self.outpath, filename)
            self.logfiles[logfilename] = open(logfilename, "w")
            return self.logfiles[logfilename]
        return None
    
    def closelog(self):
        if self.outpath:
            for filename, filepointer in self.logfiles.items():
                filepointer.close()
                size = os.stat(filename).st_size
                if size == 0:
                    os.unlink(filename)

    def do_validate_keys(self, event_type, event, kvdict):
        keys = self.retrieve_template_keys(event_type, kvdict["event_id"])
        for k, v in kvdict.items():
            if k not in keys:
                if k in ["event_id"]:
                    continue
                print("The key '%s' does not exists in the event_type '%s' template '%s'" % (k, event_type, event))
                could_be = difflib.get_close_matches(k, keys, cutoff=0.6)
                could_be = []
                sk = k.split("_")
                median = math.ceil(len(sk)/2) - 1
                for k2 in keys:
                    strpart = sk[median].upper()
                    if strpart in k2.upper():
                        could_be.append(k2)
                print("Could be:%s" % str(could_be))
            
    def retrieve_template_keys(self, event_type, event):
        return self.templates.get_template_keys(event_type, event)
    
    def retrieve_template(self, template, event, variables_dict):
        return self.templates.get_event(template, event, variables_dict)

    def retrieve_template_header(self, template, event):
        return self.templates.get_header(template, event)
    
    


        
