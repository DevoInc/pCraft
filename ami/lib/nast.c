#include <stdio.h>
#include <ami/ami.h>

#include <ami/nast.h>

void nast_set_current_variable_value(ami_ast_t *nast, char *value)
{
  /* printf("%s:%s\n", __FUNCTION__, value); */
  if (nast->current_variable_value) {
    free(nast->current_variable_value);
  }
  nast->current_variable_value = strdup(value);
}

char *nast_get_current_variable_value(ami_ast_t *nast)
{
  return nast->current_variable_value;
}

void nast_set_current_field_value(ami_ast_t *nast, char *value)
{
  /* printf("%s:%s\n", __FUNCTION__, value); */
  if (nast->current_field_value) {
    free(nast->current_field_value);
  }
  nast->current_field_value = strdup(value);
}

char *nast_get_current_field_value(ami_ast_t *nast)
{
  return nast->current_field_value;
}

