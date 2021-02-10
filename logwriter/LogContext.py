import os
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
        self.logfile = None
        
    def openlog(self, filename):
        self.logfile = os.path.join(self.outpath, filename)
        self.fp = open(self.logfile, "w")
        return self.fp
    
    def closelog(self):
        self.fp.close()
        size = os.stat(self.logfile).st_size
        if size == 0:
            os.unlink(self.logfile)
        
        
    def retrieve_template(self, template, event, variables_dict):
        return self.templates.get_event(template, event, variables_dict)

    def retrieve_template_header(self, template, event):
        return self.templates.get_header(template, event)
    
    


        
