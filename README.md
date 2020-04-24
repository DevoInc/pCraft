pCraft
======

pCraft is a PCAP Crafter, which creates a PCAP from a YAML scenario.

When generating data for testing, it is rather hard to do forthe following reasons:
- Lack of consistency between clients and servers
- Make sure no personal data leaks
- Consistency across different services.
- Keeping timing right
- etc.

This program helps solving this problem, one simply creates a script in YAML and the program outputs a PCAP.

Creating a Hello World script
-----------------------------

Create a file called "hello.yaml", we want to add the following content:

```
start: Generate_a_new_domain

Generate_a_new_domain:
  _plugin: GenerateNewDomain
  _next: DNSConnection

DNSConnection:
  _plugin: DNSConnection
  _next: loop-1

loop-1:
  count: 3
  newip: 1 # We get a new IP address for each loop
  _sleep: {"before-start":3,"interval":0.2,"once-finished":0.3}
  _next: done
  _start: DNSConnection # Where our loop starts
```

Now execute the pcraft program:
```
pcrafter hello.yaml hello.pcap
```

Let's read the result pcap using tshark:
```
$ tshark -r hello.pcap 
    1   0.000000 192.168.67.150 → 10.218.175.58 DNS 81 Standard query 0x0000 A masaryk-treasurer.com
    2   0.000552 10.218.175.58 → 192.168.67.150 DNS 118 Standard query response 0x0000 A masaryk-treasurer.com A 199.34.228.66
    3   0.001115 192.168.53.38 → 10.44.21.216 DNS 81 Standard query 0x0000 A masaryk-treasurer.com
    4   0.001529 10.44.21.216 → 192.168.53.38 DNS 118 Standard query response 0x0000 A masaryk-treasurer.com A 199.34.228.66
    5   0.002126 192.168.160.175 → 10.79.78.60  DNS 81 Standard query 0x0000 A masaryk-treasurer.com
    6   0.002531  10.79.78.60 → 192.168.160.175 DNS 118 Standard query response 0x0000 A masaryk-treasurer.com A 199.34.228.66
    7   0.003038 192.168.33.44 → 10.46.101.67 DNS 81 Standard query 0x0000 A masaryk-treasurer.com
    8   0.003439 10.46.101.67 → 192.168.33.44 DNS 118 Standard query response 0x0000 A masaryk-treasurer.com A 199.34.228.66
    9   0.003947 192.168.140.220 → 10.117.63.91 DNS 81 Standard query 0x0000 A masaryk-treasurer.com
   10   0.004350 10.117.63.91 → 192.168.140.220 DNS 118 Standard query response 0x0000 A masaryk-treasurer.com A 199.34.228.66
```

Writing a Scenario
------------------

Please look at the documentation on this topic to understand more about the engine: "[Writing a Scenario][scenario]".


Available Plugins
-----------------

The Plugins documentation is generated from themselves: [Plugins Documentation][plugins]


[scenario]: doc/scenario.md
[plugins]: doc/plugins.md
