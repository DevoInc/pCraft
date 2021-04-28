#include <stdio.h>

#include <ami/astnode.h>

int main(int argc, char **argv)
{
  ami_astnode_t *astnode;

  astnode = ami_astnode_new();

  ami_astnode_free(astnode);
  
  return 0;
}
