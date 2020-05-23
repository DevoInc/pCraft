pcraft Taxonomy
===============

pcraft needs a taxonomy to agree on how we name things amongst plugins. Because we do not want to invent our own, we
decided to use the MISP Taxonomy, in particular the standard Category as it can be found there: https://www.circl.lu/doc/misp/categories-and-types/

Here's a list of those that are currently supported:

| Name       | Description      |
|:----------:|------------------|
| domain     | A domain name    |
| ip-dst     | Destination IP   |
| ip-src     | Source IP        |
| port-dst   | Destination Port |
| port-src   | Source Port      |
| filename   | A File Name      |
| resolver   | A DNS Resolver   |
| user-agent | The User-Agent   |
| uri        | URI              |
| method     | HTTP Method      |
