#include <avro.h>

#include "ccraft.h"

int main(int argc, char **argv)
{
  avro_file_reader_t dbreader;
  avro_schema_t ccraft_schema;
  int32_t *p, *p2;
  size_t size;
  char *dbfile;

  int retval;
  
  if (argc < 2) {
    fprintf(stderr, "Syntax: %s file.db\n", argv[0]);
    return -1;
  }
  dbfile = argv[1];

  if (avro_schema_from_json_literal(CCRAFT_SCHEMA, &ccraft_schema)) {
    fprintf(stderr, "Unable to parse person schema\n");
    exit(EXIT_FAILURE);
  }

  
  if (avro_file_reader(dbfile, &dbreader)) {
    fprintf(stderr, "Error opening file: %s\n", avro_strerror());
    exit(1);
  }

  /* if (print_event(dbreader, NULL)) { */
  /*   fprintf(stderr, "Error printing person\nMessage: %s\n", avro_strerror()); */
  /*   exit(EXIT_FAILURE); */
  /* } */

  avro_value_iface_t *event_class = avro_generic_class_from_schema(ccraft_schema);

  avro_value_t event;
  avro_generic_value_new(event_class, &event);

  
  retval = avro_file_reader_read_value(dbreader, &event);
  while (!retval) {
    avro_value_t exec_value;
    if (avro_value_get_by_name(&event, "exec", &exec_value, NULL) == 0) {
      avro_value_get_string(&exec_value, &p, &size);
      fprintf(stdout, "%s\n", p);
    } else {
      fprintf(stderr, "Error: %s\n", avro_strerror());
    }

    avro_value_t variables;
    if (avro_value_get_by_name(&event, "variables", &variables, NULL) == 0) {
      size_t var_size;
      
      /* avro_value_t key; */
      /* avro_value_t val; */
      /* avro_value_get_by_index(&variables, 0, &key, NULL); */
      /* avro_value_get_string(&key, &p, &size); */
      /* avro_value_get_by_index(&variables, 1, &val, NULL); */
      /* avro_value_get_string(&val, &p2, &size); */
      
      /* printf("key:%s;val:%s\n", p, p2); */
      
      avro_value_get_size(&variables, &var_size);
      for (size_t i=0; i < var_size; i++) {
      	const char *key;
      	avro_value_t val;
      	avro_value_get_by_index(&variables, i,
      				&val, &key);
      	printf("key:%s\n", key);
      	avro_value_get_string(&val, &p, &size);
      	printf("val:%s\n", p);
      }
      printf("Size for variables:%d\n", var_size);
    }    
    
    retval = avro_file_reader_read_value(dbreader, &event);
  }
 
 avro_value_decref(&event);
 avro_value_iface_decref(event_class);
 
  avro_file_reader_close(dbreader);
 

  
  return 0;
}
