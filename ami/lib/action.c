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
  action->action_variables = kh_init(actionhash);

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
  
  for (k = 0; k < kh_end(action->action_variables); ++k) {
    if (kh_exist(action->action_variables, k)) {
      free((char *)kh_key(action->action_variables, k));
      free((char *)kh_value(action->action_variables, k));
      kh_del(actionhash, action->action_variables, k);
    }
  }
  
  free(action);
}

void ami_action_copy_variables(ami_t *ami, ami_action_t *action)
{
  khint_t k, k2;
  int absent;
  // ami->global_variables
  
  if (ami->global_variables) {
    for (k = 0; k < kh_end(ami->global_variables); ++k)
      if (kh_exist(ami->global_variables, k)) {
	char *key = (char *)kh_key(ami->global_variables, k);
	char *val = (char *)kh_value(ami->global_variables, k);
	k2 = kh_put(actionhash, action->action_variables, key, &absent);
	if (absent) {
	  kh_key(action->action_variables, k2) = strdup(key);	  
	  kh_value(action->action_variables, k2) = strdup(val);
	} else {
	  free(kh_value(action->action_variables, k2));
	  kh_value(action->action_variables, k2) = strdup(val);
	}
	/* free(key); */
	/* free(val); */
      }
  }
  if (ami->local_variables) {
    for (k = 0; k < kh_end(ami->local_variables); ++k)
      if (kh_exist(ami->local_variables, k)) {
	char *key = (char *)kh_key(ami->local_variables, k);
	char *val = (char *)kh_value(ami->local_variables, k);
	k2 = kh_put(actionhash, action->action_variables, key, &absent);
	if (absent) {
	  kh_key(action->action_variables, k2) = strdup(key);	  
	  kh_value(action->action_variables, k2) = strdup(val);
	} else {
	  free(kh_value(action->action_variables, k2));
	  kh_value(action->action_variables, k2) = strdup(val);
	}
	/* free(key); */
	/* free(val); */
      }
  }
  
}

void ami_action_debug(ami_t *ami, ami_action_t *action)
{
  khint_t k;

  printf("In action debug\n");

  if (!action) {
    fprintf(stderr, "action is NULL, nothing to debug!\n");
    return;
  }
  
  printf("action->name:%s\n", action->name);
  printf("action->exec:%s\n", action->exec);
  
  if (action->action_variables) {
    for (k = 0; k < kh_end(action->action_variables); ++k)
      if (kh_exist(action->action_variables, k)) {
	char *key = (char *)kh_key(action->action_variables, k);
	char *val = (char *)kh_value(action->action_variables, k);
	printf("action_variable: %s:%s\n", key, val);
      }
  }
  size_t n_array = kv_size(action->replace_key);
  if (n_array > 0) {
    for (size_t i = 0; i< n_array; i++) {
      char *key = kv_A(action->replace_key, i);
      char *value = kv_A(action->replace_val, i);      
      if (strlen(value) > 0) {
	if (value[0] == '$') {
	  value = ami_get_global_variable(ami, value);
	}		    
      }
      printf("action replace %s with %s\n", key, value);
    }
  }
}

int ami_action_get_variables_len(ami_action_t *action)
{
  khint_t k;
  int len = 0;
  
  if (action->action_variables) {
    for (k = 0; k < kh_end(action->action_variables); ++k) {
      len++;
    }
  }
  return len;
}

void ami_action_copy_replacements(ami_t *ami, ami_action_t *action)
{
    kv_copy(char *,action->replace_key, ami->_ast->replace_key);
    kv_copy(char *,action->replace_val, ami->_ast->replace_val);
}

