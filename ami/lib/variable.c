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

ami_variable_t *ami_variable_new_int(int ival)
{
  ami_variable_t *var;
  var = ami_variable_new();
  ami_variable_set_int(var, ival);
  return var;
}

void ami_variable_set_float(ami_variable_t *var, float fval)
{
  var->type = AMI_VAR_FLOAT;
  var->fval = fval;
}

ami_variable_t *ami_variable_new_float(float fval)
{
  ami_variable_t *var;
  var = ami_variable_new();
  ami_variable_set_float(var, fval);
  return var;
}

void ami_variable_set_string(ami_variable_t *var, char *strval)
{
  if (!var) {
    fprintf(stderr, "Error: Empty ami_variable_t!\n");
    return;
  }
  
  var->type = AMI_VAR_STR;
  var->strval = strdup(strval);
  var->len = strlen(strval);
}

ami_variable_t *ami_variable_new_string(char *strval)
{
  ami_variable_t *var;
  var = ami_variable_new();
  ami_variable_set_string(var, strval);
  return var;
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

ami_variable_t *ami_variable_array_get_at_index(ami_variable_t *array, size_t index)
{
  size_t count = 1;
  ami_variable_t *varp = array;
  
  if (!array) {
    fprintf(stderr, "Error: No array given to get an index!\n");
    return NULL;
  }
  if (array->type != AMI_VAR_ARRAY) {
    fprintf(stderr, "Error: The variable given is not an array!\n");
    return NULL;
  }

  while(varp->array) {
    if (count == index) {
      return varp->array;
    }
    count++;
    varp = varp->array;
  }

  return NULL;  
}

ami_variable_t *ami_variable_copy(ami_variable_t *var)
{
  ami_variable_t *new;
  ami_variable_t *varp;

  if (!var) {
    fprintf(stderr, "Please provide a variable!\n");
    return NULL;
  }

  new = ami_variable_new();
  switch(var->type) {
  case AMI_VAR_ARRAY:
    for (varp=var->array; varp; varp=varp->array) {
      ami_variable_t *newchild = ami_variable_copy(varp);
      ami_variable_array_append(new, newchild);
    }
    break;
  case AMI_VAR_INT:
    ami_variable_set_int(new, var->ival);
    break;
  case AMI_VAR_FLOAT:
    ami_variable_set_float(new, var->fval);
    break;
  case AMI_VAR_STR:
    ami_variable_set_string(new, var->strval);
    break;
  default:
    fprintf(stderr, "Error: no such type of variable. Cannot copy!\n");
    ami_variable_free(new);
    return NULL;
  }

  return new;
}

void _ami_variable_debug_indent(ami_variable_t *var, int indent)
{
  ami_variable_t *varp;
  /* fprintf(stderr, "%s\n", __FUNCTION__); */

  FILE *out = stdout;
  
  if (!var) {
    fprintf(out, "NULL variable, cannot debug!\n");
    return;
  }
  
  switch(var->type) {
  case AMI_VAR_ARRAY:
    fprintf(out, "AMI_VAR_ARRAY\n");
    for (varp=var->array; varp; varp=varp->array) {
      _ami_variable_debug_indent(varp, 1);
    }
    break;
  case AMI_VAR_INT:
    fprintf(out, "%sAMI_VAR_INT\n", indent?"\t":"");
    fprintf(out, "%s\t%d\n", indent?"\t":"", var->ival);
    break;
  case AMI_VAR_FLOAT:
    fprintf(out, "%sAMI_VAR_FLOAT\n", indent?"\t":"");
    fprintf(out, "%s\t%f\n", indent?"\t":"", var->fval);    
    break;
  case AMI_VAR_STR:
    fprintf(out, "%sAMI_VAR_STR\n",indent?"\t":"");
    fprintf(out, "%s\t[len:%ld] %s\n", indent?"\t":"",var->len, var->strval);        
    break;
  default:
    fprintf(out, "No such variable type:%d\n", var->type);
    break;
  }
}

void ami_variable_debug(ami_variable_t *var)
{
  _ami_variable_debug_indent(var, 0);
}

char *ami_variable_to_string(ami_variable_t *var)
{
  char *retstr;
  
  switch(var->type) {
  case AMI_VAR_INT:
    asprintf(&retstr, "%d", var->ival);
    return retstr;
    break;
  case AMI_VAR_FLOAT:
    asprintf(&retstr, "%f", var->fval);
    return retstr;
    break;
  case AMI_VAR_STR:
    return strdup(var->strval);
    break;
  }
  return "None";
}

int ami_variable_to_int(ami_variable_t *var)
{
  int retint;

  if (!var) {
    fprintf(stderr, "Error: no such variable. Assign the integer to -1.");
    return -1;
  }
  
  switch(var->type) {
  case AMI_VAR_INT:
    return var->ival;
    break;
  case AMI_VAR_FLOAT:
    return (int)var->fval;
    break;
  case AMI_VAR_STR:
    return (int)strtod(var->strval, NULL);
    break;
  }
  return -1;
}

void ami_variable_free(ami_variable_t *var)
{
  /* printf("Calling %s\n", __FUNCTION__); */
  if (!var) return;
  if (var->type == AMI_VAR_STR) {
    free(var->strval);
  }
  free(var);
}
