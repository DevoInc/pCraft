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
  ami->revision = 0;
  ami->author = NULL;
  ami->shortdesc = NULL;
  ami->description = NULL;

  ami->printmessagecb = NULL;
  ami->sleepcb = NULL;
  ami->action_cb = NULL;
  
  kv_init(ami->references);
  kv_init(ami->tags);
  
  ami->global_variables = kh_init(strhash);
  ami->repeat_variables = kh_init(strhash);
  ami->local_variables = kh_init(strhash);

  ami->root_node = NULL;
  ami->current_node = NULL;

  kv_init(ami->values_stack);  

  ami->replace_count = 0;
  ami->sleep_cursor = 0;

  ami->in_repeat = 0;
  ami->in_action = 0;

  ami->arguments_count = 0;
  
  return ami;
}

int ami_set_global_variable(ami_t *ami, char *key, char *val) {
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->global_variables) return 1;  

  /* printf("%s: %s -> %s\n", __FUNCTION__, key, val); */
  
  k = kh_put(strhash, ami->global_variables, key, &absent);
  if (absent) {
    kh_key(ami->global_variables, k) = strdup(key);
    kh_value(ami->global_variables, k) = strdup(val);
  } else {
    free(kh_value(ami->global_variables, k));
    kh_value(ami->global_variables, k) = strdup(val);
  }
  
  return 0;
}

int ami_set_local_variable(ami_t *ami, char *key, char *val) {
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->local_variables) return 1;  

  if (!val) {
    fprintf(stderr, "Cannot set value for %s: empty\n", key);
    return 1;
  }
  
  /* printf("%s: %s -> %s\n", __FUNCTION__, key, val); */
  
  k = kh_put(strhash, ami->local_variables, key, &absent);
  if (absent) {
    kh_key(ami->local_variables, k) = strdup(key);
    kh_value(ami->local_variables, k) = strdup(val);
  } else {
    free(kh_value(ami->local_variables, k));
    kh_value(ami->local_variables, k) = strdup(val);
  }
  
  return 0;
}

int ami_set_repeat_variable(ami_t *ami, char *key, char *val) {
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->repeat_variables) return 1;  

  /* printf("%s: %s -> %s\n", __FUNCTION__, key, val); */
  
  k = kh_put(strhash, ami->repeat_variables, key, &absent);
  if (absent) {
    kh_key(ami->repeat_variables, k) = strdup(key);
    kh_value(ami->repeat_variables, k) = strdup(val);
  } else {
    free(kh_value(ami->repeat_variables, k));
    kh_value(ami->repeat_variables, k) = strdup(val);
  }
  
  return 0;
}

const char *ami_get_global_variable(ami_t *ami, char *key)
{
  khint_t k;

  k = kh_get(strhash, ami->global_variables, key);
  int is_missing = (k == kh_end(ami->global_variables));
  if (is_missing) return NULL;
  const char *val = kh_value(ami->global_variables, k);
  return val;
}

const char *ami_get_local_variable(ami_t *ami, char *key)
{
  khint_t k;
  
  k = kh_get(strhash, ami->local_variables, key);
  int is_missing = (k == kh_end(ami->local_variables));
  if (is_missing) return NULL;
  const char *val = kh_value(ami->local_variables, k);
  return val;
}

const char *ami_get_repeat_variable(ami_t *ami, char *key)
{
  khint_t k;
  
  k = kh_get(strhash, ami->repeat_variables, key);
  int is_missing = (k == kh_end(ami->repeat_variables));
  if (is_missing) return NULL;
  const char *val = kh_value(ami->repeat_variables, k);
  return val;
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

  if (ami->global_variables) {
    printf("final global variables (they can change in the flow):\n");
    for (k = 0; k < kh_end(ami->global_variables); ++k)
      if (kh_exist(ami->global_variables, k)) {
	printf("\t%s => %s\n", (char *)kh_key(ami->global_variables, k), (char *)kh_value(ami->global_variables, k));
    }
  }

  
}

void ami_erase_global_variables(ami_t *ami)
{
  khiter_t k;
  
  for (k = 0; k < kh_end(ami->global_variables); ++k) {
    if (kh_exist(ami->global_variables, k)) {
      free((char *)kh_key(ami->global_variables, k));
      free((char *)kh_value(ami->global_variables, k));
      kh_del(strhash, ami->global_variables, k);
    }
  }
  
}

