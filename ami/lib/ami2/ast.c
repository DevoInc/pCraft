#include <ami2/ami2.h>
#include <ami2/ast.h>
#include <ami2/errors.h>

void _ami2_ast_exec(ami2_t *ami, ami2_action_cb action_cb, ami2_ast_node_t *node, ami2_ast_node_t *parent, int is_left, int is_right)
{
  if (!node) return;

  /* if (is_left) printf("[L]"); */
  /* if (is_right) printf("[R]"); */
  
  /* printf("Node Type: %s\n", ami2_node_names[node->type]); */
  switch(node->type){
  case AMI2_NODE_DECLARATION:
  case AMI2_NODE_COREACTION:
    // Nothing to do, we keep browsing left
    break;
  case AMI2_NODE_INTEGER:
  case AMI2_NODE_FLOAT:
    break;
  case AMI2_NODE_STRING:
    if  ((parent) && (parent->type == AMI2_NODE_COREACTION)) {
      if ((!strcmp(node->variable->strval, "av")) ||
	  (!strcmp(node->variable->strval, "ami_version"))) {
	/* printf("Ami version\n"); */
	/* printf("val:%d\n", parent->right->variable->ival); */
	ami->header.version = parent->right->variable->ival;
      }
    }
    break;
  case AMI2_NODE_VARIABLE:
    /* if (node->variable) { */
    /*   ami_variable_debug(node->variable); */
    /* } else { */
    /*   printf("\tVariable tree root. Assigning right to left.\n"); */
    /* } */
    break;
  }
  _ami2_ast_exec(ami, action_cb, node->left,  node, 1, 0);
  _ami2_ast_exec(ami, action_cb, node->right, node, 0, 1);
}

int _ami2_ast_validate(ami2_t *ami)
{
  if (!ami->header.version) {
    printf("Error %d: %s\n", AMIERR_NO_VERSION_SET, ami2_error_desc[AMIERR_NO_VERSION_SET]);
    return 1;
  }
  
  return 0;
}

int ami2_ast_exec(ami2_t *ami, ami2_action_cb action_cb, void *userdata1, void *userdata2, void *userdata3)
{
  _ami2_ast_exec(ami, action_cb, ami->root, NULL, 0, 0);

  return _ami2_ast_validate(ami);
}


/* av 2 */

/* $firstg = "My first global variable" */
/* $point_to_firstg = $firstg */
/* $array = ["Val", 1, "third"] */

/* $third = $array[3] */

/* action first { */
/*     local $firstvar = "my first local var" */
/*     $"a global var" = "just a global var" */
/*     exec Debug */
/* } */

/* action second { */
/*     local $insecond = "This variable is in second" */
/*     exec Debug */
/* } */

/* action third {     */
/*     exec Debug */
/* } */


/* Node Type: AMI2_NODE_ROOT */
/* [R]Node Type: AMI2_NODE_LIST */
/* [L]Node Type: AMI2_NODE_DECLARATION */
/* [L]Node Type: AMI2_NODE_DECLARATION */
/* [L]Node Type: AMI2_NODE_DECLARATION */
/* [L]Node Type: AMI2_NODE_DECLARATION */
/* [L]Node Type: AMI2_NODE_DECLARATION */
/* [L]Node Type: AMI2_NODE_DECLARATION */
/* [L]Node Type: AMI2_NODE_DECLARATION */
/* [L]Node Type: AMI2_NODE_COREACTION */
/* [L]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:2] av */
/* [R]Node Type: AMI2_NODE_INTEGER */
/* AMI_VAR_INT */
/* 	[local:0] 2 */
/* [R]Node Type: AMI2_NODE_ASSIGN */
/* [L]Node Type: AMI2_NODE_VARIABLE */
/* AMI_VAR_STR */
/* 	[local:0,len:7] $firstg */
/* [R]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:24] My first global variable */
/* [R]Node Type: AMI2_NODE_ASSIGN */
/* [L]Node Type: AMI2_NODE_VARIABLE */
/* AMI_VAR_STR */
/* 	[local:0,len:16] $point_to_firstg */
/* [R]Node Type: AMI2_NODE_VARIABLE */
/* AMI_VAR_STR */
/* 	[local:0,len:7] $firstg */
/* [R]Node Type: AMI2_NODE_ASSIGN */
/* [L]Node Type: AMI2_NODE_VARIABLE */
/* AMI_VAR_STR */
/* 	[local:0,len:6] $array */
/* [R]Node Type: AMI2_NODE_ARRAY_SET */
/* [R]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:5] third */
/* [R]Node Type: AMI2_NODE_LIST */
/* [L]Node Type: AMI2_NODE_INTEGER */
/* AMI_VAR_INT */
/* 	[local:0] 1 */
/* [R]Node Type: AMI2_NODE_LIST */
/* [L]Node Type: AMI2_NODE_LIST */
/* [L]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:3] Val */
/* [R]Node Type: AMI2_NODE_ASSIGN */
/* [L]Node Type: AMI2_NODE_VARIABLE */
/* AMI_VAR_STR */
/* 	[local:0,len:6] $third */
/* [R]Node Type: AMI2_NODE_ARRAY_GET */
/* [L]Node Type: AMI2_NODE_VARIABLE */
/* AMI_VAR_STR */
/* 	[local:0,len:6] $array */
/* [R]Node Type: AMI2_NODE_INTEGER */
/* AMI_VAR_INT */
/* 	[local:0] 3 */
/* [R]Node Type: AMI2_NODE_ACTION */
/* [L]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:5] first */
/* [R]Node Type: AMI2_NODE_BLOCK */
/* [R]Node Type: AMI2_NODE_STATEMENT */
/* [L]Node Type: AMI2_NODE_STATEMENT */
/* [L]Node Type: AMI2_NODE_STATEMENT */
/* [R]Node Type: AMI2_NODE_ASSIGN_AS_LOCAL */
/* [L]Node Type: AMI2_NODE_VARIABLE */
/* AMI_VAR_STR */
/* 	[local:0,len:9] $firstvar */
/* [R]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:18] my first local var */
/* [R]Node Type: AMI2_NODE_ASSIGN */
/* [L]Node Type: AMI2_NODE_VARIABLE */
/* AMI_VAR_STR */
/* 	[local:0,len:13] $a global var */
/* [R]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:17] just a global var */
/* [R]Node Type: AMI2_NODE_EXEC */
/* [R]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:5] Debug */
/* [R]Node Type: AMI2_NODE_ACTION */
/* [L]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:6] second */
/* [R]Node Type: AMI2_NODE_BLOCK */
/* [R]Node Type: AMI2_NODE_STATEMENT */
/* [L]Node Type: AMI2_NODE_STATEMENT */
/* [R]Node Type: AMI2_NODE_ASSIGN_AS_LOCAL */
/* [L]Node Type: AMI2_NODE_VARIABLE */
/* AMI_VAR_STR */
/* 	[local:0,len:9] $insecond */
/* [R]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:26] This variable is in second */
/* [R]Node Type: AMI2_NODE_EXEC */
/* [R]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:5] Debug */
/* [R]Node Type: AMI2_NODE_ACTION */
/* [L]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:5] third */
/* [R]Node Type: AMI2_NODE_BLOCK */
/* [R]Node Type: AMI2_NODE_STATEMENT */
/* [R]Node Type: AMI2_NODE_EXEC */
/* [R]Node Type: AMI2_NODE_STRING */
/* AMI_VAR_STR */
/* 	[local:0,len:5] Debug */
