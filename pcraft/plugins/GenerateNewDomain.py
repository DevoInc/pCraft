from pcraft.PluginsContext import PluginsContext
import dns.resolver
import random

class PCraftPlugin(PluginsContext):
    name = "GenerateNewDomain"

    def help(self):
        helpstr="""
Generate a valid non-existing domain name. It takes two words from the dictionary, seperates them with a dash and appends a '.com'.

### Examples

#### 1: Connect to a domain set previously from the plugin chain

```
generate:
  _plugin: GenerateNewDomain
  _next: dnsconnect
```
"""
        return helpstr
    
    def __init__(self, app, session, plugins_data):
        super().__init__(app, session, plugins_data)

    def run(self, script=None):
        new_domain_found = False

        fp = open("/usr/share/dict/words")
        words = fp.readlines()
        while not new_domain_found:        
            word1_idx = random.randint(1,len(words))
            word2_idx = random.randint(1,len(words))    
            word1 = words[word1_idx][:-1].lower()
            word2 = words[word2_idx][:-1].lower()

            domain = "%s-%s.com" % (word1, word2)
            domain = domain.replace("'","")
            try:
                answers = dns.resolver.query(domain, "A")
            except dns.resolver.NXDOMAIN:
                new_domain_found = True

        fp.close()
        
        self.plugins_data._set("domain", domain)
        return script["_next"], self.plugins_data
