#include <stdio.h>
#include <stdlib.h>

#include <ami2/ami2.h>

ami2_t *ami2_new(void)
{
  ami2_t *ami2;

  ami2 = (ami2_t *)malloc(sizeof(ami2_t));
  if (!ami2) {
    fprintf(stderr, "Cannot allocate ami2_t!\n");
    return NULL;
  }
  ami2->header.debug = 0;
  ami2->header.version = 0;
  ami2->header.start_time = 0;
  ami2->header.revision = 0;
  ami2->header.author = NULL;
  ami2->header.shortdesc = NULL;
  ami2->header.description = NULL;
  ami2->header.taxonomy = NULL;

  ami2->in_action = 0;
  ami2->root = ami2_ast_node_new(AMI2_NODE_ROOT);
  ami2->last = ami2->root;
  
  return ami2;
}

void ami2_free(ami2_t *ami)
{
  ami2_ast_node_free(ami->root);
  free(ami);
}

void ami2_debug(ami2_t *ami)
{

}
