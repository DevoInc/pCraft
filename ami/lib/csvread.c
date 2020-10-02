#include <stdio.h>

#include <csv.h>

#include <ami/ami.h>
#include <ami/csvread.h>

#include <ami/kvec.h>

#define CSVBUF_SIZE 1024

struct _parse_helper_t {
  int has_header;
  int index;
  char *field;
  ami_kvec_t fields;
  int current_line;
  int current_field;
  char *retfield;
};
typedef struct _parse_helper_t parse_helper_t;

void on_new_field(void *s, size_t i, void *userdata)
{
  parse_helper_t *phelp = (parse_helper_t *)userdata;
  
  if ((phelp->current_line == 1) && (phelp->has_header)) {
    kv_push(char *, phelp->fields, strdup(s));
  } else {
    if (phelp->has_header) {
      char *this_field = kv_A(phelp->fields, phelp->current_field - 1);
      if (!strcmp(phelp->field, this_field)) {
	if (phelp->current_line - 1 == phelp->index) {
	  phelp->retfield = strdup(s);
	}
      }
    } else {
      fprintf(stderr, "Error, only CSV with headers are supported now. Please contibute!\n");
    }
    /* if (!strcmp()) */
    /* printf("%s:%s;", kv_A(phelp->fields, phelp->current_field - 1), s); */
  }  
  
  phelp->current_field++;
}

void on_new_line(int c, void *userdata)
{
  parse_helper_t *phelp = (parse_helper_t *)userdata;
  /* printf("[%d] new line:%d\n", phelp->current_line, c); */
  phelp->current_line += 1;
  phelp->current_field = 1;
}

char *ami_csvread_get_field_at_line(char *file, int index, char *field, int has_header)
{
  FILE *fp;
  struct csv_parser p;
  char buf[CSVBUF_SIZE];
  size_t bytes_read, pos, retval;

  parse_helper_t *phelp;  
  char *retfield = NULL;
  
  fp = fopen(file, "rb");
  if (!fp) {
    fprintf(stderr, "Error, could not read CSV file '%s'\n", file);
    return NULL;
  }

  phelp = (parse_helper_t *)malloc(sizeof(parse_helper_t));
  if (!phelp) {
    fprintf(stderr, "Error, cannot allocate parse_helper_t\n");
    return NULL;
  }

  phelp->has_header = has_header;
  phelp->index = index;
  phelp->field = field;
  kv_init(phelp->fields);
  phelp->current_line = 1;
  phelp->current_field = 1;
  phelp->retfield = NULL;
  
  csv_init(&p, CSV_APPEND_NULL);
  while ((bytes_read=fread(buf, 1, CSVBUF_SIZE, fp)) > 0) {
    if ((retval = csv_parse(&p, buf, bytes_read, on_new_field, on_new_line, phelp)) != bytes_read) {
      if (csv_error(&p) == CSV_EPARSE) {
	fprintf(stderr, "%s: malformed at byte %lu\n", file, (unsigned long)pos + retval + 1);
	goto end;
      } else {
	printf("Error while processing %s: %s\n", file, csv_strerror(csv_error(&p)));
	goto end;
      }
    }
    if (phelp->retfield) {
      retfield = strdup(phelp->retfield);
      goto end;
    }
  }

 end:
  free(phelp->retfield);
  free(phelp);
  fclose(fp);
  csv_fini(&p, NULL, NULL, NULL);
  csv_free(&p);
  
  return retfield;
}
