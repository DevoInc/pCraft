#ifndef _ACTION_H_
#define _ACTION_H_

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

struct _ami_action_t {
  char *name;
  khash_t(actionhash) *action_variables;
  char *replace_field;
  action_kvec_t replace_key;
  action_kvec_t replace_val;
  char *exec;
};
typedef struct _ami_action_t ami_action_t;

ami_action_t *ami_action_new();
void ami_action_close(ami_action_t *action);
void ami_action_copy_variables(ami_t *ami, ami_action_t *action);
void ami_action_debug(ami_t *ami, ami_action_t *action);
char *ami_action_get_name(ami_action_t *action);
char *ami_action_get_exec(ami_action_t *action);
void ami_action_copy_replacements(ami_t *ami, ami_action_t *action);
int ami_action_get_variables_len(ami_action_t *action);
char *ami_action_get_variables_key_at_pos(ami_action_t *action, int pos);
const char *ami_action_get_variable(ami_action_t *action, char *key);
int ami_action_get_replacement_len(ami_action_t *action);
char *ami_action_get_replacement_field(ami_action_t *action);
char *ami_action_get_replacement_key_at_pos(ami_action_t *action, int pos);
char *ami_action_get_replacement_value_at_pos_with_ami(ami_t *ami, ami_action_t *action, int pos);
char *ami_action_get_replacement_value_at_pos(ami_action_t *action, int pos);

#ifdef __cplusplus
}
#endif

#endif // _ACTION_H_
