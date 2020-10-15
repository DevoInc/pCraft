#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <ami/tree.h>

ami_node_t *ami_node_new(void)
{
  ami_node_t *node;
  node = (ami_node_t *)malloc(sizeof(ami_node_t));
  if (!node) {
    fprintf(stderr, "Cannot allocate ami_node_t!\n");
    return NULL;
  }
  
  node->strval = NULL;
  node->intval = 0;
  node->left = NULL; // Points to the previous node
  node->right = NULL; 
  node->next = NULL;
  
  return node;
}

void ami_node_debug(ami_node_t *node)
{
  ami_node_t *n;

  printf("Calling %s\n", __FUNCTION__);

  if (!node) {
    fprintf(stderr, "Node is NULL!\n");
  }
  
  for (n = node; n; n = n->next) {
    printf("---------\n");
    printf("\ttype:%s\n", ami_node_names[n->type]);
    if (n->strval) {
      printf("\tstrval:%s\n", n->strval);
    }
    printf("\tintval:%d\n", n->intval);      

    if (n->right) {
      for (ami_node_t *r = n->right; r; r = r->right) {
	printf("\tNode:\n");
	printf("\t\ttype:%s\n", ami_node_names[r->type]);
	if (r->strval) {
	  printf("\t\tstrval:%s\n", r->strval);
	}
	printf("\t\tintval:%d\n", r->intval);
      }
    }
  }
}

ami_tree_t *ami_tree_new(void)
{
  ami_tree_t *tree;
  tree = (ami_tree_t *)malloc(sizeof(ami_tree_t));
  if (!tree) {
    fprintf(stderr, "Cannot allocate ami_tree_t!\n");
    return NULL;
  }
  tree->root = tree;
  tree->leaves = NULL;
  tree->next = NULL;

  return tree;
}

void ami_tree_close(ami_tree_t *tree)
{
  ami_tree_t *t;
  for (t = tree; t; t = t->next) {
    ami_tree_node_close(tree->leaves);
    free(t);
  }
}

ami_tree_node_t *ami_tree_node_new(void)
{
  ami_tree_node_t *node;
  node = (ami_tree_node_t *)malloc(sizeof(ami_tree_node_t));
  if (!node) {
    fprintf(stderr, "Cannot allocate ami_tree_node_t!\n");
    return NULL;
  }
  node->type = AMI_NT_NONE;
  node->size = 0;
  node->strval = NULL;
  node->intval = 0;
  node->next = NULL;

  return node;
}

void ami_tree_node_close(ami_tree_node_t *node)
{
  ami_tree_node_t *n;
  for (n = node; n; n = n->next) {
    free(n);
  }
}

ami_tree_node_t *ami_tree_node_copy(ami_tree_node_t *node)
{
  ami_tree_node_t *n;
  n->type = node->type;
  n->size = node->size;
  if (node->strval) {
    n->strval = strdup(node->strval);
  }
  n->intval = node->intval;
  n->next = node->next;

  return n;
}

int ami_tree_node_append(ami_tree_node_t *dstnode, ami_tree_node_t *srcnode)
{
  dstnode->next = srcnode;
  return 0;
}

int ami_tree_node_debug(ami_tree_node_t *node)
{
  ami_tree_node_t *n;

  n = node;
  while (n) {
    printf("Node\n");
    printf("====\n");
    printf("\tType:%s\n", ami_node_names[n->type]);
    printf("\tSize:%d\n", n->size);
    if (n->strval) {
    printf("\tstrval:%s\n", n->strval);
    }
    if (n->intval) {
    printf("\tintval:%d\n", n->intval);
    }
    n = n->next;
  }
  return 0;
}

int ami_tree_debug(ami_tree_t *tree)
{
  ami_tree_t *t;

  for (t = tree; t; t = t->next) {
    printf("Tree\n");
    printf("====\n");
    ami_tree_node_debug(t->leaves);
  }
  return 0;
}

int ami_tree_attach_leaf(ami_tree_t *tree, ami_tree_node_t *leaf)
{
  tree->leaves = leaf;
  return 0;
}

int ami_tree_copy_leaves(ami_tree_t *tree, ami_tree_node_t *leaves)
{
  ami_tree_node_t *n, *newleaves;

  newleaves = ami_tree_node_new();
  
  for (n = leaves; n; n = n->next) {
    ami_tree_node_t *leaf = ami_tree_node_new();
    leaf = ami_tree_node_copy(n);
    ami_tree_node_append(newleaves, leaf);
  }

  ami_tree_attach_leaf(tree, newleaves);
  
  /* tree->leaves = leaf; */
  return 0;
}


int ami_tree_append(ami_tree_t *dsttree, ami_tree_t *srctree)
{
  ami_tree_t *t;

  srctree->root = dsttree;
  for (t = dsttree; t; t = t->next) {
    if (!t->next) {
      t->next = srctree;
      break;
    }
  }
  
  return 0;
}

void ami_tree_append_int_no_leaves(ami_tree_t *tree, ami_node_type_t type, int val)
{
    ami_tree_t *t = ami_tree_new();
    ami_tree_node_t *n = ami_tree_node_new();
    n->type = type;
    n->intval = val;
    ami_tree_attach_leaf(t, n);
    ami_tree_append(tree, t);
}

void ami_tree_append_str_no_leaves(ami_tree_t *tree, ami_node_type_t type, char *val)
{
    ami_tree_t *t = ami_tree_new();
    ami_tree_node_t *n = ami_tree_node_new();
    n->type = type;
    n->strval = strdup(val);
    ami_tree_attach_leaf(t, n);
    ami_tree_append(tree, t);
}

ami_node_t *ami_node_prepend(ami_node_t *nodedst, ami_node_t *nodesrc)
{
  if (!nodedst) {
    nodedst = nodesrc;
  } else {
    nodesrc->next = nodedst;
    nodedst = nodesrc;
  }
  return nodedst;
}

ami_node_t *ami_node_append(ami_node_t *nodedst, ami_node_t *nodesrc)
{
  ami_node_t *n = nodedst;
  
  if (!nodedst) {
    nodedst = nodesrc;
    /* ami_node_debug(nodedst);     */
    return nodedst;
  }
  
  while(n->next) {
    n = n->next;
  }
  n->next = nodesrc;

  return nodedst;
}

ami_node_t *ami_node_append_right(ami_node_t *nodedst, ami_node_t *nodesrc)
{
  ami_node_t *n = nodedst;
  
  if (!nodedst) {
    nodedst = nodesrc;
    return nodedst;
  }
  
  while(n->next) {
    n = n->next;
  }

  while(n->right) {
    n = n->right;
  }  
  n->right = nodesrc;

  return nodedst;
}


void ami_node_create(ami_node_t **root, ami_node_type_t type, char *strval, int intval)
{
  ami_node_t *node = ami_node_new();

  node->type = type;
  if (strval) {
    node->strval = strdup(strval);
  }
  node->intval = intval;

  *root = ami_node_append(*root, node);  
}

void ami_node_create_right(ami_node_t **root, ami_node_type_t type, char *strval, int intval)
{
  ami_node_t *node = ami_node_new();

  node->type = type;
  if (strval) {
    node->strval = strdup(strval);
  }
  node->intval = intval;

  *root = ami_node_append_right(*root, node);  
}
