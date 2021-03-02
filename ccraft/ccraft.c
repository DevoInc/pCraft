#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <ami/ami.h>
#include <ami/ast.h>
#include <ami/khash.h>

#include <avro.h>

#include "ccraft.h"

/* #define QUICKSTOP_CODEC "deflate" */
#define QUICKSTOP_CODEC "null"


FILE *dump;
size_t action_counter;

avro_file_writer_t db;
avro_schema_t ccraft_schema;

void foreach_action(ami_action_t *action, void *u1, void *u2, void *u3)
{
  ami_t *ami = (ami_t *)u1;
  char *tmpstr;

  ami_field_action_t *field_action;
  khint_t k;
  int counter;
  
  avro_value_t variables_value;
	  
  avro_value_iface_t  *event_class = avro_generic_class_from_schema(ccraft_schema);
  avro_value_t event;
  avro_generic_value_new(event_class, &event);

  avro_value_t exec_value;
  if (avro_value_get_by_name(&event, "exec", &exec_value, NULL) == 0) {
    avro_value_set_string(&exec_value, action->exec);
  }
  avro_value_t time_value;
  if (avro_value_get_by_name(&event, "time", &time_value, NULL) == 0) {
    avro_value_set_int(&time_value, ami->start_time);
  }

  /* #if 0 */
  /* if (avro_value_get_by_name(&event, "variables", &variables_value, NULL) == 0) { */
  /* 	  avro_value_t varval; */
  /* 	  int is_new = 0;	   */

  /* 	  char *key = "myk"; */
  /* 	  char *mystr = "foo"; */
	  
  /* 	  avro_value_t variable; */
  /* 	  avro_generic_string_new(&variable, mystr); */
  /* 	  avro_value_set_string(&variable, mystr); */
  /* 	  /\* avro_value_set_string(&varval, key);	   *\/ */
  /* 	  avro_value_add(&variables_value, key, &varval, &counter, &is_new); */
    
  /* } */
  /* #endif */
    
  if (ami->variables) {
    avro_value_t varkey;
    avro_value_t varval;

    counter = 0;
    if (avro_value_get_by_name(&event, "variables", &variables_value, NULL) == 0) {
      
      int keyindex;
      for (k = 0; k < kh_end(ami->variables); ++k) {
  	if (kh_exist(ami->variables, k)) {
  	  const char *key = kh_key(ami->variables, k);
  	  ami_variable_t *var = (ami_variable_t *)kh_value(ami->variables, k);
  	  /* ami_variable_debug(var); */
  	  switch(var->type) {
  	  case AMI_VAR_STR:
  	    tmpstr = ami_get_nested_variable_as_str(ami, NULL, var->strval);
  	    break;
  	  case AMI_VAR_INT:
  	    asprintf(&tmpstr, "%d", var->ival);
  	    break;
  	  default:
  	    fprintf(stderr, "Unable to read variable. Skipping.\n");
  	    continue;
  	  }
	  
	  if (avro_value_get_by_name(&variables_value, "key", &varkey, NULL) == 0) {
	    avro_value_set_string(&varkey, key);
	  }
	  if (avro_value_get_by_name(&variables_value, "value", &varval, NULL) == 0) {
	    printf("SET TO %s\n", tmpstr);
	    avro_value_set_string(&varval, tmpstr);
	  }

	  printf("Adding %s -> %s\n", key, tmpstr);
	  
  	  /* avro_value_t varval; */
  	  /* int is_new = 0; */

	  /* avro_value_get_by_name(&event, "variables", &variables_value, NULL); */

	  /* /\* avro_generic_string_new(&varval, tmpstr);	   *\/ */
	  /* if (avro_value_get_by_name(&variables_value, "value", &varval, NULL) == 0) { */
	  /*   avro_value_set_string(&varval, tmpstr); */
	  /* } else { */
	  /*   printf("ohoh\n"); */
	  /* } */
  	  /* int retval = avro_value_add(&variables_value, key, &varval, &counter, &is_new); */
	  /* if (retval) { */
	  /*   printf("Error\n"); */
	  /* } */
	  
  	  counter++;
	  
  	  /* avro_value_set_string(&variable, tmpstr); */
  	  /* if (avro_value_add(&variables_value, key, &variable, NULL, NULL) != 0) { */
  	  /*   fprintf(stderr, "Error adding value to variable. Key '%s': %s\n", key, avro_strerror()); */
  	  /* } */
  	  /* free(tmpstr); */
  	}
      }
    }
  } // if (ami->variables)
      
  avro_value_t fset_value;
  if (avro_value_get_by_name(&event, "fset", &fset_value, NULL) == 0) {

  }  
  avro_value_t freplace_value;
  if (avro_value_get_by_name(&event, "freplace", &freplace_value, NULL) == 0) {

  }  

  if (avro_file_writer_append_value(db, &event)) {
    fprintf(stderr,
	    "Unable to write event value to memory buffer\nMessage: %s\n", avro_strerror());
    exit(EXIT_FAILURE);
  }
  
  avro_value_decref(&event);
  avro_value_iface_decref(event_class);
	
  printf("action exec :%s\n", action->exec); 
}

