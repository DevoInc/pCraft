#ifndef _CSVREAD_H_
#define _CSVREAD_H_

#include "khash.h"

#ifdef __cplusplus
extern "C" {
#endif

struct _csv_field_t {
  char *name;
  int position;
};
typedef struct _csv_field_t csv_field_t;

KHASH_MAP_INIT_STR(fieldposhash, csv_field_t *)

csv_field_t *ami_csvfield_new(char *fieldname, int fieldpos);
  
char *ami_csvread_get_field_at_line(ami_t *ami, char *file, int index, char *field, int has_header);

#ifdef __cplusplus
}
#endif

#endif // _CSVREAD_H_
