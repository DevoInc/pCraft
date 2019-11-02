## HTTPConnection
## HTTPPostConnection
## TcpRst
### Required Variables

| Variable | Description |
|:--------:|-------------|
| ip-src | Source IP |
| ip-dst | Destination IP |
| port-dst | Destination Port |

Send a exchange of SYN followed by RST-ACK between two hosts.

### Examples

#### 1: Send a SYN and receive a RST-ACK
```
rstack:
  _plugin: TcpRst
  ip-src: "192.168.0.42"
  ip-dst: "192.168.0.1"
  port-dst: 9876
  _next: done
```

## GenerateNewDomain
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

## PcapImport

Import a PCAP in the current flow.

### Examples

#### Import a pcap 'phishing.pcap', and replace a bunch of IP addresses

```
importphishing:
  _plugin: PcapImport
  filename: phishing.pcap
  replace: {"ip": {"192.168.0.42": "10.0.0.43",
                   "172.16.32.45": "10.0.0.53",
                   "192.168.0.12": "192.168.0.254",
                  }}
  _next: done
```

## DNSConnection
### Required Variables

| Variable | Description |
|:--------:|-------------|
| domain | A domain name |

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


## Ping
## SMTPReceive
