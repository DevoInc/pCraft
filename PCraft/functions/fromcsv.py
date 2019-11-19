import csv
import os
import random

class PCraftFunction(object):
    name = "fromcsv"

    def help(self):
        helpstr="""
Load data from a CSV file. Warning, for now, the header MUST be set.

### Examples

#### 1: Create a domain for a DNS request from the domain column in a sequential order

```
start: DNSConnection

DNSConnection:
  _plugin: DNSConnection
  domain: =@=fromcsv(sequential, fromcsv.csv, header=true, col=domain)=@=
  _next: done
```
"""
        return helpstr
    
    def __init__(self):
        self.sequence = 0
        self.first = True
        self.csvfp = None
        self.reader = None
        self.readerlist = None
        
    def _parse_arguments(self, scenariodir, arguments):
        args = [x.strip() for x in arguments.split(",")]
        if len(args) < 4:
            raise ValueError("Running fromcsv function with invalid arguments number!")

        readtype = args[0]
        typevalues = ["sequential","random"]
        if readtype.lower() not in typevalues:
            raise ValueError("fromcsv function argument not in accepted values: [%s]" % str(typevalues))
        csvfile = os.path.join(scenariodir, args[1])
        header = [ True if args[2].split("=")[1].strip().lower() == "true" else False ]
        col = args[3].split("=")[1].strip()

        return readtype, csvfile, header, col
        
    def run(self, scenariofile, arguments):
        retval = "ErrorReadingFromCSV"
        
        scenariodir=os.path.dirname(scenariofile)

        readtype, csvfile, header, col = self._parse_arguments(scenariodir, arguments)

        if self.first:
            self.csvfp = open(csvfile, "r")
            self.reader = csv.DictReader(self.csvfp)
            self.readerlist = list(self.reader)
            self.first = False
            
        if readtype == "sequential":
            if self.sequence >= len(self.readerlist):
                self.sequence = 0

            line = self.readerlist[self.sequence]
            self.sequence += 1
            return line[col]

        if readtype == "random":
            number = random.randint(0, len(self.readerlist) - 1)
            line = self.readerlist[number]
            return line[col]            
        
        return retval
    
