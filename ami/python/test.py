#!/usr/bin/python3
from ami.ami import Ami

def printmsg(msg):
    print("From printmsg:" + str(msg.decode("utf-8")))

a = Ami()
a.set_message_cb(printmsg)
a.parse_file("../bluekeep.ami")
ru = a.get_variable("$RU_attacker")
print("$RU_attacker = %s" % ru)
#a.debug()

