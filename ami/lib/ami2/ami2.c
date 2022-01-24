#include <stdio.h>
#include <stdlib.h>

#include <parse.h>

#include <ami2/ami2.h>

ami2_t *ami2_new(void)
{
  ami2_t *ami2;

  ami2 = (ami2_t *)malloc(sizeof(ami2_t));
  if (!ami2) {
    fprintf(stderr, "Cannot allocate ami2_t!\n");
    return NULL;
  }
  ami2->header.debug = 0;
  ami2->header.version = 0;
  ami2->header.start_time = 0;
  ami2->header.revision = 0;
  ami2->header.author = NULL;
  ami2->header.shortdesc = NULL;
  ami2->header.description = NULL;
  ami2->header.taxonomy = NULL;

  ami2->in_action_block = 0;
  ami2->root = NULL; //ami2_ast_node_new(AMI2_NODE_ROOT);
  /* ami2->last = ami2->root; */
  
  return ami2;
}

void ami2_walk_ast_to_free(ami2_ast_node_t *node)
{
  if (!node) return;

  if (node->variable) {
    ami_variable_free(node->variable);    
  }

  /* ami2_walk_ast(node->left); */
  /* free(node->left); */
  /* ami2_walk_ast(node->right); */
  /* free(node->right); */

  /* free(node); */
}

void ami2_ast_free(ami2_t *ami)
{
  if (ami) {
    ami2_walk_ast_to_free(ami->root);
  }
}

void ami2_free(ami2_t *ami)
{
  ami2_ast_node_free(ami->root);
  free((char *)ami->original_file);
  ami2_ast_free(ami);
  free(ami);
}

int ami2_parse_file(ami2_t *ami, const char *file)
{
	yyscan_t scanner;
	FILE *fpin;

	/* printf("Parsing file: %s\n", file); */
	
	if (!ami) {
	  fprintf(stderr, "Cannot parse file %s as library initialization failed.\n", file);
	  return 1;
	}


	ami->original_file = strdup(file);

	if (ami_yylex_init(&scanner) != 0) {
		fprintf(stderr, "Error initializing yylex\n");
		return 1;
	}

	fpin = fopen(file, "r");
	if (!fpin) {
	  fprintf(stderr, "Error parsing %s\n", file);
	  return 1;
	}
	ami_yyrestart(fpin, scanner);
	
	/* state = ami_yy_scan_string(string, scanner); */
	if (ami_yyparse(scanner, ami) != 0) {
	        fprintf(stderr, "Error with yyparse\n");
		return 1;
	}
	/* ami_yy_delete_buffer(state, scanner); */
	ami_yylex_destroy(scanner);
	
	fflush(fpin);
	fclose(fpin);

	/* return ami_validate(ami); */
	return 0;
}


void ami2_walk_ast(ami2_ast_node_t *node, int is_left, int is_right)
{
  if (!node) return;

  if (is_left) printf("[L]");
  if (is_right) printf("[R]");
  
  printf("Node Type: %s\n", ami2_node_names[node->type]);
  switch(node->type){
  case AMI2_NODE_INTEGER:
  case AMI2_NODE_FLOAT:
  case AMI2_NODE_STRING:
  case AMI2_NODE_VARIABLE:
    if (node->variable) {
      ami_variable_debug(node->variable);
    } else {
      printf("\tVariable tree root. Assigning right to left.\n");
    }
  }
  ami2_walk_ast(node->left,  1, 0);
  ami2_walk_ast(node->right, 0, 1);
}

void ami2_debug(ami2_t *ami)
{
  printf("Calling %s\n", __FUNCTION__);
  ami2_walk_ast(ami->root, 0, 0);
}