void ami_erase_local_variables(ami_t *ami)
{
  khiter_t k;
  
  for (k = 0; k < kh_end(ami->local_variables); ++k) {
    if (kh_exist(ami->local_variables, k)) {
      free((char *)kh_key(ami->local_variables, k));
      free((char *)kh_value(ami->local_variables, k));
      kh_del(strhash, ami->local_variables, k);
    }
  }
  
}

void ami_erase_repeat_variables(ami_t *ami)
{
  khiter_t k;
  
  for (k = 0; k < kh_end(ami->repeat_variables); ++k) {
    if (kh_exist(ami->repeat_variables, k)) {
      free((char *)kh_key(ami->repeat_variables, k));
      free((char *)kh_value(ami->repeat_variables, k));
      kh_del(strhash, ami->repeat_variables, k);
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

  if (ami->global_variables) {
    for (k = 0; k < kh_end(ami->global_variables); ++k) {
      if (kh_exist(ami->global_variables, k)) {
	free((char *)kh_key(ami->global_variables, k));
	free((char *)kh_value(ami->global_variables, k));
      }
    }
  }
  if (ami->repeat_variables) {
    for (k = 0; k < kh_end(ami->repeat_variables); ++k) {
      if (kh_exist(ami->repeat_variables, k)) {
	free((char *)kh_key(ami->repeat_variables, k));
	free((char *)kh_value(ami->repeat_variables, k));
      }
    }
  }
  if (ami->local_variables) {
    for (k = 0; k < kh_end(ami->local_variables); ++k) {
      if (kh_exist(ami->local_variables, k)) {
	free((char *)kh_key(ami->local_variables, k));
	free((char *)kh_value(ami->local_variables, k));
      }
    }
  }

  if (ami->root_node) {
    ami_node_close(ami->root_node, 0);
  }

  kh_destroy(strhash, ami->global_variables);
  kh_destroy(strhash, ami->repeat_variables);
  kh_destroy(strhash, ami->local_variables);
  
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

void ami_set_action_callback(ami_t *ami, ami_action_cb action_cb, void *userdata)
{
  ami->action_cb = action_cb;
  ami->action_cb_userdata = userdata;
}

void ami_append_item(ami_t *ami, ami_node_type_t type, char *strval, int intval, float fval, int is_verbatim_string)
{
    if (ami->_repeat_block_id > 0) {
      // All the stuff we repeat come one after another
      ami_node_create_right(&ami->root_node, type, strval, intval, fval, 0);
    } else {
      ami_node_create(&ami->root_node, type, strval, intval, fval, 0);
    }
}

char *ami_get_variable(ami_t *ami, char *key)
{
  char *retval;
  if (!key) {
    fprintf(stderr, "Key is NULL! No Variable to extract!\n");
    return "";
  }

  if (strlen(key) > 0) {
    if (key[0] != '$') return key; // This is not a variable
  }
  
  retval = ami_get_local_variable(ami, key);
  if (retval) return retval;
  
  retval = ami_get_repeat_variable(ami, key);
  if (retval) return retval;

  return ami_get_global_variable(ami, key);  
}

void ami_print_all_variables(ami_t *ami)
{
  khint_t k;

  if (ami->global_variables) {
    printf("Global Variables:\n");
    for (k = 0; k < kh_end(ami->global_variables); ++k)
      if (kh_exist(ami->global_variables, k)) {
	printf("\t%s => %s\n", (char *)kh_key(ami->global_variables, k), (char *)kh_value(ami->global_variables, k));
      }
  }
  if (ami->repeat_variables) {
    printf("Repeat Variables:\n");
    for (k = 0; k < kh_end(ami->repeat_variables); ++k)
      if (kh_exist(ami->repeat_variables, k)) {
	printf("\t%s => %s\n", (char *)kh_key(ami->repeat_variables, k), (char *)kh_value(ami->repeat_variables, k));
      }
  }
  if (ami->local_variables) {
    printf("Local Variables:\n");
    for (k = 0; k < kh_end(ami->local_variables); ++k)
      if (kh_exist(ami->local_variables, k)) {
	printf("\t%s => %s\n", (char *)kh_key(ami->local_variables, k), (char *)kh_value(ami->local_variables, k));
      }
  }
}

float ami_get_sleep_cursor(ami_t *ami)
{
  return ami->sleep_cursor;
}
