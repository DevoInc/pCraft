from parsuricata import parse_rules
from parsuricata.rules import Variable
from pcraft.PluginsContext import PluginsContext
import pprint

class PCraftPlugin(PluginsContext):
    name = "Suricata"

    def help(self):
        helpstr="""
Create pcap traffic based on a suricata rule
"""
        return helpstr

    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)

    def _replace_suricata_env_var(self, var):
        if not isinstance(var, Variable):
            return var

        v = self.getvar(var.identifier)
        if v:
            return v
        raise ValueError("Variable %s is not set" % var.identifier)
        
    def run(self, script=None):
        rules = parse_rules(self.getvar("rule"))
        rule = rules[0]


        rule.src = self._replace_suricata_env_var(rule.src)
        rule.dst = self._replace_suricata_env_var(rule.dst)
        rule.src_port = self._replace_suricata_env_var(rule.src_port)
        rule.dst_port = self._replace_suricata_env_var(rule.src_port)
        

        self.setvar("ip-src", rule.src)
        self.setvar("ip-dst", rule.dst)
        self.setvar("domain", rule.dst)
        if rule.src_port != "any":
            self.setvar("port-src", rule.src_port)
        if rule.dst_port != "any":
            self.setvar("port-dst", rule.dst_port)
        

        counter = 0
        for option in rule.options:
            if option.keyword == "content":
                if rule.options[counter-1].keyword == "http.uri":
                    self.setvar("uri", option.settings)
                    self.app.exec_plugin(self.app.loaded_plugins["HTTPConnection"], None)
            counter += 1


        return script["_next"], self.plugins_data

