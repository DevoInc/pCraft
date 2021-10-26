import os
import csv
import io
import pystache
import datetime
import pprint


def template_get_defaults(template, event):
    event_tmpl = event + ".tmpl"
    event_default = event + ".default"
    defaults = {}

    reader = csv.DictReader(io.StringIO(template["files"]["default.csv"]))
    for row in reader:
        defaults[row["key"]] = row["default_value"]

    try:
        reader = csv.DictReader(io.StringIO(template["files"][event_default]))
        for row in reader:
            defaults[row["key"]] = row["default_value"]
    except:
        pass
    
    return defaults

def template_get_event(template, event, valuesdict):
    event_tmpl = event + ".tmpl"

    values = template_get_defaults(template, event)
    if valuesdict:
        for k, v in valuesdict.items():
            values[k[1:]] = v

    event = pystache.render(template["files"][event_tmpl], values)

    return event

class TemplateBuilder:
    def __init__(self, templates_dir):
        self.templates_dir = templates_dir
            
        self.event_types = {}
        self.event_list = []

        self.templates = []
        template_files = {}
        for root, dirs, files in os.walk(self.templates_dir):
            if len(files) > 0:
                template_path = root[len(templates_dir)+1:].replace("/",".")
                for f in files:
                    buf = open(os.path.join(root, f), "r")
                    template_files[f] = buf.read()
                        
                    buf.close()
                self.templates.append({"eventtype": template_path, "files": template_files})

    def get_templates(self):
        return self.templates
    
    def dir2event_type(self, dirpath):
        subdir=dirpath[len(self.templates_dir):]
        return subdir.replace("/",".")        

    def get_file(self, event_type, template):
        dirpath = os.path.join(self.templates_dir, event_type.replace(".", "/"), template + ".tmpl")        
        return dirpath

    def get_header_file(self, event_type, template):
        dirpath = os.path.join(self.templates_dir, event_type.replace(".", "/"), template + ".header")        
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

    def get_header(self, event_type, template):
        try:
            fp = open(self.get_header_file(event_type, template), "r")
            fpbuf = fp.read()
            fp.close()
            return fpbuf
        except:
            return None
    
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
    
