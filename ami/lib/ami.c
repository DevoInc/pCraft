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
  ami->skip_repeat = 0;
  ami->ignore_group_sleep = 0;
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
  ami->sleepcursor = kh_init(floathash);

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

  ami->open_files = kh_init(fphash);

  kv_init(ami->varvar_stack);

  ami->membuf = kh_init(charpphash);
  /* ami->fields = kh_init(fieldshash); */

  ami->array_header = kh_init(voidptrhash);
  ami->array = kh_init(voidptrhash);

  ami->total_fields  = kh_init(inthash);
  ami->total_lines   = kh_init(inthash);
  ami->length_fields = kh_init(inthash);

  ami->csvfiles = NULL;

  ami->slice_divider = 0;
  ami->slice_to_run = 0;
  
  return ami;
}

void ami_set_slice(ami_t *ami, int slice_to_run, int slice_divider)
{
  if (slice_to_run > slice_divider) {
    fprintf(stderr, "Cannot run a slice (%d) that is greater than the number of dividers (%d)\n", slice_to_run, slice_divider);
    exit(1);
  }
  ami->slice_divider = slice_divider;
  ami->slice_to_run = slice_to_run;
}

khash_t(inthash) *ami_array_get_header(ami_t *ami, char *arrayname)
{
  khint_t k;

  k = kh_get(varhash, ami->array_header, arrayname);
  int is_missing = (k == kh_end(ami->array_header));
  if (is_missing) return NULL;
  khash_t(inthash) *array = kh_value(ami->array_header, k);
  
  return array;
}

void ami_array_set_header(ami_t *ami, char *arrayname, int column, char *name)
{
  /* khint_t k; */
  /* khint_t k2; */
  int absent;
  khint_t k;
  khash_t(inthash) *header = ami_array_get_header(ami, arrayname);
  if (header) {
    k = kh_put(inthash, header, name, &absent);
    if (absent) {
      kh_key(header, k) = strdup(name);
      kh_value(header, k) = column;
    } else {
      kh_value(header, k) = column;
    }
  } else {
    header = kh_init(inthash);
    k = kh_put(inthash, header, name, &absent);
    kh_key(header, k) = strdup(name);
    kh_value(header, k) = column;    
  }

  k = kh_put(inthash, ami->array_header, arrayname, &absent);
  if (absent) {
    kh_key(ami->array_header, k) = strdup(arrayname);
    kh_value(ami->array_header, k) = column;
  } else {
    kh_value(ami->array_header, k) = column;
  }
  /* k = kh_get(voidptrhash, ami->array_header, arrayname); */
  /* int is_missing = (k == kh_end(ami->array_header)); */
  /* if (is_missing) { */
  /*   header = kh_init(inthash); */
  /*   k2 = kh_put(inthash, header, strdup(name)); */
  /*   kh_value(header, k2) = column; */

  /*   kh_key(ami->array_header, k) = strdup(arrayname); */
  /*   kh_value(ami->array_header, k) = header; */
  /* } else { */
  /*   header = kv_value(ami->array_header, k); */
  /*   k2 = kh_get(voidptrhash, header, name); */
  /*   int header_missing = (k2 == kh_end(header)); */
  /*   if (header_missing) { */
  /*     k2 = kh_put(inthash, header, strdup(name)); */
  /*     kh_value(header, k2) = column; */
  /*   } else { */
  /*     kh_value(header, k2) = column;       */
  /*   } */
  /* } */
}


int ami_array_get_header_pos(ami_t *ami, char *arrayname, char *name)
{
  khint_t k;

  khash_t(inthash) *header = ami_array_get_header(ami, arrayname);
  if (header) {
    k = kh_get(inthash, header, name);
    int is_missing = (k == kh_end(header));
    if (is_missing) return -1;
    int retval = kh_value(header, k);
    return retval;
  } else {
    fprintf(stderr, "Error, no such array '%s'!\n", arrayname);
    return -1;
  }
  
  return -1;
}

