#ifndef _ACTION_H_
#define _ACTION_H_

#include "khash.h"
#include "kvec.h"

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

#endif // _ACTION_H_
