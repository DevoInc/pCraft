#!/usr/bin/python3
from ami.ami import Ami
from ami.functions import *

# def printmsg(msg):
#     print("From printmsg:" + str(msg.decode("utf-8")))

def actioncb(action):
    print("got an action!")
    print(ami_action_get_variables_len(action))
    print(ami_action_get_name(action))
    print(ami_action_get_exec(action))
    ami_action_debug(action)
    
a = Ami()
#a.set_message_cb(printmsg)
a.set_action_cb(actioncb)
a.parse_file("../bluekeep.ami")
ru = a.get_variable("$RU_attacker")
print("$RU_attacker = %s" % ru)
#a.debug()

