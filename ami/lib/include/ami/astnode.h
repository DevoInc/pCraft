#ifndef _AMI_ASTNODE_H_
#define _AMI_ASTNODE_H_

#include "uthash.h"

#include "action.h"
#include "tree.h"
#include "variable.h"

#ifdef __cplusplus
extern "C" {
#endif

struct _ami_astnode_t {
  int lineno;
  ami_node_type_t type;

  int function_args_count;
  
  ami_variable_t     *variable;  
  ami_field_action_t *field_action;  
  
  struct _ami_node_t *left;  
  struct _ami_node_t *right;
};
typedef struct _ami_astnode_t ami_astnode_t;

ami_astnode_t *ami_astnode_new(void);  
void ami_astnode_free(ami_astnode_t *astnode);
  
#ifdef __cplusplus
}
#endif

#endif // _AMI_ASTNODE_H_
