#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>

#include <ami/ami.h>
#include <ami/action.h>
#include <ami/ast.h>
#include <ami/khash.h>

void simple_print_global_variables(ami_t *ami);
void simple_print_local_variables(ami_action_t *action);

void foreach_action(ami_action_t *action, void *userdata1, void *userdata2)
{
  ami_t *ami = (ami_t *)userdata1;
  /* printf("===== Running action =====\n"); */
  ami_action_debug(ami, action);
  /* printf("Running %s\n", action->name); */
}

void quiet_foreach_action(ami_action_t *action, void *userdata1, void *userdata2)
{
  ami_field_action_t *field_action;

  ami_t *ami = (ami_t *)userdata1;
  for (field_action=action->field_actions; field_action; field_action=field_action->next) {
  }

}

void simple_foreach_action(ami_action_t *action, void *userdata1, void *userdata2)
{
  ami_field_action_t *field_action;

  ami_t *ami = (ami_t *)userdata1;
  printf("------------------------\n");
  printf("* Action name(%s) exec(%s) ami->sleep_cursor(%f); sleep_cursor(%f) repeat_index(%d)\n", action->name, action->exec, ami->sleep_cursor, action->sleep_cursor, action->repeat_index);
  simple_print_local_variables(action);
  
  printf("* Field Actions:\n");
  for (field_action=action->field_actions; field_action; field_action=field_action->next) {

    printf("    field:%s;action:%s;left:%s;right:%s\n", field_action->field, field_action->action, field_action->left?field_action->left:"", field_action->right);
  }

}

void break_foreach_action(ami_action_t *action, void *userdata1, void *userdata2)
{
  ami_field_action_t *field_action;
  char c;
  khint_t k;
  int count = 0;

  ami_t *ami = (ami_t *)userdata1;
  printf("<press enter>");

  while (c = getchar()) {
    fflush(stdin);
    if (c == '\n'){
      printf("action %s {\n", action->name);
      printf("\texec %s\n", action->exec);

      if (ami->variables) {
	for (k = 0; k < kh_end(ami->variables); ++k)
	  if (kh_exist(ami->variables, k)) {
	    char *key = (char *)kh_key(ami->variables, k);
	    ami_variable_t *value = (ami_variable_t *)kh_value(ami->variables, k);
	    if (value->type == AMI_VAR_STR) {
	      printf("\t%s = \"%s\"\n", key, ami_variable_to_string(value));
	    } else {
	      printf("\t%s = %s\n", key, ami_variable_to_string(value));
	    }
	    /* ami_variable_debug(value); */
	    count++;
	  }
      }


      for (field_action=action->field_actions; field_action; field_action=field_action->next) {
	if (!strcmp(field_action->action, "set")) {
	  printf("\tfield[\"%s\"] = \"%s\"\n", field_action->field, field_action->right);
	}
      }
      
      printf("}\n");
      
      
      break;
    }
  }
}

void simple_print_global_variables(ami_t *ami)
{
  khint_t k;
  int count = 0;

  printf("* Global Variables:\n");
  if (ami->variables) {
    for (k = 0; k < kh_end(ami->variables); ++k)
      if (kh_exist(ami->variables, k)) {
  	char *key = (char *)kh_key(ami->variables, k);
	printf("[%d] %s\n", count, key);
  	ami_variable_t *value = (ami_variable_t *)kh_value(ami->variables, k);
	ami_variable_debug(value);
	count++;
      }
  }
}

void simple_print_local_variables(ami_action_t *action)
{
  khint_t k;

  printf("* Local Variables:\n");
  if (action->variables) {
    for (k = 0; k < kh_end(action->variables); ++k)
      if (kh_exist(action->variables, k)) {
  	char *key = (char *)kh_key(action->variables, k);
	printf("_%s\n", key);
  	ami_variable_t *value = (ami_variable_t *)kh_value(action->variables, k);
	ami_variable_debug(value);
      }
  }
}

int simple_debug(const char *amifile)
{
  ami_t *ami;
  ami = ami_new();  
  ami_set_action_callback(ami, simple_foreach_action, ami, NULL);
  ami_parse_file(ami, amifile);
  printf("ami_version %d\n", ami->version);
  ami_ast_walk_actions(ami);
  printf("+++++++\n");
  simple_print_global_variables(ami);
  printf("\n");
  ami_close(ami);
  return 0;
}

int break_debug(const char *amifile)
{
  ami_t *ami;
  ami = ami_new();
  ami_set_action_callback(ami, break_foreach_action, ami, NULL);
  ami_parse_file(ami, amifile);
  ami_ast_walk_actions(ami);
  ami_close(ami);
  return 0;
}

int quiet_debug(const char *amifile)
{
  ami_t *ami;
  ami = ami_new();  
  ami_set_action_callback(ami, quiet_foreach_action, ami, NULL);
  ami_parse_file(ami, amifile);
  ami_ast_walk_actions(ami);
  ami_close(ami);
  return 0;
}


int main(int argc, char **argv)
{
  ami_t *ami;
  int ret;
  
  if (argc < 2) {
    fprintf(stderr, "Syntax: %s file.ami [--node|--ami|--simple|--break|--quiet]\n", argv[0]);
    return 1;
  }

  if (argc > 2) {
    if (!strcmp("--simple", argv[2])) {
      return simple_debug(argv[1]);
    }
  }

  if (argc > 2) {
    if (!strcmp("--quiet", argv[2])) {
      return quiet_debug(argv[1]);
    }
  }
  
  printf("Starting AMI Debugger!\n");

  if (argc > 2) {
    if (!strcmp("--break", argv[2])) {
      return break_debug(argv[1]);
    }
  }  
  
  ami = ami_new();
  if (!ami) {
    printf("Closing amidebug\n");
    goto close;
  }

  
  ami_set_action_callback(ami, foreach_action, ami, NULL);  
  ami->debug = 1;
  
  ret = ami_parse_file(ami, argv[1]);
  if (ret) {
    if (ami->error) {
      printf("Error: %s\n", ami_error_to_string(ami));
      goto close;
    }
  }  

  if (argc > 2) {
    if (!strcmp("--node", argv[2])) {
      ami_node_debug2(ami->root_node, 0);
    }
  }
  ami_ast_walk_actions(ami);

  if (argc > 2) {
    if (!strcmp("--ami", argv[2])) {
      ami_debug(ami);
    }
  }
  
 close:
  ami_close(ami);  
  return 0;
}
