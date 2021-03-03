#ifndef _CCRAFT_H_
#define _CCRAFT_H_

const char CCRAFT_SCHEMA[] =
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

#endif // _CCRAFT_H_
