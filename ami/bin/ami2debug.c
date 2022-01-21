#include <ami2/ami2.h>
#include <ami2/ast.h>

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

void foreach_action(ami2_t *ami, ami_action_t *action, void *userdata1, void *userdata2, void *userdata3)
{
  printf("We have an action!\n");
}

int main(int argc, char **argv)
{
  ami2_t *ami;
  ami = ami2_new();
  ami2_parse_file(ami, argv[1]);
  /* ami2_debug(ami); */
  ami2_ast_exec(ami, foreach_action, NULL, NULL, NULL);
  ami2_free(ami);
  
  return 0;
}
