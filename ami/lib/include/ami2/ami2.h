#ifndef _AMI2_H_
#define _AMI2_H_

#include <ami/ami.h> // For csv_files_t
#include <ami2/ast-node.h>

#ifdef __cplusplus
extern "C" {
#endif

struct _ami2_header_t {
  unsigned int debug;
  unsigned int version;
  unsigned int start_time;
  unsigned int revision;
  const char *author;
  const char *shortdesc;
  const char *description;
  const char *taxonomy;
};
typedef struct _ami2_header_t ami2_header_t;
  
struct _ami2_t {
  const char *original_file;
  
  khash_t(varhash) *global_variables;
  csvfiles_t *csvfiles; // All our CSV files are loaded and then can be used without having to reload them. This is the reason why it belongs here.
  //  khash_t(floathash) *sleepcursor; // Sleep cursors are in groups

  ami2_header_t header;

  int in_action_block;
  ami2_ast_node_t *root;
  /* ami2_ast_node_t *last; */
};
typedef struct _ami2_t ami2_t;

ami2_t *ami2_new(void);
void ami2_free(ami2_t *ami);
int ami2_parse_file(ami2_t *ami, const char *file);
void ami2_walk_ast(ami2_ast_node_t *node, int is_left, int is_right);
void ami2_debug(ami2_t *ami);
  
#ifdef __cplusplus
}
#endif

#endif // _AMI2_H_
