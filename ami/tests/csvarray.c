#include <ami/ami.h>

int main(int argc, char **argv)
{
  ami_t *ami;
  ami = ami_new();

  ami_array_set_header(ami, "myarray", 0, "foo");
  ami_array_set_header(ami, "myarray", 1, "bar");

  printf("pos for header:%d\n", ami_array_get_header_pos(ami, "myarray", "bar"));
  
  ami_close(ami);
  return 0;
}

