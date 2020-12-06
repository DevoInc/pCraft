Writing a Scenario
==================

The Scenario file is written in AMI, a language that exists to just describe steps, and add convenient features such as
functions, variables, string replacement etc.

The Scenario file must start with:

```
ami_version 1
```

The Action Name is the entry point, it must call a generating plugin only (one that does not requires anything to start with).

Then, for each action call there are various options, at least:
- The Plugin name to call
- The next step

For example, to create a DNS Connection, one must write:
```
action dns {
       exec DNSConnection
}
```

The obvious question here is "But where IS my domain I do a DNS Connection to?", well, in this specific case, it has been
passed as a paramater coming from the previous plugin, as the "domain" variable. If not, the plugin won't work.

The list of all availables variables to be used across different plugins is available in the [pcraft Taxonomy][taxonomy].

## Variables

It is possible to set and use variables through the scenario file, a variable simply starts with the dollar sign '$'.

Since AMI provides many functions, we can assign it to our variable. Such as 'hostname_generator' to generate the
same string for the same IP address provided as an argument. We now want to make a DNS request on that hostname.
Which means we assign that function to the 'domain' variable.

```
ami_version 1

action dns {
       $host = string.lower(hostname_generator("192.168.0.15"))
       $domain = "${host}.com"
       exec DNSConnection
}
```

In this example we use two functions, the 'hostname_generator' and the 'string.lower', to make sure the string is
always lower case. Then we append '.com' to that generated hostname.

One of the things pcraft is useful for, is to import an existing pcap of real recorded traffic and replace the IP
source and destination, such as in the example below:
```
ami_version 1

$attacker = "192.168.0.42"
$domain_controller = "10.0.0.100"
$first_target = "10.52.60.69"

action importpcap {
  exec PcapImport
  $filename = "mypcap.pcap"
  field["ip"].replace("172.16.32.42" => $first_target,
                   "172.16.22.12" => $domain_controller,
                   "192.168.10.89" => $attacker)
}
```

[taxonomy]: taxonomy.md

