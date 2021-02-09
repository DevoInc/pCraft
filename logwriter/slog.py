#!/usr/bin/python3
from TemplateBuilder import TemplateBuilder
from datetime import datetime

tb = TemplateBuilder()

event = tb.get_event("microsoft.windows.security.logstash14", "5140", None)
print(event)
# frame_time = datetime.now()
# event = frame_time.strftime(event)
# print(event)

