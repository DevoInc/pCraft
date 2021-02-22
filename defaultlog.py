#!/usr/bin/env python3
import sys
from datetime import datetime

from logwriter.TemplateBuilder import TemplateBuilder


if len(sys.argv) < 3:
    print("%s template event" % sys.argv[0])
    sys.exit(1)

tb = TemplateBuilder()

if tb.check_coverage(sys.argv[1], sys.argv[2]):
    event = tb.get_event(sys.argv[1], sys.argv[2], None)
    et = datetime.now()
    event = et.strftime(event)
    print(event)

    
