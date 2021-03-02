#ifndef _CCRAFT_H_
#define _CCRAFT_H_

/* FIXME:
 * Using records instead of maps for variables
 * fset and freplace. 
 * I could not find a documented way to use maps
 */
const char CCRAFT_SCHEMA[] =
"{\
    \"type\": \"record\",\
    \"name\": \"event\",\
    \"fields\": [\
        {\"name\": \"time\", \"type\": \"int\", \"default\": \"0\"},\
        {\"name\": \"exec\", \"type\": \"string\", \"default\": \"Void\"},\
        {\"name\": \"variables\", \"type\": {\"type\": \"map\", \"name\": \"var\", \"values\": \"string\"}},\
        {\"name\": \"fset\", \"type\": {\"type\": \"map\", \"values\": \"string\"}},\
        {\"name\": \"freplace\", \"type\": {\"type\": \"map\", \"values\": \"string\"}}\
        ]\
}";

#endif // _CCRAFT_H_
