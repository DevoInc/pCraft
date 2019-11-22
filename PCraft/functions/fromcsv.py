import csv
import os
import random
import sys

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
    
    def __init__(self, plugins_data):
        self.plugins_data = plugins_data
        self.sequence = 0
        self.first = True
        self.all_csv_files = {}
        
    def _parse_arguments(self, scenariodir, arguments):
        args = [x.strip() for x in arguments.split(",")]
        if len(args) < 4:
            raise ValueError("Running fromcsv function with invalid arguments number!")

        readtype = args[0]
        try:
            readtype = int(readtype)
        except ValueError:
            if not readtype.startswith("firstmatch::"):
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

        try:
            csvfp = self.all_csv_files[csvfile]["fp"]
            reader = self.all_csv_files[csvfile]["reader"]
            readerlist = self.all_csv_files[csvfile]["readerlist"]
        except KeyError:
            self.all_csv_files[csvfile] = {}
            self.all_csv_files[csvfile]["fp"] = open(csvfile, "r")
            csvfp = self.all_csv_files[csvfile]["fp"]
            self.all_csv_files[csvfile]["reader"] = csv.DictReader(csvfp)
            reader = self.all_csv_files[csvfile]["reader"]
            self.all_csv_files[csvfile]["readerlist"] = list(reader)
            readerlist = self.all_csv_files[csvfile]["readerlist"]

        if isinstance(readtype, int):
            try:
                line = readerlist[readtype]
            except IndexError:
                print("Error: No such line %d from the csv %s" % (readtype, csvfile))
                sys.exit(1)
            return line[col]
            
        if readtype == "sequential":
            if self.sequence >= len(readerlist):
                self.sequence = 0

            line = readerlist[self.sequence]
            self.sequence += 1
            return line[col]

        if readtype == "random":
            number = random.randint(0, len(readerlist) - 1)
            line = readerlist[number]
            return line[col]            

        if readtype.startswith("firstmatch::"):
            firstmatch, field, value = readtype.split("::")
            for line in readerlist:
                if line[field] == value:
                    return line[col]
        
        return retval
    

if __name__ == "__main__":
    pf = PCraftFunction(None)
    scenariofile = "./"
    arguments = "sequential, targets.csv, header=true, col=target"
    out = pf.run(scenariofile, arguments)
    print("OUT: " + str(out))
    
