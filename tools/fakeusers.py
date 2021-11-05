#!/usr/bin/env python3
from text_unidecode import unidecode
from faker import Faker
import csv
import sys

seq = 1

fp = sys.stdout # open("file.csv", "w")
fields = ["name", "first_name", "last_name", "workstation", "username"]

writer = csv.DictWriter(fp, fieldnames=fields)
writer.writeheader()

fak = Faker(['it_IT', 'en_US', 'es_ES', 'fr_FR', 'de_DE', 'en_GB'])

i = 0
while i < 10000:
    csvdict = {}
    csvdict["first_name"] = fak.first_name().replace(" ","")
    csvdict["last_name"] = fak.last_name().replace(" ","")
    csvdict["name"] = "%s %s" % (csvdict["first_name"], csvdict["last_name"])

    first_last = csvdict["first_name"][0] + csvdict["last_name"]
    first_dot_last = csvdict["first_name"] + "." + csvdict["last_name"]
    first_dot_last_dec = unidecode(first_dot_last).lower()

    csvdict["workstation"] = "WS" + unidecode(first_last).upper() + str(seq)
    csvdict["username"] = first_dot_last_dec

    writer.writerow(csvdict)

    seq += 1
    i += 1
    
fp.close()
