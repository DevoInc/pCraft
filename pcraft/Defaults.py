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
        self.built_variables = {}

    def get_built_variables(self):
        return self.built_variables
        
    def get_variable_or_none(self, varname):
        try:
            return self.stdin_data["strmap"][varname]
        except:
            return None

    def get_mand_variable(self, varname):
        return self.stdin_data["strmap"][varname]
        
    def get_variable(self, varname):
        got_default = False
        retval = ""
        try:
            try:
                return self.stdin_data["strmap"][varname]
            except:
                return self.built_variables[varname]
        except:
            if varname == "ip-src":
                got_default = True
                retval = get_random_client_ip()
            if varname == "ip-dst":
                got_default = True
                retval = get_random_server_ip()
            if varname == "port-src":
                got_default = True
                retval = get_random_ephemeral_port()
            if varname == "resolver":
                got_default = True
                retval = "1.1.1.1"
            if varname == "port-dst":
                got_default = True
                if self.service == "dns":
                    retval = "53"
                elif self.service == "http":
                    retval = "80"
                elif self.service == "https":
                    retval = "443"
                else:
                    retval = "80"
            if varname == "protocol":
                got_default = True
                retval = "tcp"
                if self.service == "dns":
                    retval = "udp"
            
            if varname == "method":
                got_default = True
                retval = "GET"
            if varname == "user-agent":
                got_default = True
                retval = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Pcraft/0.0.7"
            if varname == "uri":
                got_default = True
                retval = "/"
            if varname == "resp-httpver":
                got_default = True
                retval = "HTTP/1.1"
            if varname == "resp-code":
                got_default = True
                retval = "200 OK"
            if varname == "resp-server":
                got_default = True
                retval = "nginx"
            if varname == "resp-content-type":
                got_default = True
                retval = "text/html"
            if varname == "resp-content":
                got_default = True
                retval = "<html><body>Hello, you!</body></html>"

        if got_default:
            self.built_variables[varname] = retval
            return retval

        return None
            
    def get_variable_or_defaults(self, varname, defaultval):
        try:
            return self.stdin_data["strmap"][varname]
        except:
            return defaultval
    
