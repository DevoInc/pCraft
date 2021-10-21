#ifndef _AMI_CACHE_H_
#define _AMI_CACHE_H_

#include <avro.h>

#define QUICKSTOP_CODEC "deflate"

avro_schema_t ami_cache_schema;
avro_file_writer_t ami_cache_file;
time_t current_t;

const char AMI_CACHE_SCHEMA[] =
"{\
    \"type\": \"record\",\
    \"name\": \"event\",\
    \"fields\": [\
        {\"name\": \"time\", \"type\": \"int\", \"default\": \"0\"},\
        {\"name\": \"action\", \"type\": \"string\", \"default\": \"Void\"},\
        {\"name\": \"exec\", \"type\": \"string\", \"default\": \"Void\"},\
        {\"name\": \"variables\", \"type\": {\"type\": \"map\", \"name\": \"var\", \"values\": \"string\"}},\
        {\"name\": \"fset\", \"type\": {\"type\": \"map\", \"values\": \"string\"}},\
        {\"name\": \"freplace\", \"type\": {\"type\": \"map\", \"values\": \"string\"}}\
        ]\
}";

int ami_cache_build(const char *amifile, const char *amicache);

#endif // _AMI_CACHE_H_
