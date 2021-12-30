#include <stdio.h>
#include <stdlib.h>

#include <ami2/ast-node.h>

ami2_ast_node_t *ami2_ast_node_new(ami2_node_type_t node_type)
{
  ami2_ast_node_t *node;

  node = (ami2_ast_node_t *)malloc(sizeof(ami2_ast_node_t));
  if (!node) {
    fprintf(stderr, "Cannot allocate ami2_ast_node_t!\n");
    return NULL;
  }
  node->type = node_type;
  node->operation = AMI2_OP_NONE;
  node->lineno = 0;
  node->variable = NULL;
  node->repeat_count = 0;
  node->left = NULL;
  node->right = NULL;

  return node;
}

void ami2_ast_node_free(ami2_ast_node_t *node)
{
  free(node);
}

void ami2_ast_node_debug(ami2_ast_node_t *node)
{
  if (!node) {
    fprintf(stderr, "Node is NULL!\n");
    return;
  }

  printf("type:%s\n", ami2_node_names[node->type]);
}

int ami2_ast_node_append_right(ami2_ast_node_t *dstnode, ami2_ast_node_t *srcnode)
{
  dstnode->right = srcnode;
}

int ami2_ast_node_append_left(ami2_ast_node_t *dstnode, ami2_ast_node_t *srcnode)
{
  dstnode->left = srcnode;
}

