Event samples taken from https://cloud.google.com/security-command-center/docs/how-to-use-event-threat-detection

We then use this script to templatize:
```
#!/bin/bash
sed -i.bak 's/PROJECT_ID/{{{PROJECT_ID}}}/g' $1
sed -i.bak 's/PROJECT_NUMBER/{{{PROJECT_NUMBER}}}/g' $1
sed -i.bak 's/USER_EMAIL/{{{USER_EMAIL}}}/g' $1
sed -i.bak 's/RAW_USER_AGENT/{{{RAW_USER_AGENT}}}/g' $1
sed -i.bak 's/LOGGING_LINK/{{{LOGGING_LINK}}}/g' $1
sed -i.bak 's/ORGANIZATION_ID/{{{ORGANIZATION_ID}}}/g' $1
sed -i.bak 's/CALLER_USER_AGENT/{{{CALLER_USER_AGENT}}}/g' $1
sed -i.bak 's/SOURCE_ID/{{{SOURCE_ID}}}/g' $1
sed -i.bak 's/INSERT_ID/{{{INSERT_ID}}}/g' $1
sed -i.bak 's/\"IP_ADDRESS/\"{{{IP_ADDRESS}}}/g' $1
sed -i.bak 's/FINDING_ID/{{{FINDING_ID}}}/g' $1
sed -i.bak 's/INSTANCE_ID/{{{INSTANCE_ID}}}/g' $1
sed -i.bak 's/SOURCE_IP_ADDRESS/{{{SOURCE_IP_ADDRESS}}}/g' $1
sed -i.bak 's/DESTINATION_IP_ADDRESS/{{{DESTINATION_IP_ADDRESS}}}/g' $1
sed -i.bak 's/JOB_ID/{{{JOB_ID}}}/g' $1
sed -i.bak 's/SQL_QUERY/{{{SQL_QUERY}}}/g' $1
sed -i.bak 's/SOURCE_PROJECT_ID/{{{SOURCE_PROJECT_ID}}}/g' $1
sed -i.bak 's/DATASET_ID/{{{DATASET_ID}}}/g' $1
sed -i.bak 's/TABLE_ID/{{{TABLE_ID}}}/g' $1
sed -i.bak 's/DESTINATION_PROJECT_ID/{{{DESTINATION_PROJECT_ID}}}/g' $1
sed -i.bak 's/DOMAIN/{{{DOMAIN}}}/g' $1
sed -i.bak 's/REGION/{{{REGION}}}/g' $1
sed -i.bak 's/ZONE/{{{ZONE}}}/g' $1
sed -i.bak 's/SOURCE_PORT/{{{SOURCE_PORT}}}/g' $1
sed -i.bak 's/DESTINATION_PORT/{{{SOURCE_PORT}}}/g' $1
sed -i.bak 's/SUBNETWORK_ID/{{{SUBNETWORK_ID}}}/g' $1
sed -i.bak 's/RESOURCE_NAME/{{{RESOURCE_NAME}}}/g' $1
sed -i.bak 's/PRINCIPAL_EMAIL/{{{PRINCIPAL_EMAIL}}}/g' $1
sed -i.bak 's/USER_AGENT/{{{USER_AGENT}}}/g' $1
```