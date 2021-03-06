#ifndef _ACTION_H_
#define _ACTION_H_

#include <stdio.h>

#include "variable.h"

#include "khash.h"
#include "kvec.h"

#ifdef __cplusplus
extern "C" {
#endif


KHASH_MAP_INIT_STR(actionhash, char *)

typedef struct _ami_t ami_t;
  
struct _action_kvec_t {
  size_t n;
  size_t m;
  char **a;
};
typedef struct _action_kvec_t action_kvec_t;

struct _ami_field_action_t {
  char *field;
  char *action;
  char *left;
  char *right;
  struct _ami_field_action_t *next;
};
typedef struct _ami_field_action_t ami_field_action_t;
  
struct _ami_action_t {
  char *filename;
  char *name;
  khash_t(varhash) *variables;
  ami_field_action_t *field_actions;
  char *replace_field;
  action_kvec_t replace_key;
  action_kvec_t replace_val;
  char *exec;
  float sleep_cursor;
  size_t repeat_index;
  float sleep;
};
typedef struct _ami_action_t ami_action_t;

ami_action_t *ami_action_new();
void ami_action_close(ami_action_t *action);
void ami_action_debug(ami_t *ami, ami_action_t *action);
char *ami_action_get_name(ami_action_t *action);
char *ami_action_get_exec(ami_action_t *action);
void ami_action_copy_replacements(ami_t *ami, ami_action_t *action);
/* int ami_action_get_variables_len(ami_action_t *action); */
/* char *ami_action_get_variables_key_at_pos(ami_action_t *action, int pos); */
ami_variable_t *ami_action_get_variable(ami_action_t *action, char *key);
int ami_action_get_replacement_len(ami_action_t *action);
char *ami_action_get_replacement_field(ami_action_t *action);
char *ami_action_get_replacement_key_at_pos(ami_action_t *action, int pos);
char *ami_action_get_replacement_value_at_pos_with_ami(ami_t *ami, ami_action_t *action, int pos);
char *ami_action_get_replacement_value_at_pos(ami_action_t *action, int pos);
ami_field_action_t *ami_field_action_new(void);
ami_field_action_t *ami_field_action_append(ami_field_action_t *dst, ami_field_action_t *src);
int ami_action_set_variable(ami_action_t *action, const char *key, ami_variable_t *var);
ami_variable_t *ami_action_get_newvariable(ami_action_t *action, const char *key);  
void ami_field_action_debug(ami_action_t *action);
  
#ifdef __cplusplus
}
#endif

#endif // _ACTION_H_
