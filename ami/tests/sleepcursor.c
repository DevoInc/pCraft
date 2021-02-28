#include <stdio.h>
#include <ami/ami.h>

int main(void)
{
  ami_t *ami;
  ami = ami_new();

  float sleep = 0.666;
  ami_append_sleep_cursor(ami, "global", sleep);
  sleep = 0.333;
  ami_append_sleep_cursor(ami, "global", sleep);

  float out = ami_get_new_sleep_cursor(ami, "global");

  printf("sleep_cursor:%f\n", out);
  
  ami_close(ami);
  
  return 0;
}
