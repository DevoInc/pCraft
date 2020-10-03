#ifndef _FLOW_H_
#define _FLOW_H_

#include "khash.h"

KHASH_MAP_INIT_STR(flowhash, char *)

struct _ami_strvec_t {
  size_t n;
  size_t m;
  char **a;
};
typedef struct _ami_strvec_t ami_strvec_t;

enum _ami_flow_type_t {
       AMI_FT_NONE,
       AMI_FT_SETVAR,
       AMI_FT_ACTION,
       AMI_FT_RUNFUNC,
       AMI_FT_REPLACE,
};
typedef enum _ami_flow_type_t ami_flow_type_t;
  
struct _ami_flow_t {
  ami_flow_type_t type;
  char *func_name;
  ami_strvec_t func_arguments;
  int found_col_to_replace;
  size_t col_to_replace;
  char *replace_field;
  char *var_name;
  char *var_value;
  khash_t(flowhash) *variables;
  khash_t(flowhash) *fields_to_replace;
  char *exec;
};
typedef struct _ami_flow_t ami_flow_t;

struct _ami_flow_kvec_t {
  size_t n;
  size_t m;
  ami_flow_t **a;
};
typedef struct _ami_flow_kvec_t ami_flow_kvec_t;

ami_flow_t *ami_flow_new();
void ami_flow_close(ami_flow_t *flow);
char *ami_flow_type_as_string(ami_flow_t *flow);
void ami_flow_debug(ami_flow_t *flow);
void ami_flow_function_replace_argument_for_repeat_as(ami_flow_t *flow, char *repeat_index_as, size_t current_index);

#endif // _FLOW_H_
