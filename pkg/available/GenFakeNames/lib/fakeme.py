#!/usr/bin/env python3
from faker import Faker

class PcraftGenFakeNames(object):
    def __init__(self):
        self.faker = Faker(['it_IT', 'en_US', 'es_ES', 'fr_FR', 'de_DE', 'en_GB'])
        self.fakenames = {}

    def get_fake_name(self, event):
        retdict = {}
        no_infinite_loop = 0
        # We have see some duplicate names. We try 10 times to avoid spending too much time
        while no_infinite_loop < 10:
            name = self.faker.name()
            nametable = name.split(" ") # Sometimes there are spaces in last names, we cut short and only grab the first one
            first_last = "%s %s" % (nametable[0], nametable[1])        
            try:
                a = self.fakenames[first_last]
                break
            except KeyError: # Same player plays again!
              pass
            
            no_infinite_loop += 1

        retdict["$firstname"] = nametable[0]
        retdict["$lastname"] = nametable[1]
        retdict["$name"] = name

        email = "%s.%s@%s" % (nametable[0], nametable[1], event["variables"]["$domain"])
        retdict["$email"] = email

        return retdict
