#include <stdio.h>
#include <stdlib.h>

#include <ami/astnode.h>

ami_astnode_t *ami_astnode_new(void)
{
  ami_astnode_t *astnode;

  astnode = (ami_astnode_t *)malloc(sizeof(ami_astnode_t));
  if (!astnode) {
    fprintf(stderr, "Cannot allocate ami_astnode_t!\n");
    return NULL;
  }

  astnode->lineno = 0;
  astnode->type = AMI_NT_NONE;
  astnode->function_args_count = 0;
  astnode->variable = NULL;
  astnode->field_action = NULL;

  astnode->left = NULL;
  astnode->right = NULL;
  
  return astnode;
}

void ami_astnode_free(ami_astnode_t *astnode)
{
  free(astnode);
}

