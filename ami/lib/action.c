#include <stdio.h>
#include <stdlib.h>

#include <ami/ami.h>
#include <ami/action.h>
#include <ami/kvec.h>
#include <ami/khash.h>

ami_action_t *ami_action_new()
{
  ami_action_t *action;

  action = (ami_action_t *)malloc(sizeof(ami_action_t));
  if (!action) {
    fprintf(stderr, "Cannot allocate ami_action_t!\n");
    return NULL;
  }

  action->name = NULL;
  action->exec = NULL;
  kv_init(action->replace_key);
  kv_init(action->replace_val);
  action->variables = kh_init(varhash);
  action->field_actions = NULL;
  action->sleep_cursor = 0;
  action->repeat_index = 0;
  
  return action;
}

char *ami_action_get_name(ami_action_t *action)
{
  return action->name;
}

char *ami_action_get_exec(ami_action_t *action)
{
  return action->exec;
}

void ami_action_close(ami_action_t *action)
{
  khint_t k;

  /* if (action->replace_field) { */
  /*   free(action->replace_field); */
  /* } */
  
  for (k = 0; k < kh_end(action->variables); ++k) {
    if (kh_exist(action->variables, k)) {
      free((char *)kh_key(action->variables, k));
      ami_variable_free((ami_variable_t *)kh_value(action->variables, k));
      kh_del(actionhash, action->variables, k);
    }
  }
  kh_destroy(actionhash, action->variables);
  
  free(action);
}

void ami_action_debug(ami_t *ami, ami_action_t *action)
{
  khint_t k;

  printf("In action debug\n");

  if (!action) {
    fprintf(stderr, "action is NULL, nothing to debug!\n");
    return;
  }

  if (action->name) printf("action->name:%s\n", action->name);
  if (action->exec) printf("action->exec:%s\n", action->exec);

  if (action->variables) {
    printf("*** action->variables\n");
    for (k = 0; k < kh_end(action->variables); ++k)
      if (kh_exist(action->variables, k)) {
	char *key = (char *)kh_key(action->variables, k);
	ami_variable_t *val = (ami_variable_t *)kh_value(action->variables, k);
	printf("action variable name:%s;value:\n", key);
	ami_variable_debug(val);
      }
  } else { printf("no action variable!\n");}
  size_t n_array = kv_size(action->replace_key);
  if (n_array > 0) {
    for (size_t i = 0; i< n_array; i++) {
      char *key = kv_A(action->replace_key, i);
      char *value = kv_A(action->replace_val, i);      
      if (strlen(value) > 0) {
	if (value[0] == '$') {
	  value = ami_get_variable(ami, value);
	}		    
      }
      printf("action replace %s with %s\n", key, value);
    }
  }
}

/* int ami_action_get_variables_len(ami_action_t *action) */
/* { */
/*   khint_t k; */
/*   int len = 0; */
  
/*   if (action->action_variables) { */
/*     for (k = 0; k < kh_end(action->action_variables); ++k) { */
/*       len++; */
/*     } */
/*   } */
/*   return len; */
/* } */

/* char *ami_action_get_variables_key_at_pos(ami_action_t *action, int pos) */
/* { */
/*   khint_t k; */
/*   int len = 0; */
  
/*   if (action->action_variables) { */
/*     for (k = 0; k < kh_end(action->action_variables); ++k) { */
/*       if (kh_exist(action->action_variables, k)) { */
/* 	if (k == pos) { */
/* 	  return (char *)kh_key(action->action_variables, k); */
/* 	} */
/*       } */
/*     } */
/*   } */
/*   return NULL; */
/* } */

ami_variable_t *ami_action_get_variable(ami_action_t *action, char *key)
{
  khint_t k;

  if (!action) return NULL;
  if (!action->variables) return NULL;  
  
  k = kh_get(varhash, action->variables, key);
  int is_missing = (k == kh_end(action->variables));
  if (is_missing) return NULL;
  ami_variable_t *val = kh_value(action->variables, k);
  return val;
}

int ami_action_get_replacement_len(ami_action_t *action)
{
  return kv_size(action->replace_key);
}

char *ami_action_get_replacement_field(ami_action_t *action)
{
  return action->replace_field;
}

char *ami_action_get_replacement_key_at_pos(ami_action_t *action, int pos)
{
  return (char *)kv_A(action->replace_key, pos);
}

char *ami_action_get_replacement_value_at_pos_with_ami(ami_t *ami, ami_action_t *action, int pos)
{
  ami_variable_t *var;
  char *value = kv_A(action->replace_val, pos);
  if (strlen(value) > 0) {
    if (value[0] == '$') {
      var = ami_get_variable(ami, value);
      value = var->strval;
    }
  }
  
  return value;
}

char *ami_action_get_replacement_value_at_pos(ami_action_t *action, int pos)
{
  return (char *)kv_A(action->replace_val, pos);
}

ami_field_action_t *ami_field_action_new(void)
{
  ami_field_action_t *field_action;

  field_action = (ami_field_action_t *)malloc(sizeof(ami_field_action_t));
  if (!field_action) {
    fprintf(stderr, "Cannot allocate ami_field_action_t!\n");
    return NULL;
  }
  
  field_action->field  = NULL;
  field_action->action = NULL;
  field_action->left   = NULL;
  field_action->right  = NULL;
  field_action->next   = NULL;
  
  return field_action;
}

ami_field_action_t *ami_field_action_append(ami_field_action_t *dst, ami_field_action_t *src)
{
  ami_field_action_t *field_action = dst;
  if (!dst) {
    dst = src;
    return dst;
  }

  if (!field_action) {
    fprintf(stderr, "No destination!\n");
    return NULL;
  }
  while (field_action->next) {
    field_action = field_action->next;
  }
  field_action->next = src;

  return dst;  
}

int ami_action_set_variable(ami_action_t *action, const char *key, ami_variable_t *var)
{
  int absent;
  khint_t k;
  
  if (!action) return 1;
  if (!action->variables) return 1;  

  k = kh_put(varhash, action->variables, key, &absent);
  if (absent) {
    kh_key(action->variables, k) = strdup(key);
    kh_value(action->variables, k) = var;
  } else {
    ami_variable_free(kh_value(action->variables, k));
    kh_value(action->variables, k) = var;
  }

  return 0;
}

void ami_field_action_debug(ami_action_t *action)
{
  ami_field_action_t *a;
  for (a=action->field_actions;a;a=a->next) {
    printf("<FieldAction>\n");
    printf("field:%s\n", a->field);
    printf("action:%s\n", a->action);
    if(a->left) {
      printf("left:%s\n", a->left);
    }
    printf("right:%s\n", a->right);
    printf("</FieldAction>\n");
  }
}