void ami_array_set_value(ami_t *ami, char *arrayname, int line, int column, char *value)
{
  ami_kvec_t values_stack;
  kv_init(ami->values_stack); 

}

char *ami_array_get_value(ami_t *ami, char *arrayname, int line, int column)
{

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

int ami_set_variable_string(ami_t *ami, const char *key, char *strval)
{
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->variables) return 1;  

  ami_variable_t *var;
  var = ami_variable_new();
  if (!var) return 1;

  ami_variable_set_string(var, strval);
  
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

int ami_delete_variable(ami_t *ami, const char *key)
{
  khint_t k;

  k = kh_get(varhash, ami->variables, key);
  int is_missing = (k == kh_end(ami->variables));
  if (is_missing) return -1;

  kh_del(varhash, ami->variables, k);
    
  return 0;
}

FILE *ami_get_open_file(ami_t *ami, const char *filename)
{
  khint_t k;

  k = kh_get(fphash, ami->open_files, filename);
  int is_missing = (k == kh_end(ami->open_files));
  if (is_missing) return NULL;
  FILE *fp = kh_value(ami->open_files, k);
  
  return fp;
}

int ami_set_open_file(ami_t *ami, const char *filename, FILE *fp) {
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->open_files) return 1;  

  k = kh_put(fphash, ami->open_files, filename, &absent);
  if (absent) {
    kh_key(ami->open_files, k) = strdup(filename);
    kh_value(ami->open_files, k) = fp;
  } else {
    kh_value(ami->open_files, k) = fp;
    return 1;
  }
  
  return 0;
}

int ami_get_lengthfields(ami_t *ami, const char *bufname)
{
  khint_t k;
  
  k = kh_get(inthash, ami->length_fields, bufname);
  int is_missing = (k == kh_end(ami->length_fields));
  if (is_missing) return -1;
  int retval = kh_value(ami->length_fields, k);
  
  return retval;
}

int ami_set_lengthfields(ami_t *ami, const char *bufname, int length) {
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->length_fields) return 1;  

  k = kh_put(inthash, ami->length_fields, bufname, &absent);
  if (absent) {
    kh_key(ami->length_fields, k) = strdup(bufname);
    kh_value(ami->length_fields, k) = length;
  } else {
    kh_value(ami->length_fields, k) = length;
    return 1;
  }
  
  return 0;
}

int ami_get_totallines(ami_t *ami, const char *bufname)
{
  khint_t k;
  
  k = kh_get(inthash, ami->total_lines, bufname);
  int is_missing = (k == kh_end(ami->total_lines));
  if (is_missing) return -1;
  int retval = kh_value(ami->total_lines, k);
  
  return retval;
}

int ami_set_totallines(ami_t *ami, const char *bufname, int length) {
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->total_lines) return 1;  

  k = kh_put(inthash, ami->total_lines, bufname, &absent);
  if (absent) {
    kh_key(ami->total_lines, k) = strdup(bufname);
    kh_value(ami->total_lines, k) = length;
  } else {
    kh_value(ami->total_lines, k) = length;
    return 1;
  }
  
  return 0;
}

int ami_get_totalfields(ami_t *ami, const char *bufname)
{
  khint_t k;
  
  k = kh_get(inthash, ami->total_fields, bufname);
  int is_missing = (k == kh_end(ami->total_fields));
  if (is_missing) return -1;
  int retval = kh_value(ami->total_fields, k);
  
  return retval;
}

int ami_set_totalfields(ami_t *ami, const char *bufname, int length) {
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->total_fields) return 1;  

  k = kh_put(inthash, ami->total_fields, bufname, &absent);
  if (absent) {
    kh_key(ami->total_fields, k) = strdup(bufname);
    kh_value(ami->total_fields, k) = length;
  } else {
    kh_value(ami->total_fields, k) = length;
    return 1;
  }
  
  return 0;
}

char **ami_get_membuf(ami_t *ami, const char *bufname)
{
  khint_t k;
  
  k = kh_get(charpphash, ami->membuf, bufname);
  int is_missing = (k == kh_end(ami->membuf));
  if (is_missing) return NULL;
  char **retval = kh_value(ami->membuf, k);
  
  return retval;
}

