import dns.resolver
import random

class PCraftPlugin(object):
    name = "GenerateNewDomain"
    
    def __init__(self, plugins_data):
        self.plugins_data = plugins_data

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
