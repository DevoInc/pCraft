#include <stdio.h>
#include <ami/ami.h>

int main(void)
{
  ami_t *ami;
  ami = ami_new();

  /* ami_append_item(ami, AMI_NT_VARVAR, "$foo", 0, 0); */
  ami_append_item(ami, AMI_NT_VARVALSTR, "content for var", 0, 0, 0);
  ami_append_item(ami, AMI_NT_VARNAME, "$varname", 0, 0, 0);
  
  ami_close(ami);
  return 0;
}
