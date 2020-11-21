#include <ami/ami.h>

int main(int argc, char **argv)
{
  ami_t *ami;
  ami = ami_new();  
  ami_close(ami);
  return 0;
}

