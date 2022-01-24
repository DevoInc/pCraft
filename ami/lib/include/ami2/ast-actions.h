#ifndef _AMI2_AST_H_
#define _AMI2_AST_H_

#include <ami/ami.h> 
#include "ast-node.h"

#ifdef __cplusplus
extern "C" {
#endif

int ami2_ast_coreaction_handle(ami2_t *ami, ami2_action_cb action_cb, ami2_ast_node_t *node, ami2_ast_node_t *parent, int is_left, int is_right);

#ifdef __cplusplus
}
#endif

#endif // _AMI2_AST_H_
