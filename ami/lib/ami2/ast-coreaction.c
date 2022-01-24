#include <ami2/ami2.h>
#include <ami2/ast.h>
#include <ami2/errors.h>
#include <ami2/ast-actions.h>

int ami2_ast_coreaction_handle(ami2_t *ami, ami2_action_cb action_cb, ami2_ast_node_t *node, ami2_ast_node_t *parent, int is_left, int is_right)
{
    if ((!strcmp(node->left->variable->strval, "av")) ||
	(!strcmp(node->left->variable->strval, "ami_version"))) {
      /* printf("Ami version\n"); */
      /* printf("val:%d\n", parent->right->variable->ival); */
      ami->header.version = node->right->variable->ival;
    }
    return 0;
}

