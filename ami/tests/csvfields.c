#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <ami/ami.h>

int main(int argc, char **argv)
{
  ami_t *ami;

  ami = ami_new();

  ami_add_csvfield(ami, "file.csv", "first", 0);
  ami_add_csvfield(ami, "file.csv", "second", 1);
  ami_add_csvfield(ami, "file.csv", "third", 2);
  
  ami_add_csvfield(ami, "another.csv", "first", 0);

  int csvpos = ami_get_csvfield_pos(ami, "file.csv", "third");
  printf("csvpos:%d\n", csvpos);
  
  ami_close(ami);
    
  return 0;
}
