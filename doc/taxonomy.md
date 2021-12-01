pcraft Taxonomy
===============

pcraft needs a taxonomy to agree on how we name things amongst plugins. Because we do not want to invent our own, we
decided to use the MISP Taxonomy, in particular the standard Category as it can be found there: https://www.circl.lu/doc/misp/categories-and-types/

Here's a list of those that are currently supported:

| Name         | Description        | Example |
|:------------:|:------------------:|:-------:|
| domain       | A domain name      |         |
| ip-dst       | Destination IP     |         |
| ip-src       | Source IP          |         |
| port-dst     | Destination Port   |         |
| port-src     | Source Port        |         |
| filename     | A File Name        |         |
| resolver     | A DNS Resolver     |         |
| user-agent   | The User-Agent     |         |
| uri          | URI                |         |
| method       | HTTP Method        |         |
| portrange    | A port range       | 0-65535 |
| computername | client hostname    | mdr123  |
| wsdomain     | Workstation Domain |         |
| event_id     | Event ID           |         |
| protocol     | Protocol           | tcp     |


Special variables
-----------------

Special variables influence pcraft's behavior. Here's the list:

| Name                              | Description                 | Example        |
|:---------------------------------:|:---------------------------:|:--------------:|
| use-ssl                           | Indicates if we use SSL     | true           |
| pcap_import_only_replaced_packets | Tell pcap read to only keep |                |
|                                   | the packets being replaced  | true           |
| csv_fields                        | List of fields to write     |                |
|                                   | variables from for CSV out  | "$var1, $var2" |

