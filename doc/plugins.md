
MakeVariables
=============

This Plugins creates variables from scractch based on the [pcraft Taxonomy][taxonomy].

Example
-------

To replace the two variables "ip-dst" and "domain" that any previous plugins may have
built, the following can be written:

```
buildvars:
  _plugin: MakeVariables

  ip-dst: "1.1.1.1"
  domain: "www.example.com"

  _next: dnsconnect
```

[taxonomy]:taxonomy.md

