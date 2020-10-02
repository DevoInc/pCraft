#include <stdio.h>
#include <ami/ami.h>

int main(int argc, char **argv)
{
  ami_t *ami;
  int ret;
  
  printf("Starting AMI Debugger!\n");

  if (argc < 2) {
    fprintf(stderr, "Syntax: %s file.ami\n", argv[0]);
    return 1;
  }

  ami = ami_new();
  if (!ami) {
    printf("Closing amidebug\n");
    goto close;
  }

  ami->debug = 1;
  
  ret = ami_parse_file(ami, argv[1]);
  if (ret) {
    if (ami->error) {
      printf("Error: %s\n", ami_error_to_string(ami));
      goto close;
    }
  }  
  ami_debug(ami);

 close:
  ami_close(ami);  
  return 0;
}
