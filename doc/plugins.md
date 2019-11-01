
## MakeVariables

This Plugins creates variables from scractch based on the [pcraft Taxonomy][taxonomy].

### Example

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


## DNSConnection

Create a DNS Connection towards a domain that was either set in a previous plugin, or 
being set in the local script scope.

### Examples

#### 1: Connect to a domain set previously from the plugin chain

```
dnsconnect:
  _plugin: DNSConnection
  _next: done
```

#### 2: Connect to a domain set in the local script scope

```
dnsconnect:
  _plugin: DNSConnection
  domain: "www.example.com"
  _next: done
```


