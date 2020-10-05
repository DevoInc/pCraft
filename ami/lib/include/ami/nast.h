#ifndef _NAST_H_
#define _NAST_H_

#include <ami/ami.h>

void nast_set_current_variable_value(ami_ast_t *nast, char *value);
char *nast_get_current_variable_value(ami_ast_t *nast);
void nast_set_current_field_value(ami_ast_t *nast, char *value);
char *nast_get_current_field_value(ami_ast_t *nast);

#endif // _NAST_H_
