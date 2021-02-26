#include <stdio.h>
#include <stdlib.h>
#define _GNU_SOURCE
#include <search.h>
#include <errno.h>

#include <parse.h>

#include <ami/ami.h>
#include <ami/csvread.h>
#include <ami/tree.h>
#include <ami/strutil.h>

#include <ami/kvec.h>
#include <ami/khash.h>

ami_t *ami_new(void)
{
  ami_t *ami;
  int retval;
  int i;
  
  ami = (ami_t *)malloc(sizeof(ami_t));
  if (!ami) {
    fprintf(stderr, "Cannot allocate ami_t!\n");
    return NULL;
  }

  ami->error = NO_ERROR;
  ami->file = NULL;
  ami->_action_block_id = 0;
  ami->_repeat_block_id = 0;
  ami->_opened_sections = 0;
  ami->_is_verbatim_string = 0;
  ami->current_line = 1;
  ami->debug = 0;
  ami->version = 0;
  ami->start_time = 0;
  ami->revision = 0;
  ami->author = NULL;
  ami->shortdesc = NULL;
  ami->description = NULL;

  ami->printmessagecb = NULL;
  ami->sleepcb = NULL;
  ami->action_cb = NULL;
  
  kv_init(ami->references);
  kv_init(ami->tags);
  
  ami->variables = kh_init(varhash);

  ami->root_node = NULL;
  ami->current_node = NULL;

  kv_init(ami->values_stack);  

  ami->replace_count = 0;
  ami->sleep_cursor = 0;

  ami->in_repeat = 0;
  ami->in_action = 0;

  ami->arguments_count = 0;

  for (i = 0; i < MAX_NESTED_REPEAT; i++) {
    ami->repeat_indices[i] = 0;
  }
  for (i = 0; i < MAX_NESTED_REPEAT; i++) {
    ami->repeat_indices_cursor[i] = 0;
  }
  ami->current_repeat_block = 0;

  ami->global_counter = 0;
  
  return ami;
}

void ami_global_counter_incr(ami_t *ami) {
  ami->global_counter++;
}

int ami_variable_exists(ami_t *ami, const char *key)
{
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->variables) return 1;  
  
  k = kh_put(varhash, ami->variables, key, &absent);
  if (absent) {
    return 0;
  }
  
  return 1;
}

/* If the variable already exists, return 1. 0 otherwise. */
int ami_set_variable(ami_t *ami, const char *key, ami_variable_t *var)
{
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->variables) return 1;  

  k = kh_put(varhash, ami->variables, key, &absent);
  if (absent) {
    kh_key(ami->variables, k) = strdup(key);
    kh_value(ami->variables, k) = var;
  } else {
    /* ami_variable_free(kh_value(ami->variables, k)); */
    kh_value(ami->variables, k) = var;
    return 1;
  }
  
  return 0;
}

int ami_set_variable_int(ami_t *ami, const char *varkey, int ival)
{
  ami_variable_t *var;
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->variables) return 1;  

  for (k = 0; k < kh_end(ami->variables); ++k) {
    if (kh_exist(ami->variables, k)) {
      char *key = (char *)kh_key(ami->variables, k);
      if (!strcmp(key, varkey)) {
	var = (ami_variable_t *)kh_value(ami->variables, k);
	var->ival = ival;
	return 0;
      }
    }
  }
  
  return 1;
}

int ami_replace_variable(ami_t *ami, const char *key, ami_variable_t *var)
{
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->variables) return 1;  
  
  k = kh_put(varhash, ami->variables, key, &absent);
  if (absent) {
    kh_key(ami->variables, k) = strdup(key);
    kh_value(ami->variables, k) = var;
  } else {
    ami_variable_free(kh_value(ami->variables, k));
    kh_value(ami->variables, k) = var;
    return 1;
  }
  
  return 0;
}

ami_variable_t *ami_get_variable(ami_t *ami, const char *key)
{
  khint_t k;

  k = kh_get(varhash, ami->variables, key);
  int is_missing = (k == kh_end(ami->variables));
  if (is_missing) return NULL;
  ami_variable_t *var = kh_value(ami->variables, k);
  
  return var;
}

