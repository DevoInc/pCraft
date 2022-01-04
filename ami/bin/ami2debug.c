#include <ami2/ami2.h>


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

int main(int argc, char **argv)
{
  ami2_t *ami;
  ami = ami2_new();
  ami2_parse_file(ami, argv[1]);
  ami2_debug(ami);
  ami2_free(ami);

  /*   ami2_t *ami2; */
  
/*   ami2 = ami2_new(); */
/*   ami2_debug(ami2); */
/*   ami2_free(ami2); */

/*   ami2_ast_node_t *node; */
/*   node = ami2_ast_node_new(AMI2_NODE_ASSIGN);   */
/* /\* $firstg = "My first global variable" *\/ */
/*   ami2_ast_node_t *rnode; */
/*   rnode = ami2_ast_node_new(AMI2_NODE_VARIABLE); */
/*   ami_variable_t *var; */
/*   var = ami_variable_new(); */
/*   ami_variable_set_string(var, "My first global variable"); */
/*   rnode->variable = var; */
  
/*   ami2_ast_node_t *lnode; */
/*   lnode = ami2_ast_node_new(AMI2_NODE_VARIABLE); */
/*   /\* ami_variable_t *var; *\/ */
/*   var = ami_variable_new(); */
/*   ami_variable_set_variable(var, "$firstg"); */
/*   lnode->variable = var; */
/* /\* $point_to_firstg = $firstg *\/   */

/*   node->left = lnode; */
/*   node->right = rnode; */
  
/*   walk_ast(node); */
  
  return 0;
}
