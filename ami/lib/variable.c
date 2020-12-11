#include <stdio.h>
#include <stdlib.h>

#include <ami/variable.h>

ami_variable_t *ami_variable_new(void)
{
  ami_variable_t *var;

  var = (ami_variable_t *)malloc(sizeof(ami_variable_t));
  if (!var) {
    fprintf(stderr, "Cannot allocate ami_variable_t!\n");
    return NULL;
  }
  
  return var;
}

void ami_variable_int(ami_variable_t *var, int ival)
{
  var->type = AMI_VAR_INT;
  var->ival = ival;
}

void ami_variable_float(ami_variable_t *var, float fval)
{
  var->type = AMI_VAR_FLOAT;
  var->fval = fval;
}

void ami_variable_char(ami_variable_t *var, char *strval)
{
  var->type = AMI_VAR_STR;
  var->strval = strdup(strval);
}

void ami_variable_free(ami_variable_t *var)
{
  if (var->type == AMI_VAR_STR) {
    free(var->strval);
  }
  free(var);
}
