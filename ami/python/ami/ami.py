import ctypes
from .functions import *

def default_print_cb(msg):
    print(msg.decode("utf-8"))

class Action(object):
    pass

class Ami(object):
    """
    Ami Python Library 
    """
    def __init__(self):
        self.ctx = ami_new()
        #        self.set_message_cb(default_print_cb)
        

    def __del__(self):
        ami_close(self.ctx)

    def parse_file(self, amifile):
        infile = bytes(amifile.encode("utf-8"))
        ami_parse_file(self.ctx, infile)

    def debug(self):
        ami_debug(self.ctx)

    def set_message_cb(self, cb):
        ami_set_message_callback(self.ctx, message_handler(cb))

    def set_action_cb(self, cb):
        ami_set_action_callback(self.ctx, action_handler(cb))
        
    def get_variable(self, varname):
        var = bytes(varname.encode("utf-8"))
        value = str(ami_get_global_variable(self.ctx, var).decode("utf-8"))
        return value
    
