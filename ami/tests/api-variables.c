#include <stdio.h>

#include <ami/variable.h>

int main(int argc, char **argv)
{
  ami_variable_t *array;
  ami_variable_t *var;
  ami_variable_t *var2;
  ami_variable_t *var3;
  
  array = ami_variable_new();
  var = ami_variable_new();
  ami_variable_set_int(var, 1234);
  ami_variable_array_append(array, var);
  var2 = ami_variable_new();
  ami_variable_set_string(var2, "my string");
  ami_variable_array_append(array, var2);
  var3 = ami_variable_new();
  ami_variable_set_float(var3, 3.14);
  ami_variable_array_append(array, var3);

  ami_variable_debug(array);
  
  ami_variable_free(array);
  ami_variable_free(var);
  ami_variable_free(var2);
  ami_variable_free(var3);
  
  return 0;
}
			     
