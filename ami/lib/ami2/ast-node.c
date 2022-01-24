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

ami2_ast_node_t *ami2_ast_node_string_new(unsigned int lineno, ami2_node_type_t node_type, char *string)
{
  ami2_ast_node_t *node;

  node = ami2_ast_node_new(node_type);
  node->lineno = lineno;
  node->variable = ami_variable_new_string(string);
  
  return node;
}

ami2_ast_node_t *ami2_ast_node_integer_new(unsigned int lineno, ami2_node_type_t node_type, int number)
{
  ami2_ast_node_t *node;
  node = ami2_ast_node_new(node_type);
  node->lineno = lineno;
  node->variable = ami_variable_new_int(number);

  return node;
}

ami2_ast_node_t *ami2_ast_node_float_new(unsigned int lineno, ami2_node_type_t node_type, float number)
{
  ami2_ast_node_t *node;
  node = ami2_ast_node_new(node_type);
  node->lineno = lineno;
  node->variable = ami_variable_new_float(number);

  return node;
}

ami2_ast_node_t *ami2_ast_node_lr_new(unsigned int lineno, ami2_node_type_t node_type, ami2_ast_node_t *left, ami2_ast_node_t *right)
{
  ami2_ast_node_t *node;
  node = ami2_ast_node_new(node_type);
  node->lineno = lineno;
  node->left = left;
  node->right = right;

  return node;
}

ami2_ast_node_t *ami2_ast_node_lr_with_variable_new(unsigned int lineno, ami2_node_type_t node_type, ami2_ast_node_t *var, ami2_ast_node_t *left, ami2_ast_node_t *right)
{
  ami2_ast_node_t *node;
  node = ami2_ast_node_new(node_type);
  node->lineno = lineno;
  node->variable = var->variable;
  node->left = left;
  node->right = right;

  return node;
}

void ami2_ast_node_free(ami2_ast_node_t *node)
{
  free(node);
}

int ami2_ast_single_node_debug(ami2_ast_node_t *node)
{
  if (!node) {
    fprintf(stderr, "Node is NULL!\n");
    return -1;
  }

  printf("Node Type:%s\n", ami2_node_names[node->type]);
  printf("Node lineno:%ld\n", node->lineno);
  printf("Node variable:\n");
  ami_variable_debug(node->variable);
  printf("Node repeat count:%d\n", node->repeat_count);
  printf("\n");

  return 0;
}

void ami2_ast_node_debug(ami2_ast_node_t *node)
{
  ami2_ast_single_node_debug(node);
  printf("Left:\n=====\n");
  ami2_ast_single_node_debug(node->left);
  printf("Right:\n=======\n");
  ami2_ast_single_node_debug(node->right);
}

ami2_ast_node_t *ami2_ast_node_append_right(ami2_ast_node_t *dstnode, ami2_ast_node_t *srcnode)
{
  ami2_ast_node_t *ptr;

  if (!dstnode) {
    return ami2_ast_node_lr_new(srcnode->lineno, AMI2_NODE_LIST, srcnode, NULL);
  }

  ptr = dstnode;

  while (ptr->right) {
    ptr = ptr->right;
  }

  ptr->right = ami2_ast_node_lr_new(srcnode->lineno, AMI2_NODE_LIST, srcnode, NULL);

  return ptr;
}

ami2_ast_node_t *ami2_ast_node_append_left(ami2_ast_node_t *dstnode, ami2_ast_node_t *srcnode)
{
  ami2_ast_node_t *ptr;

  if (!dstnode) {
    return ami2_ast_node_lr_new(srcnode->lineno, AMI2_NODE_LIST, srcnode, NULL);
  }

  ptr = dstnode;

  while (ptr->left) {
    ptr = ptr->left;
  }

  ptr->left = ami2_ast_node_lr_new(srcnode->lineno, AMI2_NODE_LIST, NULL, srcnode);

  return ptr;
}

