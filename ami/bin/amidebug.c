#include <stdio.h>
#include <string.h>

#include <ami/ami.h>
#include <ami/action.h>
#include <ami/ast.h>
#include <ami/khash.h>

void simple_print_global_variables(ami_t *ami);
void simple_print_repeat_variables(ami_t *ami);
void simple_print_local_variables(ami_t *ami);

void foreach_action(ami_action_t *action, void *userdata)
{
  ami_t *ami = (ami_t *)userdata;
  /* printf("===== Running action =====\n"); */
  ami_action_debug(ami, action);
  /* printf("Running %s\n", action->name); */
}

void simple_foreach_action(ami_action_t *action, void *userdata)
{
  ami_field_action_t *field_action;

  ami_t *ami = (ami_t *)userdata;
  printf("------------------------\n");
  printf("* Action name(%s) exec(%s) ami->sleep_cursor(%f); sleep_cursor(%f) repeat_index(%d)\n", action->name, action->exec, ami->sleep_cursor, action->sleep_cursor, action->repeat_index);
  simple_print_repeat_variables(ami);
  simple_print_local_variables(ami);

  printf("* Field Actions:\n");
  for (field_action=action->field_actions; field_action; field_action=field_action->next) {

    printf("    field:%s;action:%s;left:%s;right:%s\n", field_action->field, field_action->action, field_action->left?field_action->left:"", field_action->right);
  }

}

void simple_print_global_variables(ami_t *ami)
{
  khint_t k;
  int count = 0;

  printf("* Global Variables:\n");
  if (ami->global_variables) {
    for (k = 0; k < kh_end(ami->global_variables); ++k)
      if (kh_exist(ami->global_variables, k)) {
  	char *key = (char *)kh_key(ami->global_variables, k);
  	char *value = (char *)kh_value(ami->global_variables, k);
	printf("    gv:[%d] %s = %s\n", count, key, ami_get_variable(ami, value));
	count++;
      }
  }
}

void simple_print_repeat_variables(ami_t *ami)
{
  khint_t k;
  int count = 0;

  printf("* Repeat Variables:\n");
  if (ami->repeat_variables) {
    for (k = 0; k < kh_end(ami->repeat_variables); ++k)
      if (kh_exist(ami->repeat_variables, k)) {
  	char *key = (char *)kh_key(ami->repeat_variables, k);
  	char *value = (char *)kh_value(ami->repeat_variables, k);
	printf("    rv:[%d] %s = %s\n", count, key, ami_get_variable(ami, value));
	count++;
      }
  }
}

void simple_print_local_variables(ami_t *ami)
{
  khint_t k;
  int count = 0;

  printf("* Local Variables:\n");
  if (ami->local_variables) {
    for (k = 0; k < kh_end(ami->local_variables); ++k)
      if (kh_exist(ami->local_variables, k)) {
  	char *key = (char *)kh_key(ami->local_variables, k);
  	char *value = (char *)kh_value(ami->local_variables, k);
	printf("    lv:[%d] %s = %s\n", count, key, ami_get_variable(ami, value));
	count++;
      }
  }
}

int simple_debug(const char *amifile)
{
  ami_t *ami;
  ami = ami_new();  
  ami_set_action_callback(ami, simple_foreach_action, ami);
  ami_parse_file(ami, amifile);
  printf("ami_version %d\n", ami->version);
  ami_ast_walk_actions(ami);
  printf("+++++++\n");
  simple_print_global_variables(ami);
  printf("\n");
  ami_close(ami);
  return 0;
}

int quiet_debug(const char *amifile)
{
  ami_t *ami;
  ami = ami_new();  
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
    fprintf(stderr, "Syntax: %s file.ami [--node|--ami|--simple]\n", argv[0]);
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

  ami = ami_new();
  if (!ami) {
    printf("Closing amidebug\n");
    goto close;
  }

  
  ami_set_action_callback(ami, foreach_action, ami);  
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
      ami_node_debug(ami->root_node);
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
