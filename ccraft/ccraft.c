#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

#include <ami/ami.h>
#include <ami/ast.h>
#include <ami/khash.h>

#include <avro.h>

#include "ccraft.h"
#include "utils.h"

#define QUICKSTOP_CODEC "deflate"
/* #define QUICKSTOP_CODEC "null" */


FILE *dump;
size_t action_counter;

avro_file_writer_t db;
avro_schema_t ccraft_schema;

time_t current_t;

void foreach_action(ami_action_t *action, void *u1, void *u2, void *u3)
{
  ami_t *ami = (ami_t *)u1;
  
  char *tmpstr;

  ami_field_action_t *field_action;
  khint_t k;

  int sleep_cursor = (int) current_t + (int)action->sleep_cursor + (int)action->sleep;
  
  avro_value_t variables_value;
  avro_value_t fset;
  avro_value_t freplace;
  
  avro_value_iface_t  *event_class = avro_generic_class_from_schema(ccraft_schema);
  avro_value_t event;
  avro_generic_value_new(event_class, &event);

  avro_value_t action_value;
  if (avro_value_get_by_name(&event, "action", &action_value, NULL) == 0) {
    avro_value_set_string(&action_value, action->name);
  }
  avro_value_t exec_value;
  if (avro_value_get_by_name(&event, "exec", &exec_value, NULL) == 0) {
    avro_value_set_string(&exec_value, action->exec);
  }
  avro_value_t time_value;
  if (avro_value_get_by_name(&event, "time", &time_value, NULL) == 0) {
    avro_value_set_int(&time_value, sleep_cursor);
  }
    
  if (ami->variables) {
    avro_value_t varkey;
    avro_value_t varval;

    if (avro_value_get_by_name(&event, "variables", &variables_value, NULL) == 0) {     
      for (k = 0; k < kh_end(ami->variables); ++k) {
  	if (kh_exist(ami->variables, k)) {
  	  const char *key = kh_key(ami->variables, k);
  	  ami_variable_t *var = (ami_variable_t *)kh_value(ami->variables, k);
  	  /* ami_variable_debug(var); */
  	  switch(var->type) {
	  case AMI_VAR_VARIABLE:
  	    tmpstr = ami_get_nested_variable_as_str(ami, NULL, var->strval);
	    break;
  	  case AMI_VAR_STR:
  	    tmpstr = strdup(var->strval);
  	    break;
  	  case AMI_VAR_INT:
  	    asprintf(&tmpstr, "%d", var->ival);
  	    break;
  	  default:
  	    fprintf(stderr, "Unable to read variable. Skipping.\n");
  	    continue;
  	  }
	  
	  avro_value_t child;
	  avro_value_add(&variables_value, key, &child, NULL, NULL);
	  avro_value_set_string_len(&child, tmpstr, strlen(tmpstr) + 1);
  	}
      }
    }
  } // if (ami->variables)


  if (action->field_actions) {
    for (field_action=action->field_actions; field_action; field_action=field_action->next) {
      if (!strcmp(field_action->action, "set")) {
	if (avro_value_get_by_name(&event, "fset", &fset, NULL) == 0) {
	  avro_value_t child;
	  avro_value_add(&fset, field_action->field, &child, NULL, NULL);
	  avro_value_set_string_len(&child, field_action->right, strlen(field_action->right) + 1);
	}	  
      }
      if (!strcmp(field_action->action, "replace")) {
	if (avro_value_get_by_name(&event, "freplace", &freplace, NULL) == 0) {
	  avro_value_t child;
	  avro_value_add(&freplace, field_action->left, &child, NULL, NULL);
	  avro_value_set_string_len(&child, field_action->right, strlen(field_action->right) + 1);
	}
      }      
    } // for (field_action=..    
  } // if (action->field_actions)

  if (avro_file_writer_append_value(db, &event)) {
    fprintf(stderr,
	    "Unable to write event value to memory buffer\nMessage: %s\n", avro_strerror());
    exit(EXIT_FAILURE);
  }
  
  avro_value_decref(&event);
  avro_value_iface_decref(event_class);
	
  /* printf("action exec :%s\n", action->exec);  */
}

int main(int argc, char **argv) 
{
  ami_t *ami;
  struct tm *t;
  
  char *dbname;
  int retval;

  action_counter = 0;
  
  if (argc < 3) {
    fprintf(stderr, "Syntax: %s file.ami file.db\n", argv[0]);
    return -1;
  }
  if (avro_schema_from_json_literal(CCRAFT_SCHEMA, &ccraft_schema)) {
    fprintf(stderr, "Unable to parse ccraft schema\n");
    fprintf(stderr, "Error was %s\n", avro_strerror());
    exit(1);
  }
  
  dbname = argv[2];
  
  retval = avro_file_writer_create_with_codec(dbname, ccraft_schema, &db, QUICKSTOP_CODEC, 0);
  if (retval) {
    fprintf(stderr, "There was an error creating %s\n", dbname);
    fprintf(stderr, " error message: %s\n", avro_strerror());
    exit(1);
  }  

  ami = ami_new();
  retval = ami_parse_file(ami, argv[1]);

  if (ami->start_time > 0) {
    time_t start_time = (int)ami->start_time;
    t = gmtime((const time_t *)&start_time);
    if (t) {
      printf("Start Time: ");
      printf("%d-%s", 1900 + t->tm_year, t->tm_mon+1 < 10 ? "0" : "");
      printf("%d-%s%d ", t->tm_mon+1, t->tm_mday < 10 ? "0" : "",  t->tm_mday);
      printf("%s%d:%s%d:%s%d\n", t->tm_hour < 10 ? "0": "", t->tm_hour, t->tm_min < 10 ? "0": "", t->tm_min, t->tm_sec < 10 ? "0" : "", t->tm_sec);
      current_t = mktime(t);
      current_t -= ami->sleep_cursor;
    } else {
      fprintf(stderr, "No time could be extracted!\n");
    }
  } else {
    printf("Start Time: None\n");
    current_t = time(NULL);
    current_t -= ami->sleep_cursor;
  }
  
  ami_set_action_callback(ami, foreach_action, ami, NULL, NULL);
  ami_ast_walk_actions(ami); 
  ami_close(ami);
  
  avro_file_writer_flush(db);
  avro_file_writer_close(db);
  
  return 0;
}

