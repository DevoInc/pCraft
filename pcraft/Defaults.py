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
                elif self.service == "http":
                    return "80"
                elif self.service == "https":
                    return "443"
                else:
                    return "80"
            if varname == "protocol":
                if self.service == "dns":
                    return "udp"
                if self.service == "http":
                    return "tcp"
                if self.service == "https":
                    return "tcp"
                return "tcp"
            
            if varname == "method":
                return "GET"
            if varname == "user-agent":
                return "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Pcraft/0.0.7"
            if varname == "uri":
                return "/"
            if varname == "resp-httpver":
                return "HTTP/1.1"
            if varname == "resp-code":
                return "200 OK"
            if varname == "resp-server":
                return "nginx"
            if varname == "resp-content-type":
                return "text/html"
            if varname == "resp-content":
                return "<html><body>Hello, you!</body></html>"

        return None
            
    def get_variable_or_defaults(self, varname, defaultval):
        try:
            return self.stdin_data["strmap"][varname]
        except:
            return defaultval
    