ami_variable_t *ami_fetch_variable(ami_t *ami, const char *key)
{
  // REMOVE ME, USE NESTED_VARIABLE INSTEAD
  /* khint_t k;   */
  
  /* k = kh_get(varhash, ami->variables, key); */
  /* int is_missing = (k == kh_end(ami->variables)); */
  /* if (is_missing) return NULL; */
  /* ami_variable_t *var = kh_value(ami->variables, k); */
  
  /* return var; */
}

void ami_debug(ami_t *ami)
{
  khint_t k;

  if (!ami) {
    fprintf(stderr, "Ami is null. Cannot debug!\n");
    return;
  }
  
  printf("version:%d\n", ami->version);
  printf("revision:%d\n", ami->revision);  
  if (ami->author) {
    printf("author:%s\n", ami->author);
  }
  if (ami->shortdesc) {
    printf("shortdesc:%s\n", ami->shortdesc);
  }
  size_t n_array = kv_size(ami->tags);
  if (n_array > 0) {
    for (size_t i = 0; i < n_array; i++) {
      printf("\ttag %d: %s\n", i, kv_A(ami->tags, i));
    }
  }
  n_array = kv_size(ami->references);
  if (n_array > 0) {
    for (size_t i = 0; i < n_array; i++) {
      printf("\tref %d: %s\n", i, kv_A(ami->references, i));
    }
  }

  printf("final new global variables (they can change in the flow):\n");
  if (ami->variables) {
    for (k = 0; k < kh_end(ami->variables); ++k)
      if (kh_exist(ami->variables, k)) {
	const char *key = kh_key(ami->variables, k);
	ami_variable_t *var = (ami_variable_t *)kh_value(ami->variables, k);
	printf("variable key:%s\n", key);
	ami_variable_debug(var);
	/* printf("\t%s => %s\n", (char *)kh_key(ami->global_variables, k), (char *)kh_value(ami->global_variables, k)); */
      }
  }

  
}

int ami_erase_variable(ami_t *ami, char *varkey)
{
  khiter_t k;
  char *key;
  ami_variable_t *var;
  
  for (k = 0; k < kh_end(ami->variables); ++k) {
    if (kh_exist(ami->variables, k)) {
      key = (char *)kh_key(ami->variables, k);
      if (!strcmp(key, varkey)) {
	var = (ami_variable_t *)kh_value(ami->variables, k);
	free(key);
	ami_variable_free(var);
	kh_del(varhash, ami->variables, k);
	return 0;
      }
    }
  }
  return 1;
}

void ami_erase_variables(ami_t *ami)
{
  khiter_t k;
  char *key;
  ami_variable_t *var;
  
  for (k = 0; k < kh_end(ami->variables); ++k) {
    if (kh_exist(ami->variables, k)) {
      key = (char *)kh_key(ami->variables, k);
      /* printf("Deleting %s\n", key); */
      var = (ami_variable_t *)kh_value(ami->variables, k);
      free(key);
      ami_variable_free(var);
      kh_del(varhash, ami->variables, k);
    }
  }  
}

void ami_node_close(ami_node_t *node, int right)
{
  ami_node_t *next;
  ami_node_t *node_right;
  if (right) {
    next = node->right;
  } else {
    next = node->next;
  }
  node_right = node->right;
  if (node->strval) {
    free(node->strval);
  }
  free(node);
  if (next) {
    ami_node_close(next, node_right?1:0);
  }  
}

void ami_close(ami_t *ami)
{
  ami_node_t *n;
  khint_t k;

  if (!ami) return;
  if (ami->file) free(ami->file);
  
  kv_destroy(ami->references);
  kv_destroy(ami->values_stack);

  ami_erase_variables(ami);

  if (ami->root_node) {
    ami_node_close(ami->root_node, 0);
  }

  kh_destroy(varhash, ami->variables);
  
  free(ami);
}

int ami_validate(ami_t *ami)
{
  if (ami->version == 0) {
    ami->error = NO_VERSION;
    return 1;
  }
  
  return 0;
}

char *ami_error_to_string(ami_t *ami) {
  if (!ami) return "AMI struct not defined!";
  
  switch(ami->error) {
  case NO_VERSION:
    return "Please set 'ami_version 1' in the file.";
    break;
  default:
    return "no error";
    break;
  }
  
  return "huh?";
}


