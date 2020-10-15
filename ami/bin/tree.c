#include <stdio.h>
#include <stdlib.h>

#include <ami/tree.h>

int main(void)
{
  ami_tree_t *tree;
  ami_tree_t *tree2;
  ami_tree_node_t *mainnode;
  ami_tree_node_t *node1;
  ami_tree_node_t *node2;
  ami_tree_node_t *node3;

  char *p;
  
  tree = ami_tree_new();
  tree2 = ami_tree_new();
  
  mainnode = ami_tree_node_new();
  node1 = ami_tree_node_new();
  node2 = ami_tree_node_new();
  node3 = ami_tree_node_new();

  mainnode->type = AMI_NT_VERSION;
  p = "foo";
  mainnode->strval = p;
  node1->type = AMI_NT_VARNAME;
  p = "bar";
  node1->strval = p;
  
  ami_tree_node_append(mainnode, node1);
  ami_tree_node_append(node1, node2);

  ami_tree_attach_leaf(tree, mainnode);
  node3->type = AMI_NT_TAG;
  ami_tree_attach_leaf(tree2, node3);

  ami_tree_append(tree, tree2);
  
  ami_tree_debug(tree);

  
  ami_tree_close(tree);
  
  return 0;
}
