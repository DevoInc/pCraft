#!/usr/bin/env python3
#
# A State helps to know which is the value
# for a given required variable (usually network)
# at a given flow. 
#
class VariablesState(object):
    def __init__(self):
        self.states = {}
        self.context = None
        self.event = None
        
    def __getattr__(self, attr):
        if attr.startswith("set_") or attr.startswith("get_"):
            pass
        else:
            try:
                return self.states[attr]
            except:
                self.states[attr] = "val"

    def set_context(self, context):
        self.context = context
        
    def attach_event(self, event):
        self.event = event
