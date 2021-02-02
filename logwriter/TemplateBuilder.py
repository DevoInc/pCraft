import os
import csv
import pystache
import datetime

class TemplateBuilder:
    def __init__(self, templates_dir=None):
        if not templates_dir:
            self.templates_dir = os.path.join(os.path.dirname(__file__),"templates/")
        else:
            self.templates_dir = templates_dir
            
        self.event_types = {}
        self.event_list = []
        
        for root, dirs, files in os.walk(self.templates_dir):
            if len(files) > 0:
                self.event_types[root] = files
                self.event_list.append(self.dir2event_type(root))
                
        # print(str(self.event_types))
    def dir2event_type(self, dirpath):
        subdir=dirpath[len(self.templates_dir):]
        return subdir.replace("/",".")        

    def get_file(self, event_type, template):
        dirpath = os.path.join(self.templates_dir, event_type.replace(".", "/"), template + ".tmpl")        
        return dirpath

    def get_default(self, event_type, template):
        dirpath = os.path.join(self.templates_dir, event_type.replace(".", "/"), "default.csv")        
        return dirpath

    def get_file_default(self, event_type, template):
        dirpath = os.path.join(self.templates_dir, event_type.replace(".", "/"), template + ".default")        
        return dirpath
    
    def print_event_types(self):
        for e in self.event_types:
            print(self.dir2event_type(e))
            
    def get_template_keys(self, event_type, template):
        tmpl_keys = []
        tmpl = self.get_file(event_type, template)
        fp = open(tmpl, "r")
        fp_buf = fp.read()
        parsed = pystache.parse(fp_buf)
        for k in parsed._parse_tree:
            if isinstance(k, (pystache.parser._SectionNode, pystache.parser._LiteralNode)):
                tmpl_keys.append(k.key)
        fp.close()
        return tmpl_keys

    def get_defaults(self, event_type, template):
        defaults = {}
        
        tmpl = self.get_default(event_type, template)
        fp = open(tmpl, "r")
        reader = csv.DictReader(fp)
        for row in reader:
            defaults[row["key"]] = row["default_value"]
        fp.close()
        tmpl = self.get_file_default(event_type, template)
        try:
            fp = open(tmpl, "r")
            reader = csv.DictReader(fp)
            for row in reader:
                defaults[row["key"]] = row["default_value"]
            fp.close()
        except:
            return defaults

        return defaults

    def check_coverage(self, event_type, template):
        defaults = self.get_defaults(event_type, template)
        keys = self.get_template_keys(event_type, template)
        for k in keys:
            try:
                e = defaults[k]
            except KeyError:
                print("The key '%s' does not exists in the template %s" % (k, self.get_file(event_type, template)))
                return False

        return True

    def get_event(self, event_type, template, valuesdict):
        values = self.get_defaults(event_type, template)
        if valuesdict:
            for k, v in valuesdict.items():
                values[k] = v
        fp = open(self.get_file(event_type, template), "r")
        fpbuf = fp.read()
        event = pystache.render(fpbuf, values)
        fp.close()
        return event
    
if __name__ == "__main__":
    tb = TemplateBuilder()
    myuser = {"user_name": "Yoplaboom"}
    if tb.check_coverage("bluecoat.proxysg", "main"):
        print(tb.get_event("bluecoat.proxysg", "main", myuser))

    # if tb.check_coverage("zscaler", "proxy"):
    #     print(tb.get_event("zscaler", "proxy", None))

    # if tb.check_coverage("isc.named", "query"):
    #     print(tb.get_event("isc.named", "query", None))

    # if tb.check_coverage("cisco.netflow", "v9"):
    #     print(tb.get_event("cisco.netflow", "v9", None))

    # if tb.check_coverage("microsoft.windows.sysmon", "1"):
    #     event_time = datetime.datetime.now()
    #     event = tb.get_event("microsoft.windows.sysmon", "1", None)
    #     event = event_time.strftime(event)
    #     print(event)

    if tb.check_coverage("microsoft.o365", "exchange"):
        event_time = datetime.datetime.now()
        event = tb.get_event("microsoft.o365", "exchange", None)
        event = event_time.strftime(event)
        print(event)
        
