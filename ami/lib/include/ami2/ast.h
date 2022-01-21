#ifndef _AMI2_AST_H_
#define _AMI2_AST_H_

#include <ami/ami.h> 
#include "ast-node.h"

#ifdef __cplusplus
extern "C" {
#endif

enum _ami2_state_t {
  AMI2_STATE_VOID,
  AMI2_STATE_COREACTION,
};
typedef enum _ami2_state_t ami2_state_t;
  
int ami2_ast_exec(ami2_t *ami, ami2_action_cb action_cb, void *userdata1, void *userdata2, void *userdata3);

#ifdef __cplusplus
}
#endif

#endif // _AMI2_AST_H_
