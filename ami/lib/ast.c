#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

#include <ami/kvec.h>

#include <ami/ami.h>
#include <ami/action.h>
#include <ami/tree.h>
#include <ami/ast.h>
#include <ami/csvread.h>

static void walk_node(ami_t *ami, ami_node_t *node, int repeat_index, int right)
{
  ami_node_t *n;
  ami_action_t *action;
  int index;
  char *stack_str = NULL; // Keeping the last value
  int stack_int = 0;
  char *tmp_str;
  static char *csv_args[4] = { NULL, NULL, NULL, NULL }; // For now, we only have the CSV function
  kvec_t(char *) values_stack;
  static int varpos = 0;

  for (n = node; n; n = right ? n->right : n->next) {
    switch(n->type) {
    case AMI_NT_REFERENCE:
      kv_push(char *, ami->references, n->strval);      
      break;
    case AMI_NT_ACTION:
      ami->in_action = 1;
      action = ami_action_new();
      action->name = n->strval;
      break;
    case AMI_NT_ACTIONCLOSE:
      ami->in_action = 0;
      if (ami->action_cb) {
	ami->action_cb(action, ami->action_cb_userdata);
      } else {
	fprintf(stderr,"*** Warning: No Action Callback Set!\n");
      }
      ami_action_close(action);
      ami_erase_local_variables(ami);
      break;
    case AMI_NT_REPEAT:
      ami->in_repeat = 1;
      for (index = 1; index <= n->intval; index++) {
	char *indexvar;
	asprintf(&indexvar, "%d", index);
	ami_set_global_variable(ami, n->strval, indexvar);
	/* printf("We run a repeat action at index:%d\n", index); */
      	walk_node(ami, n->right, index, 1);
      }
      ami_erase_repeat_variables(ami);
      ami->in_repeat = 0;
      index = 0;
      break;
    case AMI_NT_MESSAGE:
      printf("%s\n", n->strval);
      break;
    case AMI_NT_VARVALSTR:
      kv_push(char *, ami->values_stack, strdup(n->strval));      
      break;
    case AMI_NT_VARVALINT:
      asprintf(&tmp_str, "%d", n->intval);
      kv_push(char *, ami->values_stack, strdup(tmp_str));      
      /* kv_a(char *, ami->values_stack, strdup(n->strval)); */
      break;
    case AMI_NT_VARVAR:
      kv_push(char *, ami->values_stack, strdup(n->strval));            
      break;
    case AMI_NT_VARNAME:
      if (ami->in_repeat || ami->in_action) {
	if (!ami->in_action) {
	  printf("%s is a local repeat variable with value:%s\n", n->strval, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	} else {
	  printf("%s is a local action variable with value:%s\n", n->strval, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	}
      } else {
	printf("%s is a global variable with value:%s\n", n->strval, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
      }
      /* if (!stack_str) { */
      /* 	printf("Assigning %s to int:%d\n", n->strval, stack_int); */
      /* } else { */
      /* 	printf("[%d] Assigning %s to str:%s\n", in_a_block, n->strval, stack_str); */
      /* } */
      break;
    case AMI_NT_FUNCARG:
      printf("Funcarg:%s\n", n->strval);
      break;
    case AMI_NT_FUNCTION:
      if (!strcmp("csv", n->strval)) {
	/* size_t stacklen = kv_size(ami->values_stack); */
	/* for (size_t i = 0; i < stacklen; i++) { */
	/*   printf("i:%d;val:%s\n", i, kv_A(ami->values_stack, i)); */
	/* }	 */
	
	int has_header = (int)strtod(kv_A(ami->values_stack, kv_size(ami->values_stack)-1), NULL);
	char *field = kv_A(ami->values_stack, kv_size(ami->values_stack)-2);
	char *line_val = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-3));
	int line_in_csv = (int)strtod(line_val, NULL);
	char *file = kv_A(ami->values_stack, kv_size(ami->values_stack)-4);

	/* printf("file:%s;line_in_csv:%d;field:%s;has_header:%d\n", file, line_in_csv, field, has_header); */
	char *result = ami_csvread_get_field_at_line(file, line_in_csv, field, has_header);
	if (!result) {
	  fprintf(stderr, "Error reading CSV file %s, field:%s, line:%d\n", file, field, line_in_csv);
	  exit(1);
	} else {
	  kv_push(char *, ami->values_stack, strdup(result));
	}
      } else {
      	fprintf(stderr, "Unhandled function:%s\n", n->strval);
      }
      varpos = 0;
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
