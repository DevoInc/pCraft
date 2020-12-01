#ifndef _AMI_H_
#define _AMI_H_

#ifndef _GNU_SOURCE
  #define _GNU_SOURCE
#endif
#include <search.h>

#include "action.h"
#include "tree.h"

#include "khash.h"
#include "kvec.h"


#ifdef __cplusplus
extern "C" {
#endif


#define MAX_VARIABLES 1

KHASH_MAP_INIT_STR(strhash, char *)

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

struct _ami_replace_t {
  char *field;
  char *from;
  char *to;
};
typedef struct _ami_replace_t ami_replace_t;

typedef void (*print_message_cb)(char *message);
typedef void (*sleep_cb)(int msec);
typedef void (*ami_action_cb)(ami_action_t *action, void *userdata);

struct _ami_t {
  const char *file;
  ami_error_t error;
  int _action_block_id;
  int _repeat_block_id;
  int _opened_sections;
  int _is_verbatim_string;
  int debug;
  int version;
  int revision;
  char *author;
  char *shortdesc;
  char *description;
  ami_kvec_t references;
  ami_kvec_t tags;
  khash_t(strhash) *global_variables;
  khash_t(strhash) *repeat_variables;
  khash_t(strhash) *local_variables;
  sleep_cb sleepcb;
  print_message_cb printmessagecb;
  ami_action_cb action_cb;
  void *action_cb_userdata;
  size_t current_line;
  ami_node_t *root_node; // root
  ami_node_t *current_node;
  int in_repeat;
  int in_action;
  ami_kvec_t values_stack;
  int replace_count;
  float sleep_cursor; // How much sleep we need to add to our action. Starts at 0, then adds every sleep we need.
};
typedef struct _ami_t ami_t;

typedef int (*foreach_action_cb)(ami_t *ami, ami_action_t *action, void *user_data);

ami_t *ami_new(void);
int ami_parse_file(ami_t *ami, const char *file);
void ami_set_message_callback(ami_t *ami, print_message_cb message_cb);
void ami_set_sleep_callback(ami_t *ami, sleep_cb sleep_cb);
int ami_loop(ami_t *ami, foreach_action_cb action_cb, void *user_data);
void ami_close(ami_t *ami);
char *ami_error_to_string(ami_t *ami);
void ami_debug(ami_t *ami);
int ami_set_global_variable(ami_t *ami, char *key, char *val);
const char *ami_get_global_variable(ami_t *ami, char *key);
int ami_set_local_variable(ami_t *ami, char *key, char *val);
const char *ami_get_local_variable(ami_t *ami, char *key);
int ami_set_repeat_variable(ami_t *ami, char *key, char *val);
const char *ami_get_repeat_variable(ami_t *ami, char *key);
void ami_erase_global_variables(ami_t *ami);
void ami_erase_local_variables(ami_t *ami);
void ami_erase_repeat_variables(ami_t *ami);
void ami_set_action_callback(ami_t *ami, ami_action_cb action_cb, void *userdata);
void ami_ast_tree_debug(ami_t *ami);
void ami_append_item(ami_t *ami, ami_node_type_t type, char *strval, int intval, float fval, int is_verbatim_string);
char *ami_get_variable(ami_t *ami, char *key);
void ami_print_all_variables(ami_t *ami);
float ami_get_sleep_cursor(ami_t *ami);

#ifdef __cplusplus
}
#endif

#endif // _AMI_H_
