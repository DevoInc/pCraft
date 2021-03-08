#include <stdio.h>

#include <csv.h>

#include <ami/ami.h>
#include <ami/csvread.h>

#include <ami/kvec.h>
#include <ami/khash.h>

#define CSVBUF_SIZE 1024

KHASH_MAP_INIT_STR(fieldhash, int)

struct _parse_helper_t {  
  int has_header;
  int index;
  char *field;
  ami_kvec_t fields;
  int current_line;
  int current_field;
  int total_fields;
  int total_lines;
  char *retfield;
  char **array;
  int field_incr;
  int field_pos;
  int length_fields; // if we have 3 fields per line, it will be 3
};
typedef struct _parse_helper_t parse_helper_t;

void on_new_field_prepare(void *s, size_t i, void *userdata)
{
  parse_helper_t *phelp = (parse_helper_t *)userdata;
  if (!phelp) {
    fprintf(stderr, "Error reading field helper!");
    return;
  }

  if (phelp->total_lines == 0) {
    /* We have out first line here. This is our header. */
    if (!strcmp(phelp->field, s)) {
      /* printf("field pos for %s is %d\n", s, phelp->total_fields); */
      phelp->field_pos = phelp->total_fields;
    }
  }
  
  phelp->total_fields++;
}

void on_new_line_prepare(int c, void *userdata)
{
  parse_helper_t *phelp = (parse_helper_t *)userdata;
  if (phelp->total_lines == 0) {
    phelp->length_fields = phelp->total_fields; //  We are done parsing the first line, so we know the length 
  }
  phelp->total_lines++;
}

void new_field_array(void *s, size_t i, void *userdata)
{
  parse_helper_t *phelp = (parse_helper_t *)userdata;

  /* printf("%d:%s\n", phelp->field_incr, s); */
  phelp->array[phelp->field_incr] = strdup(s);
  
  phelp->field_incr++;
}

void new_line_array(int c, void *userdata)
{

}

void on_new_field(void *s, size_t i, void *userdata)
{
  parse_helper_t *phelp = (parse_helper_t *)userdata;
  if (!phelp) {
    fprintf(stderr, "Error reading field helper!");
    return;
  }

  if ((phelp->current_line == 1) && (phelp->has_header)) {
    kv_push(char *, phelp->fields, strdup(s));
  } else {
    if (phelp->has_header) {
      char *thips_field = kv_A(phelp->fields, phelp->current_field - 1);
      if (!strcmp(phelp->field, thips_field)) {
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

char *ami_csvread_get_field_at_line(ami_t *ami, char *file, int index, char *field, int has_header)
{
  FILE *fp;
  struct csv_parser p;
  char buf[CSVBUF_SIZE];
  size_t bytes_read = 0, pos = 0, retval = 0;

  parse_helper_t *phelp;  
  char *retfield = NULL;
  char **membuf = NULL;
  size_t membuf_len = 0;
  char c = 0;
  int cursor = 0;
  int length = 0;

  /* printf(">>> %s(%s, %d, %s, %d)\n", __FUNCTION__, file, index, field, has_header); */
  
  phelp = (parse_helper_t *)malloc(sizeof(parse_helper_t));
  if (!phelp) {
    fprintf(stderr, "Error, cannot allocate parse_helper_t\n");
    return NULL;
  }

  phelp->has_header = has_header;
  phelp->index = index;
  phelp->field = field;
  phelp->field_pos = -1;
  kv_init(phelp->fields);
  phelp->current_line = 1;
  phelp->current_field = 1;
  phelp->retfield = NULL;
  phelp->total_fields = 0;
  phelp->total_lines = 0;
  phelp->array = NULL;  
  phelp->field_incr = 0;
  phelp->length_fields = 0;
  
  csv_init(&p, CSV_APPEND_NULL);

  membuf = ami_get_membuf(ami, file);
  if (!membuf) {
    fp = ami_get_open_file(ami, file);
    if (!fp) {
      fp = fopen(file, "rb");
      if (!fp) {
	fprintf(stderr, "Error, could not read CSV file '%s'\n", file);
	return NULL;
      }
      /* Save the file pointer in the ami to avoid open-close too many times on the same files */
      ami_set_open_file(ami, file, fp);
    }

    
    rewind(fp);
    /* 
     * <PREPROCESSING>
     * Check the volume of our CSV 
     */
    while ((bytes_read=fread(buf, 1, CSVBUF_SIZE, fp)) > 0) {
      if ((retval = csv_parse(&p, buf, bytes_read, on_new_field_prepare, on_new_line_prepare, phelp)) != bytes_read) {
	if (csv_error(&p) == CSV_EPARSE) {
	  fprintf(stderr, "%s: malformed at byte %lu\n", file, (unsigned long)pos + retval + 1);
	  goto end;
	}
      }       
    }
    rewind(fp);
    /* 
     * </PREPROCESSING>
     */

    ami_set_totalfields(ami, file, phelp->total_fields);
    ami_set_totallines(ami, file, phelp->total_lines);
    ami_set_lengthfields(ami, file, phelp->length_fields);
    
    /* <ArrayBuilding> */
    phelp->array = malloc(phelp->total_fields * sizeof(char *));
    if (!phelp->array) {
      fprintf(stderr, "Could not allocate CSV array!\n");
      goto end;
    }

    
     while ((bytes_read=fread(buf, 1, CSVBUF_SIZE, fp)) > 0) {
       if ((retval = csv_parse(&p, buf, bytes_read, new_field_array, new_line_array, phelp)) != bytes_read) {
	 if (csv_error(&p) == CSV_EPARSE) {
	   fprintf(stderr, "%s: malformed at byte %lu\n", file, (unsigned long)pos + retval + 1);
	   goto end;
	 }
       }       
     }
    /* </ArrayBuilding> */
     
    ami_set_membuf(ami, file, phelp->array);
    membuf = phelp->array;
  }

  index++;
  int want = index * ami_get_lengthfields(ami, file) + phelp->field_pos;
  if (want > ami_get_totalfields(ami, file)) {
    fprintf(stderr, "Error reading file %s, line %d. Line number exceeded! Requested %d\n", file, index, want);
  }
  retfield = strdup(membuf[want]);

  return retfield;
  
 end:
  free(phelp->array);
  free(phelp->retfield);
  free(phelp);
  /* rewind(fp); */
  csv_fini(&p, NULL, NULL, NULL);
  csv_free(&p);
  return retfield;

 end2:
  free(phelp->array);
  free(phelp->retfield);
  free(phelp);
  
  return retfield;
}
