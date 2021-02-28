#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <ami/ami.h>
#include <ami/ast.h>
#include <ami/khash.h>

#include "pbuf/ccraft.proto3.pb-c.h"

FILE *dump;

void foreach_action(ami_action_t *action, void *u1, void *u2, void *u3)
{
  ami_t *ami = (ami_t *)u1;
  float sleep_cursor = action->sleep_cursor + action->sleep;
  char *name = ami_action_get_name(action);
  char *exec = ami_action_get_exec(action);  
  struct tm *t;
  char *event_time;
  char *tmpstr;

  ami_field_action_t *field_action;
  khint_t k;
  
  EventMessage msg = EVENT_MESSAGE__INIT;
  FieldMap **fieldmaps;
  Variable **variables;
  
  void *buf;
  unsigned len;

  unsigned counter;
  
  /* if (ami->start_time > 0) { */
  /*   t = gmtime((const time_t *)&ami->start_time); */
  /*   printf("%d-%s", 1900 + t->tm_year, t->tm_mon+1 < 10 ? "0" : ""); */
  /*   printf("%d-%s%d ", t->tm_mon+1, t->tm_mday < 10 ? "0" : "",  t->tm_mday); */
  /*   printf("%d:%d:%d\n", t->tm_hour, t->tm_min, t->tm_sec); */
  /* } */
  /* printf("start time:%ld\n", gmtime(&ami->start_time)); */
  
  printf("action name:%s; exec:%s\n", name, exec);
  printf("sleep_cursor=%f\n", sleep_cursor);

  msg.time = ami->start_time;
  msg.actionexec = strdup(exec);

  /* Adding Variables */
  if (ami->variables) {
    variables = malloc(sizeof(Variable *) * kh_size(ami->variables));
    if (!variables) {
      fprintf(stderr, "Could not allocate Variable entry!\n");    
    } else {
      counter = 0;
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

	  variables[counter] = malloc(sizeof(Variable));
	  variable__init(variables[counter]);
	  variables[counter]->name = (char *)key;
	  variables[counter]->value = tmpstr;

	  counter++;
	}
      }

      msg.n_variables = kh_size(ami->variables);
      msg.variables = variables;
      
    } // if (!variable)
  } // if (ami->variables) 

  if (action->field_actions) {
    // First, we count
    counter = 0;
    for (field_action=action->field_actions; field_action; field_action=field_action->next) {
      counter++;
    }
    msg.n_fields = counter;
    fieldmaps = malloc(sizeof(FieldMap *) * counter);
    if (!fieldmaps) {
      fprintf(stderr, "Could not allocate FieldMap entry!\n");      
    } else {
      counter = 0;
      for (field_action=action->field_actions; field_action; field_action=field_action->next) {
	fieldmaps[counter] = malloc(sizeof(FieldMap));
	field_map__init(fieldmaps[counter]);

	if (!strcmp(field_action->action, "set")) {
	  fieldmaps[counter]->type = FIELD_MAP__TYPE__SET;
	  fieldmaps[counter]->key = field_action->field;
	  fieldmaps[counter]->value = field_action->right;
	}
	if (!strcmp(field_action->action, "replace")) {
	  fieldmaps[counter]->type = FIELD_MAP__TYPE__REPLACE;
	}
	fieldmaps[counter]->key = field_action->left;
	fieldmaps[counter]->value = field_action->right;
	counter++;
      }
    }
    msg.fields = fieldmaps;
  }

  len = event_message__get_packed_size(&msg);
  buf = malloc(len);
  event_message__pack(&msg,buf);
  fwrite(buf,len,1,dump);
  free(buf);
  
  free(msg.actionexec);
  
}

int main(int argc, char **argv)
{
  ami_t *ami;
  int ret;
  
  if (argc < 3) {
    fprintf(stderr, "Syntax: %s file.ami file.dump\n", argv[0]);
    return -1;
  }

  dump = fopen(argv[2], "wb");
  
  ami = ami_new();

  ret = ami_parse_file(ami, argv[1]);

  ami_set_action_callback(ami, foreach_action, ami, NULL, NULL);

  ami_ast_walk_actions(ami);
  
  ami_close(ami);

  fclose(dump);
  
  return 0;
}