int main(int argc, char **argv) 
{
  ami_t *ami;
  
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
  ami_set_action_callback(ami, foreach_action, ami, NULL, NULL);
  ami_ast_walk_actions(ami); 
  ami_close(ami);
  
  avro_file_writer_flush(db);
  avro_file_writer_close(db);
  
  return 0;
}

/* void foreach_action(ami_action_t *action, void *u1, void *u2, void *u3) */
/* { */
/*   ami_t *ami = (ami_t *)u1; */
/*   float sleep_cursor = action->sleep_cursor + action->sleep; */
/*   char *name = ami_action_get_name(action); */
/*   char *exec = ami_action_get_exec(action);   */
/*   struct tm *t; */
/*   char *event_time; */
/*   char *tmpstr; */

/*   ami_field_action_t *field_action; */
/*   khint_t k; */
  
/*   EventMessage msg = EVENT_MESSAGE__INIT; */
/*   FieldMap **fieldmaps; */
/*   Variable **variables; */
  
/*   void *buf; */
/*   unsigned len; */

/*   unsigned counter; */


/*   action_counter++; */

/*   if (!action_counter%10000) { printf("."); } */
  
/*   /\* if (ami->start_time > 0) { *\/ */
/*   /\*   t = gmtime((const time_t *)&ami->start_time); *\/ */
/*   /\*   printf("%d-%s", 1900 + t->tm_year, t->tm_mon+1 < 10 ? "0" : ""); *\/ */
/*   /\*   printf("%d-%s%d ", t->tm_mon+1, t->tm_mday < 10 ? "0" : "",  t->tm_mday); *\/ */
/*   /\*   printf("%d:%d:%d\n", t->tm_hour, t->tm_min, t->tm_sec); *\/ */
/*   /\* } *\/ */
/*   /\* printf("start time:%ld\n", gmtime(&ami->start_time)); *\/ */
  
/*   /\* printf("action name:%s; exec:%s\n", name, exec); *\/ */
/*   /\* printf("sleep_cursor=%f\n", sleep_cursor); *\/ */

/*   msg.time = ami->start_time; */
/*   msg.actionexec = strdup(exec); */