int ami_parse_file(ami_t *ami, const char *file)
{
	char *string = "This is a bunch of words";
	yyscan_t scanner;
	int state;
	FILE *fpin;

	/* printf("Parsing file: %s\n", file); */
	
	if (!ami) {
	  fprintf(stderr, "Cannot parse file %s as library initialization failed.\n", file);
	  return 1;
	}


	ami->file = strdup(file);
	
	if (ami_yylex_init(&scanner) != 0) {
		fprintf(stderr, "Error initializing yylex\n");
		return 1;
	}

	fpin = fopen(file, "r");
	if (!fpin) {
	  fprintf(stderr, "Error parsing %s\n", file);
	  return 1;
	}
	state = ami_yyrestart(fpin, scanner);
	
	/* state = ami_yy_scan_string(string, scanner); */
	if (ami_yyparse(scanner, ami) != 0) {
	        fprintf(stderr, "Error with yyparse\n");
		return 1;
	}
	/* ami_yy_delete_buffer(state, scanner); */
	ami_yylex_destroy(scanner);
	
	fflush(fpin);
	fclose(fpin);

	return ami_validate(ami);
}

void ami_set_message_callback(ami_t *ami, print_message_cb message_cb)
{
  ami->printmessagecb = message_cb;
}

void ami_set_sleep_callback(ami_t *ami, sleep_cb sleep_cb)
{
  ami->sleepcb = sleep_cb;
}

int ami_loop(ami_t *ami, foreach_action_cb action_cb, void *user_data)
{

}

void ami_set_action_callback(ami_t *ami, ami_action_cb action_cb, void *userdata1, void *userdata2, void *userdata3)
{
  ami->action_cb = action_cb;
  ami->action_cb_userdata1 = userdata1;
  ami->action_cb_userdata2 = userdata2;  
  ami->action_cb_userdata3 = userdata3;  
}

void ami_append_item(ami_t *ami, int lineno, ami_node_type_t type, char *strval, int intval, float fval, int is_verbatim_string)
{
  /* printf("\tnode type:%s\n", ami_node_names[type]); */
  if (ami->_repeat_block_id > 0) {
    ami_node_create(&ami->current_node, lineno, type, strval, intval, fval, 0);
  } else {
    ami_node_create(&ami->root_node, lineno, type, strval, intval, fval, 0);
    ami->current_node = NULL;
  }
}

void ami_append_repeat(ami_t *ami, int lineno, ami_node_type_t type, char *strval, int intval, float fval, int is_verbatim_string)
{
  if (ami->current_node) {
    ami->current_node = ami_node_create_right(&ami->current_node, lineno, type, strval, intval, fval, 0);
  } else {
    ami->current_node = ami_node_create_right(&ami->root_node, lineno, type, strval, intval, fval, 0);
  }
}

char *ami_get_nested_variable_as_str(ami_t *ami, ami_node_t *node, char *var_value)
{
  ami_variable_t *retvar;

  if (!var_value) {
    fprintf(stderr, "Key is NULL! No Variable to extract!\n");
    return "";
  }

  if (strlen(var_value) > 0) {
    if (var_value[0] != '$') return var_value; // This is not a variable
  } else {
    fprintf(stderr, "Variable value for '%s' empty!\n", var_value);
    ami_node_debug_current(node);
    return "";
    /* return NULL; */
  }

  retvar = ami_get_variable(ami, var_value);
  if (!retvar) {
    if (node) {
      fprintf(stderr, "Cannot get value for variable %s at line %d\n", var_value, node->lineno);
    } else {
      fprintf(stderr, "Cannot get value for variable %s\n", var_value);
    }
    return NULL;
  }
  return retvar->strval;
}

int ami_get_nested_variable_as_int(ami_t *ami, char *var_value)
{
  ami_variable_t *retvar;

  if (!var_value) {
    fprintf(stderr, "Key is NULL! No Variable to extract!\n");
    return -1;
  }

  if (strlen(var_value) > 0) {
    if (var_value[0] != '$') return strtod(var_value, NULL); // This is not a variable
  }

  retvar = ami_get_variable(ami, var_value);
  
  return retvar->ival;
}


float ami_get_sleep_cursor(ami_t *ami)
{
  return ami->sleep_cursor;
}
