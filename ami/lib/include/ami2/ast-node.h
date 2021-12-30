#ifndef _AMI2_AST_H_
#define _AMI2_AST_H_

#include <ami/variable.h>

#ifdef __cplusplus
extern "C" {
#endif

enum _ami2_node_type_t {
  AMI2_NODE_ROOT,
  // declarations
  AMI2_NODE_DECL,
  AMI2_NODE_VARIABLE,
  // statements
  AMI2_NODE_REPEAT,
  AMI2_NODE_MATCH,
  AMI2_NODE_ASSIGN,
  AMI2_NODE_FUNCTION_CALL,
  // expressions
  AMI2_NODE_ARITHMETIC,
  AMI2_NODE_BOOLEAN,
  AMI2_NODE_RELATIONAL,
  AMI2_NODE_EQUAL,  
  AMI2_NODE_REGEX,
  AMI2_NODE_MODULO,
  AMI2_NODE_MATCH_NOMATCH
};
typedef enum _ami2_node_type_t ami2_node_type_t;
  
static const char *ami2_node_names[] = {
  "AMI2_NODE_ROOT",
  "AMI2_NODE_DECL",
  "AMI2_NODE_VARIABLE",
  "AMI2_NODE_REPEAT",
  "AMI2_NODE_MATCH",
  "AMI2_NODE_ASSIGN",
  "AMI2_NODE_FUNCTION_CALL",
  "AMI2_NODE_ARITHMETIC",
  "AMI2_NODE_BOOLEAN",
  "AMI2_NODE_RELATIONAL",
  "AMI2_NODE_EQUAL",
  "AMI2_NODE_REGEX",
  "AMI2_NODE_MODULO",
  "AMI2_NODE_MATCH_NOMATCH",
};

enum _ami2_operation_t {
  AMI2_OP_NONE,
  AMI2_OP_GREATER,       // >
  AMI2_OP_GREATER_EQUAL, // >=
  AMI2_OP_LESS,          // <
  AMI2_OP_LESS_EQUAL,    // <=
  AMI2_OP_EQUAL,     // ==
  AMI2_OP_NOT_EQUAL, // !=
  AMI2_OP_OR,  // ||
  AMI2_OP_AND, // &&
  AMI2_OP_NOT, // !
  AMI2_OP_ADD,  // +
  AMI2_OP_SUB,  // -
  AMI2_OP_DIV,  // /
  AMI2_OP_MUL,  // *
  AMI2_OP_INCR, // ++
  AMI2_OP_DECR, // --  
};
typedef enum _ami2_operation_t ami2_operation_t;

struct _ami2_ast_node_t {
  ami2_node_type_t type;
  ami2_operation_t operation;
  
  unsigned int lineno;
  ami_variable_t *variable;

  unsigned int repeat_count;
  
  struct _ami2_ast_node_t *left;
  struct _ami2_ast_node_t *right;
};
typedef struct _ami2_ast_node_t ami2_ast_node_t;

ami2_ast_node_t *ami2_ast_node_new(ami2_node_type_t node_type);
void ami2_ast_node_free(ami2_ast_node_t *node);
void ami2_ast_node_debug(ami2_ast_node_t *node);
int ami2_ast_node_append_right(ami2_ast_node_t *dstnode, ami2_ast_node_t *srcnode);
int ami2_ast_node_append_left(ami2_ast_node_t *dstnode, ami2_ast_node_t *srcnode);
  
#ifdef __cplusplus
}
#endif

#endif // _AMI2_AST_H_
