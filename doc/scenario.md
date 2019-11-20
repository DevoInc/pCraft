Writing a Scenario
==================

The Scenario file is a YAML file, first and foremost, it must comply with the YAML Language.

The Scenario file must start with:

```
start: <ACTION_NAME>
```

The Action Name is the entry point, it must call a generating plugin only (one that does not requires anything to start with).

Then, for each action call there are various options, at least:
- The Plugin name to call
- The next step

For example, to create a DNS Connection, one must write:
```
Create_a_new_connection:
  _plugin: DNSConnection
  _next: done
```

Each option starting with the _ character means it is part of the engine. Anything which does not start with _ means it is part
of the plugin.

The obvious question here is "But where IS my domain I do a DNS Connection to?", well, in this specific case, it has been
passed as a paramater coming from the previous plugin, as the "domain" variable.

The list of all availables variables to be used across different plugins is available in the [pcraft Taxonomy][taxonomy].

## Variables

It is possible to set and use variables through the scenario file, a variable simply starts with the dollar sign '$'.

For example, the plugin 'HostnameFromIP' will generate the same hostname from a given IP address. We now want to make a
DNS request on that hostname. Which means we extract the generated 'hostname' variable to set the 'domain' one.

```
start: Generate_a_hostname

Generate_a_hostname:
  _plugin: HostnameFromIP
  ip: 127.0.0.1
  _next: DNSConnection

DNSConnection:
  _plugin: DNSConnection
  domain: $hostname
  _next: done
```

Also, it is possible to use the 'MakeVariables' plugin in order to set all the variables you would later need, such
as in this example:
```
start: setVariables

setVariables:
  _plugin: MakeVariables
  attacker: "192.168.0.42"
  domain_controller: "10.0.0.100"
  first_target: "10.52.60.69"
  _next: importpcap

importpcap:
  _plugin: PcapImport
  filename: mypcap.pcap
  replace: {"ip": {"172.16.32.42": $first_target,
                   "172.16.22.12": $domain_controller,
                   "192.168.10.89": $attacker,
                  }}
  _next: done
```

On the way, you may want to print the variables for debugging purposes, this is the role of the 'PrintVariables' plugin,
which can be called like this:
```
printvars:
  _plugin: PrintVariables
  _next: done
```

## Functions

In order to set a variable or fill a value, it is possible to call a function. For now, there only exists the 'fromcsv' function
which takes values from a CSV file either sequentially or randomly.

A function can be used just like a variable, except it must be surrounded by the '=@=' characters, to avoid collision with generated
data.

For example, to set a domain from the domain field in the 'domainslist.csv' file, one can do like this:
```
start: DNSConnection

DNSConnection:
  _plugin: DNSConnection
  domain: =@=fromcsv(sequential, domainslist.csv, header=true, col=domain)=@=
  _next: loop-1

loop-1:
  count: 5
  _next: done
  _start: DNSConnection
```

Which will call the fromcsv function, tell it to follow that file in sequential order (and restart once the bottom is reached) and use the domain column.

[taxonomy]: taxonomy.md

