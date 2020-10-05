from ctypes import *
from .bind import *

ami_new = bind("ami_new", c_void_p)

ami_parse_file = bind("ami_parse_file", c_int, c_void_p, c_char_p)
ami_debug = bind("ami_debug", None, c_void_p)

ami_close = bind("ami_close", None, c_void_p)

message_handler = CFUNCTYPE(None, c_char_p)
ami_set_message_callback = bind("ami_set_message_callback", None, c_void_p, message_handler)

ami_get_global_variable = bind("ami_get_global_variable", c_char_p, c_void_p, c_char_p)

action_handler = CFUNCTYPE(None, c_void_p)
ami_set_action_callback = bind("ami_set_action_callback", None, c_void_p, action_handler)

ami_action_debug = bind("ami_action_debug", None, c_void_p)
ami_action_get_name = bind("ami_action_get_name", c_char_p, c_void_p)
ami_action_get_exec = bind("ami_action_get_exec", c_char_p, c_void_p)
