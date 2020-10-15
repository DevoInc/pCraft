#ifndef _AMI_AST_H_
#define _AMI_AST_H_

#include <ami/ami.h>
#include <ami/action.h>

#ifdef __cplusplus
extern "C" {
#endif

int ami_ast_walk_actions(ami_t *ami);
  
#ifdef __cplusplus
}
#endif


#endif // _AMI_AST_H_
