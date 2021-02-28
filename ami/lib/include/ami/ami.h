#ifndef _AMI_H_
#define _AMI_H_

#ifndef _GNU_SOURCE
  #define _GNU_SOURCE
#endif
#include <search.h>

#include "action.h"
#include "tree.h"
#include "variable.h"

#include "khash.h"
#include "kvec.h"


#ifdef __cplusplus
extern "C" {
#endif

#define MAX_VARIABLES 1
#define MAX_NESTED_REPEAT 16
  
KHASH_MAP_INIT_STR(strhash, char *)
KHASH_MAP_INIT_STR(floathash, float)

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
};
typedef struct _ami_t ami_t;

typedef int (*foreach_action_cb)(ami_t *ami, ami_action_t *action, void *user_data);

ami_t *ami_new(void);
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
int ami_replace_variable(ami_t *ami, const char *key, ami_variable_t *var);
ami_variable_t *ami_get_variable(ami_t *ami, const char *key);
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
  
#ifdef __cplusplus
}
#endif

#endif // _AMI_H_
