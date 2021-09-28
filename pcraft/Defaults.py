import random
from . import utils

def get_random_client_ip():
    return utils.getRandomIP("192.168.0.0/16", ipfail="172.16.42.42").get()

def get_random_server_ip():
    return utils.getRandomIP("10.0.0.0/8", ipfail="10.1.2.42").get()

def get_random_ephemeral_port():
    return str(random.randint(4096, 65534))

class PcraftDefaults(object):
    def __init__(self, stdin_data, service=None):
        self.stdin_data = stdin_data
        self.service = service
        
    def get_variable_or_none(self, varname):
        try:
            return self.stdin_data["strmap"][varname]
        except:
            return None

    def get_mand_variable(self, varname):
        return self.stdin_data["strmap"][varname]
        
    def get_variable(self, varname):
        try:
            return self.stdin_data["strmap"][varname]
        except:
            if varname == "ip-src":
                return get_random_client_ip()
            if varname == "ip-dst":
                return get_random_server_ip()
            if varname == "port-src":
                return get_random_ephemeral_port()
            if varname == "resolver":
                return "1.1.1.1"
            if varname == "port-dst":
                if self.service == "dns":
                    return "53"
                else:
                    return "80"
            
    def get_variable_or_defaults(self, varname, defaultval):
        try:
            return self.stdin_data["strmap"][varname]
        except:
            return defaultval
    
