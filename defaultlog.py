#!/usr/bin/env python3
import sys
from datetime import datetime

from logwriter.TemplateBuilder import TemplateBuilder


if len(sys.argv) < 3:
    print("%s template event_type" % sys.argv[0])
    sys.exit(1)

template = sys.argv[1]
event_type = sys.argv[2]
    
tb = TemplateBuilder()

if "-k" in sys.argv:
    print("Template keys are: %s" % str(tb.get_template_keys(template, event_type)))

if tb.check_coverage(template, event_type):
    event = tb.get_event(template, event_type, None)
    et = datetime.now()
    event = et.strftime(event)
    print(event)

    
