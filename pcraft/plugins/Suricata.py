from parsuricata import parse_rules
from pcraft.PluginsContext import PluginsContext

class PCraftPlugin(PluginsContext):
    name = "Suricata"

    def help(self):
        helpstr="""
Create pcap traffic based on a suricata rule
"""
        return helpstr

    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)

        self.homenet_ip = "192.168.0.42"
        self.not_homenet_ip = "172.16.42.6"
        
    def run(self, script=None):
        rules = parse_rules(self.getvar("rule"))
        rule = rules[0]

        self.setvar("ip-src", self.homenet_ip)
        self.setvar("ip-dst", self.not_homenet_ip)
        self.setvar("domain", self.not_homenet_ip)
        if rule.src == "$HOME_NET":
            self.setvar("ip-src", self.homenet_ip)
        if rule.dst == "$HOME_NET":
            self.setvar("ip-dst", self.homenet_ip)

        if rule.src == "!$HOME_NET":
            self.setvar("ip-src", self.not_homenet_ip)
        if rule.dst == "!$HOME_NET":
            self.setvar("ip-dst", self.not_homenet_ip)

        if rule.src_port != "any":
            self.setvar("port-src", rule.src_port)

        if rule.dst_port != "any":
            self.setvar("port-dst", rule.dst_port)
        
#        print(rule.protocol)
        counter = 0
        for option in rule.options:
            if option.keyword == "content":
                if rule.options[counter-1].keyword == "http.uri":
                    self.setvar("uri", option.settings)
                    self.app.exec_plugin(self.app.loaded_plugins["HTTPConnection"], None)
            counter += 1


        return script["_next"], self.plugins_data

