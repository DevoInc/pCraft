<p align="center">
<img src="doc/pcraft-logo.png" width=200/>
</p>

pCraft
======

pCraft is a PCAP Crafter, which creates a PCAP from an AMI scenario.

When generating data for testing, it is rather hard to do for the following reasons:
- Lack of consistency between clients and servers
- Make sure no personal data leaks
- Consistency across different services.
- Keeping timing right
- etc.

This program helps solving this problem, one simply creates a script in AMI and the program outputs a PCAP.

AMI?
----

AMI is a language that was designed to build highly readable scenarios to generate PCAPs. It is a C library with C++ bindings generating
the Python bindings used by pcraft.

You can find more documentation on AMI with the [Programming with AMI][ami] guide.

Creating a Hello World script
-----------------------------

Create a file called "hello.ami", we want to add the following content:

```
ami_version 1

action Generate_a_new_domain {
  exec GenerateNewDomain
}

sleep 3

repeat 3 as $index {
       action dns {
       	      exec DNSConnection
       }
       sleep 0.2
}

sleep 0.3
```

Now execute the pcraft program:
```
pcrafter hello.ami hello.pcap
```

Let's read the result pcap using tshark:
```
$ tshark -r hello.pcap 
    1   0.000000 192.168.127.116 ? 1.1.1.1      DNS 83 Standard query 0x0000 A alice-kaleidoscopes.com
    2   0.000000      1.1.1.1 ? 192.168.127.116 DNS 122 Standard query response 0x0000 A alice-kaleidoscopes.com A 10.81.21.0
    3   0.200000 192.168.34.135 ? 1.1.1.1      DNS 83 Standard query 0x0000 A alice-kaleidoscopes.com
    4   0.200000      1.1.1.1 ? 192.168.34.135 DNS 122 Standard query response 0x0000 A alice-kaleidoscopes.com A 10.171.215.203
    5   0.400000 192.168.234.128 ? 1.1.1.1      DNS 83 Standard query 0x0000 A alice-kaleidoscopes.com
    6   0.400000      1.1.1.1 ? 192.168.234.128 DNS 122 Standard query response 0x0000 A alice-kaleidoscopes.com A 10.0.8.113
```

Writing a Scenario
------------------

Please look at the documentation on this topic to understand more about the engine: "[Writing a Scenario][scenario]".


Available Plugins
-----------------

The Plugins documentation is generated from themselves: [Plugins Documentation][plugins]


Geolocation
-----------

We are using Geo Open for the IP<->Country mapping: [https://data.public.lu/fr/datasets/geo-open-ip-address-geolocation-per-country-in-mmdb-format/](https://data.public.lu/fr/datasets/geo-open-ip-address-geolocation-per-country-in-mmdb-format/)


List of Similar Projects
------------------------

[https://tshark.dev/packetcraft/scripting/scripted_gen/](https://tshark.dev/packetcraft/scripting/scripted_gen/)


[scenario]: doc/scenario.md
[plugins]: doc/plugins.md
[ami]: ami/doc/ami-guide.txt
