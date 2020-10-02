#include <stdio.h>

#include <ami/ami.h>

int main(int argc, char **argv)
{
  printf("Starting AMI\n");

  if (argc < 2) {
    fprintf(stderr, "Syntax: %s file.ami\n", argv[0]);
    return 1;
  }
  
  
  return 0;
}
