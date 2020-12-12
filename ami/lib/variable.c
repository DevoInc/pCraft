#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <ami/variable.h>

ami_variable_t *ami_variable_new(void)
{
  ami_variable_t *var;

  var = (ami_variable_t *)malloc(sizeof(ami_variable_t));
  if (!var) {
    fprintf(stderr, "Cannot allocate ami_variable_t!\n");
    return NULL;
  }
  var->type   = AMI_VAR_NONE;
  var->len    = 0;
  var->strval = NULL;
  var->ival   = 0;
  var->fval   = 0;
  var->array  = NULL;
  
  return var;
}

void ami_variable_set_int(ami_variable_t *var, int ival)
{
  var->type = AMI_VAR_INT;
  var->ival = ival;
}

void ami_variable_set_float(ami_variable_t *var, float fval)
{
  var->type = AMI_VAR_FLOAT;
  var->fval = fval;
}

void ami_variable_set_string(ami_variable_t *var, char *strval)
{
  var->type = AMI_VAR_STR;
  var->strval = strdup(strval);
  var->len = strlen(strval);
}

ami_variable_t *ami_variable_array_append(ami_variable_t *var, ami_variable_t *to_append)
{
  ami_variable_t *varp = var;
  char is_empty = 1;

  if (!var) {
    fprintf(stderr, "Error: no variable given\n");
    return NULL;
  }

  is_empty = var->array ? 0 : 1;

  if (is_empty) {
    var->type = AMI_VAR_ARRAY;    
    var->array = to_append;
    var->len++;
    return var;
  } else {
    while (varp->array) { varp = varp->array; }
    varp->array = to_append;
    var->len++;
  }

  return var;
}

void ami_variable_debug(ami_variable_t *var)
{
  ami_variable_t *varp;

  /* fprintf(stderr, "%s\n", __FUNCTION__); */
  
  switch(var->type) {
  case AMI_VAR_ARRAY:
    fprintf(stderr, "AMI_VAR_ARRAY\n");
    for (varp=var->array; varp; varp=varp->array) {
      ami_variable_debug(varp);
    }
    break;
  case AMI_VAR_INT:
    fprintf(stderr, "AMI_VAR_INT\n");
    fprintf(stderr, "\t%d\n", var->ival);
    break;
  case AMI_VAR_FLOAT:
    fprintf(stderr, "AMI_VAR_FLOAT\n");
    fprintf(stderr, "\t%f\n", var->fval);    
    break;
  case AMI_VAR_STR:
    fprintf(stderr, "AMI_VAR_STR\n");
    fprintf(stderr, "\t[len:%ld] %s\n", var->len, var->strval);        
    break;
  default:
    fprintf(stderr, "No such variable type:%d\n", var->type);
    break;
  }
}

void ami_variable_free(ami_variable_t *var)
{
  if (var->type == AMI_VAR_STR) {
    free(var->strval);
  }
  free(var);
}
