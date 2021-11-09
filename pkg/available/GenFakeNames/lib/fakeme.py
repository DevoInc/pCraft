#!/usr/bin/env python3
from text_unidecode import unidecode

from faker import Faker

class PcraftGenFakeNames(object):
    def __init__(self):
        self.faker = Faker(['it_IT', 'en_US', 'es_ES', 'fr_FR', 'de_DE', 'en_GB'])
        self.fakenames = {}
        self.seq = 0
        
    def get_fake_name(self, event):
        self.seq += 1
        retdict = {}
        
        first_name = self.faker.first_name().replace(" ","")
        last_name = self.faker.last_name().replace(" ","")
        name = "%s %s" % (first_name, last_name)
        
        retdict["$firstname"] = first_name
        retdict["$lastname"] = last_name
        retdict["$name"] = name

        first_last = first_name[0] + last_name
        first_dot_last = first_name + "." + last_name
        first_dot_last_dec = unidecode(first_dot_last).lower()
        retdict["$workstation"] = "WS" + unidecode(first_last).upper() + str(self.seq)
        
        retdict["$username"] = first_dot_last_dec        
        
        email = "%s@%s" % (first_dot_last_dec, event["variables"]["$domain"])
        retdict["$email"] = email

        return retdict
