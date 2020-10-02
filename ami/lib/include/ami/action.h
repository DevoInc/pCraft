#ifndef _ACTION_H_
#define _ACTION_H_

#include "khash.h"

KHASH_MAP_INIT_STR(actionhash, char *)

  struct _ami_action_t {
  khash_t(actionhash) *action_variables;
  khash_t(actionhash) *fields_to_replace;
  char *exec;
};
typedef struct _ami_action_t ami_action_t;

#endif // _ACTION_H_
