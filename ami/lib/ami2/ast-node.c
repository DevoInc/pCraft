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

ami2_ast_node_t *ami2_ast_node_string_new(ami2_node_type_t node_type, char *string)
{
  ami2_ast_node_t *node;

  node = ami2_ast_node_new(node_type);
  node->variable = ami_variable_new_string(string);
  
  return node;
}

ami2_ast_node_t *ami2_ast_node_integer_new(ami2_node_type_t node_type, int number)
{
  ami2_ast_node_t *node;
  node = ami2_ast_node_new(node_type);
  node->variable = ami_variable_new_int(number);

  return node;
}

ami2_ast_node_t *ami2_ast_node_float_new(ami2_node_type_t node_type, float number)
{
  ami2_ast_node_t *node;
  node = ami2_ast_node_new(node_type);
  node->variable = ami_variable_new_float(number);

  return node;
}

ami2_ast_node_t *ami2_ast_node_lr_new(ami2_node_type_t node_type, ami2_ast_node_t *left, ami2_ast_node_t *right)
{
  ami2_ast_node_t *node;
  node = ami2_ast_node_new(node_type);
  node->left = left;
  node->right = right;

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

ami2_ast_node_t *ami2_ast_node_append_right(ami2_ast_node_t *dstnode, ami2_ast_node_t *srcnode)
{
  ami2_ast_node_t *ptr;

  if (!dstnode) {
    return ami2_ast_node_lr_new(AMI2_NODE_LIST, srcnode, NULL);
  }

  ptr = dstnode;

  while (ptr->right) {
    ptr = ptr->right;
  }

  ptr->right = ami2_ast_node_lr_new(AMI2_NODE_LIST, srcnode, NULL);

  return ptr;
}

ami2_ast_node_t *ami2_ast_node_append_left(ami2_ast_node_t *dstnode, ami2_ast_node_t *srcnode)
{
  ami2_ast_node_t *ptr;

  if (!dstnode) {
    return ami2_ast_node_lr_new(AMI2_NODE_LIST, srcnode, NULL);
  }

  ptr = dstnode;

  while (ptr->left) {
    ptr = ptr->left;
  }

  ptr->left = ami2_ast_node_lr_new(AMI2_NODE_LIST, NULL, srcnode);

  return ptr;
}