/*   /\* Adding Variables *\/ */
/*   if (ami->variables) { */
/*     variables = malloc(sizeof(Variable *) * kh_size(ami->variables)); */
/*     if (!variables) { */
/*       fprintf(stderr, "Could not allocate Variable entry!\n");     */
/*     } else { */
/*       counter = 0; */
/*       for (k = 0; k < kh_end(ami->variables); ++k) { */
/* 	if (kh_exist(ami->variables, k)) { */
/* 	  const char *key = kh_key(ami->variables, k); */
/* 	  ami_variable_t *var = (ami_variable_t *)kh_value(ami->variables, k); */
/* 	  /\* ami_variable_debug(var); *\/ */
/* 	  switch(var->type) { */
/* 	  case AMI_VAR_STR: */
/* 	    tmpstr = ami_get_nested_variable_as_str(ami, NULL, var->strval); */
/* 	    break; */
/* 	  case AMI_VAR_INT: */
/* 	    asprintf(&tmpstr, "%d", var->ival); */
/* 	  break; */
/* 	  default: */
/* 	    fprintf(stderr, "Unable to read variable. Skipping.\n"); */
/* 	    continue; */
/* 	  } */

/* 	  variables[counter] = malloc(sizeof(Variable)); */
/* 	  variable__init(variables[counter]); */
/* 	  variables[counter]->name = (char *)key; */
/* 	  variables[counter]->value = tmpstr; */

/* 	  counter++; */
/* 	} */
/*       } */

/*       msg.n_variables = kh_size(ami->variables); */
/*       msg.variables = variables; */
      
/*     } // if (!variable) */
/*   } // if (ami->variables)  */

/*   if (action->field_actions) { */
/*     // First, we count */
/*     counter = 0; */
/*     for (field_action=action->field_actions; field_action; field_action=field_action->next) { */
/*       counter++; */
/*     } */
/*     msg.n_fields = counter; */
/*     fieldmaps = malloc(sizeof(FieldMap *) * counter); */
/*     if (!fieldmaps) { */
/*       fprintf(stderr, "Could not allocate FieldMap entry!\n");       */
/*     } else { */
/*       counter = 0; */
/*       for (field_action=action->field_actions; field_action; field_action=field_action->next) { */
/* 	fieldmaps[counter] = malloc(sizeof(FieldMap)); */
/* 	field_map__init(fieldmaps[counter]); */

/* 	if (!strcmp(field_action->action, "set")) { */
/* 	  fieldmaps[counter]->type = FIELD_MAP__TYPE__SET; */
/* 	  fieldmaps[counter]->key = field_action->field; */
/* 	  fieldmaps[counter]->value = field_action->right; */
/* 	} */
/* 	if (!strcmp(field_action->action, "replace")) { */
/* 	  fieldmaps[counter]->type = FIELD_MAP__TYPE__REPLACE; */
/* 	  fieldmaps[counter]->key = field_action->left; */
/* 	  fieldmaps[counter]->value = field_action->right; */
/* 	} */
/* 	counter++; */
/*       } */
/*     } */
/*     msg.fields = fieldmaps; */
/*   } */

/*   msg.packed_size = event_message__get_packed_size(&msg); */
  
/*   len = event_message__get_packed_size(&msg); */
/*   /\* printf("len:%d\n", len); *\/ */
/*   /\* msg.packed_size = len; *\/ */
/*   buf = malloc(len); */
/*   event_message__pack(&msg,buf); */
/*   fwrite(buf,len,1,dump); */
/*   free(buf); */
  
/*   free(msg.actionexec); */
  
/* } */

/* int main(int argc, char **argv) */
/* { */
/*   ami_t *ami; */
/*   int ret; */

/*   action_counter = 0; */
  
/*   if (argc < 3) { */
/*     fprintf(stderr, "Syntax: %s file.ami file.dump\n", argv[0]); */
/*     return -1; */
/*   } */

/*   dump = fopen(argv[2], "wb"); */
  
/*   ami = ami_new(); */

/*   ret = ami_parse_file(ami, argv[1]); */

/*   ami_set_action_callback(ami, foreach_action, ami, NULL, NULL); */

/*   ami_ast_walk_actions(ami); */
  
/*   ami_close(ami); */

/*   fclose(dump); */
  
/*   return 0; */
/* } */
