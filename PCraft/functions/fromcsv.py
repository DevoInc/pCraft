class PCraftFunction(object):
    name = "fromcsv"

    def help(self):
        helpstr="""
Load data from a CSV file

### Examples

#### 1: Create a domain for a DNS request from the domain column in a sequential order

```
start: DNSConnection

DNSConnection:
  _plugin: DNSConnection
  domain: =@=fromcsv(sequential, "fromcsv.csv", header=true, col="domain")=@=
  _next: done
```
"""
        return helpstr
    
    def __init__(self):
        pass

    def run(self, scenariofile, arguments):
        print("scenariofile:%s" % str(scenariofile))
        print("arguments:%s" % str(arguments))

        return "foobar"
    
