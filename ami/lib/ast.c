#include <stdio.h>

#include <ami/kvec.h>

#include <ami/action.h>
#include <ami/tree.h>
#include <ami/ast.h>

static void walk_node(ami_t *ami, ami_node_t *node, int repeat_index, int right)
{
  ami_node_t *n;
  ami_action_t *action;
  int index;
  
  for (n = node; n; n = right ? n->right : n->next) {
    switch(n->type) {
    case AMI_NT_REFERENCE:
      kv_push(char *, ami->references, n->strval);      
      break;
    case AMI_NT_ACTION:
      action = ami_action_new();
      action->name = n->strval;
      break;
    case AMI_NT_ACTIONCLOSE:
      if (ami->action_cb) {
	ami->action_cb(action, ami->action_cb_userdata);
      } else {
	fprintf(stderr,"*** Warning: No Action Callback Set!\n");
      }
      ami_action_close(action);
      break;
    case AMI_NT_REPEAT:
      for (index = 1; index <= n->intval; index++) {
      	walk_node(ami, n->right, index, 1);
      }
      break;
    }
  }
}

int ami_ast_walk_actions(ami_t *ami)
{
  
  if (!ami) {
    fprintf(stderr, "Ami is empty, cannot run %s!\n", __FUNCTION__);
    return -1;
  }

  if (!ami->root_node) {
    fprintf(stderr, "Ami root node is empty, cannot run %s!\n", __FUNCTION__);
    return -1;
  }

  walk_node(ami, ami->root_node, 0, 0);

  return 0;
}
