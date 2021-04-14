#ifndef _AMI_H_
#define _AMI_H_

#ifndef _GNU_SOURCE
  #define _GNU_SOURCE
#endif
#include <search.h>

#include "action.h"
#include "tree.h"
#include "variable.h"
#include "csvread.h"

#include "khash.h"
#include "kvec.h"

#include "uthash.h"

#ifdef __cplusplus
extern "C" {
#endif

struct _csvfield_t {
  const char *name;
  int pos;
  UT_hash_handle hh;
};
typedef struct _csvfield_t csvfield_t;

struct _csvfiles_t {
  const char *filename;
  csvfield_t *csvfields;
  UT_hash_handle hh;  
};
typedef struct _csvfiles_t csvfiles_t;
  
  
#define MAX_VARIABLES 1
#define MAX_NESTED_REPEAT 16
  
KHASH_MAP_INIT_STR(strhash, char *)
KHASH_MAP_INIT_STR(floathash, float)
KHASH_MAP_INIT_STR(fphash, FILE *)
KHASH_MAP_INIT_STR(voidptrhash, void *)
KHASH_MAP_INIT_STR(inthash, int)
KHASH_MAP_INIT_STR(charpphash, char **)
/* KHASH_MAP_INIT_STR(fieldshash, inthash) */
  
struct _ami_kvec_t {
  size_t n;
  size_t m;
  char **a;
};
typedef struct _ami_kvec_t ami_kvec_t;

  
enum _ami_error_t {
	NO_ERROR,
        NO_VERSION,
};
typedef enum _ami_error_t ami_error_t;

typedef void (*print_message_cb)(char *message);
typedef void (*sleep_cb)(int msec);
typedef void (*ami_action_cb)(ami_action_t *action, void *userdata1, void *userdata2, void *userdata3);

/* TODO: Cleanup this structure. */
struct _ami_t {
  const char *file;
  ami_error_t error;
  int _action_block_id;
  int _repeat_block_id;
  int _opened_sections;
  int _is_verbatim_string;
  int skip_repeat;
  int ignore_group_sleep;
  int debug;
  int version;
  int start_time;
  int revision;
  char *author;
  char *shortdesc;
  char *description;
  ami_kvec_t references;
  ami_kvec_t tags;
  khash_t(varhash) *variables;
  sleep_cb sleepcb;
  print_message_cb printmessagecb;
  ami_action_cb action_cb;
  void *action_cb_userdata1;
  void *action_cb_userdata2;
  void *action_cb_userdata3;
  size_t current_line;
  ami_node_t *root_node; // root
  ami_node_t *current_node;
  int in_repeat;
  int in_action;
  ami_kvec_t values_stack;
  int replace_count;
  khash_t(floathash) *sleepcursor; // The new sleep cursor. Shall remove the "float sleep_cursor" once this is done.
  float sleep_cursor; // How much sleep we need to add to our action. Starts at 0, then adds every sleep we need.
  int arguments_count;
  int repeat_indices[MAX_NESTED_REPEAT];
  int repeat_indices_cursor[MAX_NESTED_REPEAT];  
  int current_repeat_block;
  size_t global_counter;
  khash_t(fphash) *open_files;
  ami_kvec_t varvar_stack;
  khash_t(charpphash) *membuf;
  /* khash_t(fieldshash) *fields; */
  
  khash_t(inthash) *total_fields;
  khash_t(inthash) *total_lines;
  khash_t(inthash) *length_fields;
  khash_t(voidptrhash) *array_header;
  khash_t(voidptrhash) *array;

  csvfiles_t *csvfiles;

  int slice_divider;
  int slice_to_run;
};
typedef struct _ami_t ami_t;

typedef int (*foreach_action_cb)(ami_t *ami, ami_action_t *action, void *user_data);

ami_t *ami_new(void);
void ami_set_slice(ami_t *ami, int slice_to_run, int slice_divider);
void ami_global_counter_incr(ami_t *ami);  
int ami_parse_file(ami_t *ami, const char *file);
void ami_set_message_callback(ami_t *ami, print_message_cb message_cb);
void ami_set_sleep_callback(ami_t *ami, sleep_cb sleep_cb);
int ami_loop(ami_t *ami, foreach_action_cb action_cb, void *user_data);
void ami_close(ami_t *ami);
char *ami_error_to_string(ami_t *ami);
void ami_debug(ami_t *ami);
int ami_erase_variable(ami_t *ami, char *varkey);  
int ami_variable_exists(ami_t *ami, const char *key);
int ami_set_variable(ami_t *ami, const char *key, ami_variable_t *var);
int ami_set_variable_string(ami_t *ami, const char *key, char *strval);
int ami_replace_variable(ami_t *ami, const char *key, ami_variable_t *var);
ami_variable_t *ami_get_variable(ami_t *ami, const char *key);
int ami_delete_variable(ami_t *ami, const char *key);
ami_variable_t *ami_fetch_variable(ami_t *ami, const char *key);  
void ami_set_action_callback(ami_t *ami, ami_action_cb action_cb, void *userdata1, void *userdata2, void *userdata3);
void ami_ast_tree_debug(ami_t *ami);
void ami_append_item(ami_t *ami, int lineno, ami_node_type_t type, char *strval, int intval, float fval, int is_verbatim_string);
void ami_append_repeat(ami_t *ami, int lineno, ami_node_type_t type, char *strval, int intval, float fval, int is_verbatim_string);
float ami_get_sleep_cursor(ami_t *ami);
char *ami_get_nested_variable_as_str(ami_t *ami, ami_node_t *node, char *var_value);
int ami_get_nested_variable_as_int(ami_t *ami, char *var_value);
int ami_append_sleep_cursor(ami_t *ami, const char *group, float cursor);
float ami_get_new_sleep_cursor(ami_t *ami, const char *group);
FILE *ami_get_open_file(ami_t *ami, const char *filename);
int ami_set_open_file(ami_t *ami, const char *filename, FILE *fp);
int ami_get_lengthfields(ami_t *ami, const char *bufname);
int ami_set_lengthfields(ami_t *ami, const char *bufname, int length);
int ami_get_totallines(ami_t *ami, const char *bufname);
int ami_set_totallines(ami_t *ami, const char *bufname, int length);
int ami_get_totalfields(ami_t *ami, const char *bufname);
int ami_set_totalfields(ami_t *ami, const char *bufname, int length);
char **ami_get_membuf(ami_t *ami, const char *bufname);
int ami_set_membuf(ami_t *ami, const char *bufname, char **buffer);
void ami_array_set_header(ami_t *ami, char *arrayname, int column, char *name);
int ami_array_get_header_pos(ami_t *ami, char *arrayname, char *name);
void ami_array_set_value(ami_t *ami, char *arrayname, int line, int column, char *value);
char *ami_array_get_value(ami_t *ami, char *arrayname, int line, int column);

int ami_add_csvfield(ami_t *ami, const char *csvfile, const char *fieldname, int fieldpos);  
int ami_get_csvfield_pos(ami_t *ami, const char *csvfile, const char *fieldname);
  
#ifdef __cplusplus
}
#endif

#endif // _AMI_H_
