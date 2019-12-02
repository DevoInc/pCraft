import struct
import socket
import sys

vowels = ['a','e','i','o','u','y','a','e','i','o']
consonants = ['p','b','c','z','m','f','d','s','t','r']

class PCraftFunction(object):
    name = "hostname"
    
    def help(self):
        helpstr="""
Generates a Hostname from an IP address. The name will be consistent.
"""
        return helpstr

    def __init__(self, plugins_data):
        self.plugins_data = plugins_data

    def run(self, scenariofile, arguments):
        ipaddr = str(arguments)
        print("Hostname run on %s" % ipaddr)
        
        try:
            iptoint=struct.unpack("!I", socket.inet_pton(socket.AF_INET, ipaddr))[0]
        except OSError: # illegal IP address string passed to inet_pton
            iptoint=struct.unpack("!IIII", socket.inet_pton(socket.AF_INET6, ipaddr))[0]
    
        ipstr = str(iptoint)
        outstr = ""
        pos = 0
        for i in ipstr:
            n = int(i)
            if pos % 2:
                outstr += vowels[n]
            else:
                outstr += consonants[n]

            pos += 1
        
        return outstr