int ami_set_membuf(ami_t *ami, const char *bufname, char **buffer) {
  int absent;
  khint_t k;
  
  if (!ami) return 1;
  if (!ami->membuf) return 1;  

  k = kh_put(charpphash, ami->membuf, bufname, &absent);
  if (absent) {
    kh_key(ami->membuf, k) = strdup(bufname);
    kh_value(ami->membuf, k) = buffer;
  } else {
    kh_value(ami->membuf, k) = buffer;
    return 1;
  }
  
  return 0;
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

void ami_erase_sleep_cursor(ami_t *ami)
{
  khiter_t k;
  char *key;
  
  for (k = 0; k < kh_end(ami->sleepcursor); ++k) {
    if (kh_exist(ami->sleepcursor, k)) {
      key = (char *)kh_key(ami->sleepcursor, k);
      free(key);
      kh_del(floathash, ami->sleepcursor, k);
    }
  }  
}

void ami_erase_open_files(ami_t *ami)
{
  khiter_t k;
  char *key;
  FILE *fp;
  
  for (k = 0; k < kh_end(ami->open_files); ++k) {
    if (kh_exist(ami->open_files, k)) {
      key = (char *)kh_key(ami->open_files, k);
      fp = (FILE *)kh_value(ami->open_files, k);

      free(key);
      if (!fp) return;
      fclose(fp);
      
      kh_del(varhash, ami->open_files, k);
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

  csvfield_t *field_item, *tmp_field, *fields = NULL;
  csvfiles_t *file_item, *tmp_file, *files = NULL;
  
  if (!ami) return;
  if (ami->file) free(ami->file);
  
  kv_destroy(ami->references);
  kv_destroy(ami->values_stack);
  kv_destroy(ami->varvar_stack);
  /* kv_destroy(ami->membuf); */
  /* kv_destroy(ami->array_header); */
  /* kv_destroy(ami->array); */
  
  ami_erase_variables(ami);
  ami_erase_sleep_cursor(ami);
  ami_erase_open_files(ami);
  
  if (ami->root_node) {
    ami_node_close(ami->root_node, 0);
  }

  kh_destroy(varhash, ami->variables);
  kh_destroy(varhash, ami->open_files);

  HASH_ITER(hh, ami->csvfiles, file_item, tmp_file) {
    HASH_ITER(hh, file_item->csvfields, field_item, tmp_field) {
      free(field_item->name);
      HASH_DEL(file_item->csvfields, field_item);
      free(field_item);
    }
    free(file_item->filename);
    HASH_DEL(ami->csvfiles, file_item);
    free(file_item);
  }
  
  /* kv_destroy(ami->total_fields); */
  /* kv_destroy(ami->total_lines); */
  /* kv_destroy(ami->length_fields); */
  
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
    ami_node_create(ami, &ami->current_node, lineno, type, strval, intval, fval, 0);
  } else {
    ami_node_create(ami, &ami->root_node, lineno, type, strval, intval, fval, 0);
    ami->current_node = NULL;
  }
}

void ami_append_repeat(ami_t *ami, int lineno, ami_node_type_t type, char *strval, int intval, float fval, int is_verbatim_string)
{
  if (ami->current_node) {
    ami->current_node = ami_node_create_right(ami, &ami->current_node, lineno, type, strval, intval, fval, 0);
  } else {
    ami->current_node = ami_node_create_right(ami, &ami->root_node, lineno, type, strval, intval, fval, 0);
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
      fprintf(stderr, "Cannot get value for variable %s at %s:%d\n", var_value, node->filename, node->lineno);
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
  if (!retvar) {
    fprintf(stderr, "[%s:%d] Cannot get variable %s\n", ami->file, ami->current_line, var_value);
    return -1;
  }
  
  return retvar->ival;
}


float ami_get_sleep_cursor(ami_t *ami)
{
  return ami->sleep_cursor;
}

/* If the variable already exists, return 1. 0 otherwise. */
int ami_append_sleep_cursor(ami_t *ami, const char *group, float cursor)
{
  int absent;
  khint_t k;

  if (!ami) return 1;
  if (!ami->sleepcursor) return 1;
  
  k = kh_put(floathash, ami->sleepcursor, group, &absent);
  if (absent) {
    kh_key(ami->sleepcursor, k) = strdup(group);
    kh_value(ami->sleepcursor, k) = cursor;
  } else {
    float stored_val = ami_get_new_sleep_cursor(ami, group);
    float sleep = stored_val + cursor;

    kh_value(ami->sleepcursor, k) = sleep;
    
    return 1;
  }
  
  return 0;
}

float ami_get_new_sleep_cursor(ami_t *ami, const char *group)
{
  khint_t k;

  k = kh_get(floathash, ami->sleepcursor, group);
  int is_missing = (k == kh_end(ami->sleepcursor));
  if (is_missing) return 0;
  float sleepcursor = kh_value(ami->sleepcursor, k);
  
  return sleepcursor;
}

int ami_add_csvfield(ami_t *ami, const char *csvfile, const char *fieldname, int fieldpos)
{
  csvfield_t *field_item, *tmp_field, *fields = NULL;
  csvfiles_t *file_item, *tmp_file, *files = NULL;

  HASH_FIND_STR(ami->csvfiles, csvfile, file_item);
  if (file_item) {
    /* printf("File already exists\n", csvfile); */
    field_item = malloc(sizeof(csvfield_t));
    if (!field_item) {
      fprintf(stderr, "Could not allocate field!\n");
      return -1;
    }
    field_item->pos = fieldpos;
    field_item->name = strdup(fieldname);
    /* printf("ADDING Field %s\n", fieldname); */
    HASH_ADD_KEYPTR(hh, file_item->csvfields, field_item->name, strlen(field_item->name), field_item);
  } else {
    /* printf("Files %s does not exists\n", csvfile); */
    field_item = malloc(sizeof(csvfield_t));
    if (!field_item) {
      fprintf(stderr, "Could not allocate field!\n");
      return -1;
    }
    field_item->pos = fieldpos;
    field_item->name = strdup(fieldname);
    /* printf("ADDING Field %s\n", fieldname); */
    HASH_ADD_KEYPTR(hh, fields, field_item->name, strlen(field_item->name), field_item);

    file_item = malloc(sizeof(csvfiles_t));
    if (!file_item) {
      fprintf(stderr, "Could not allocate cvs file!\n");
      return -1;
    }
    file_item->filename = strdup(csvfile);
    file_item->csvfields = fields;
    HASH_ADD_KEYPTR(hh, ami->csvfiles, file_item->filename, strlen(file_item->filename), file_item);

    /* HASH_FIND_STR(ami->csvfiles, csvfile, file_item); */
    /* if (file_item) { */
    /*   HASH_ITER(hh, ami->csvfiles, tmp_file, file_item) { */
    /* 	printf("file name :%s\n", tmp_file->filename); */
    /* 	  HASH_ITER(hh, tmp_file->csvfields, tmp_field, field_item) { */
    /* 	    printf("field name:%s and pos:%d\n", tmp_field->name, tmp_field->pos); */
    /* 	  } */
    /*   } */
    /* } */
  
    
  }
  
  return 0;
}

int ami_get_csvfield_pos(ami_t *ami, const char *csvfile, const char *fieldname)
{
  csvfield_t *fld, *tmpfld, *field = NULL;
  csvfiles_t *f, *tmpf, *file = NULL;

  HASH_FIND_STR(ami->csvfiles, csvfile, f);
  if (f) {
    HASH_FIND_STR(f->csvfields, fieldname, fld);
    if (fld) {
      /* printf("Found field!\n"); */
      return fld->pos;
    } else {
      fprintf(stderr, "No such field %s\n", fieldname);
      return -1;
    }
  } else {
    fprintf(stderr, "No such file %s to get csv field from\n", csvfile);
    return -1;
  }
  
  return -1;
}


