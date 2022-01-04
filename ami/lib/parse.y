%expect 0
   
%code requires
{
#ifndef YY_TYPEDEF_YY_SCANNER_T
#define YY_TYPEDEF_YY_SCANNER_T 
typedef void *yyscan_t;
#endif

#include <ami2/ami2.h>
#include <ami2/ast-node.h>
#include <ami2/errors.h>

#include <unistd.h>
}

%code provides
{
  void ami_yyerror (yyscan_t scanner, ami2_t *ami, const char *msg, ...);
  int get_lineno(yyscan_t scanner);
  int ami_yylex_init(yyscan_t *scanner);
  void ami_yyrestart(FILE *fp, yyscan_t scanner);
  int ami_yylex_destroy(yyscan_t scanner);
  
  static char *current_file = NULL;

}

%code top
{
#define _GNU_SOURCE
#include <stdio.h>
#include <stdarg.h>
#include <string.h>

#include <parse.h>

}

%code
{
  YY_DECL;
}

%define api.pure full
%define api.prefix {ami_yy}
%define api.token.prefix {TOK_}
/* %define api.value.type union */
%param {yyscan_t scanner}{ami2_t *ami}
%define parse.error verbose

%union {
    ami2_ast_node_t *node;
}

%token WORD
%token FUNCTIONNAME
%token STRING
%token VERBATIM
%token EVERYTHING
%token VARIABLE
%token LABEL
%token INTEGER
%token FLOAT
%token AMIVERSION
%token STARTTIME
%token REVISION
%token AUTHOR
%token SHORTDESC
%token DESCRIPTION
%token REFERENCE
%token TAG
%token MESSAGE
%token EQUAL
%token GREATER
%token LESS
%token GREATER_EQUAL
%token LESS_EQUAL
%token MODULO
%token ASSIGN
%token OPENSECTION
%token CLOSESECTION
%token OPENBRACKET
%token CLOSEBRACKET
%token AS
%token REPEAT
%token SLEEP
%token ACTION
%token FIELD
%token EXEC
%token OPENPARENTHESIS
%token CLOSEPARENTHESIS
%token DOT
%token COMMA
%token COLON
%token DEBUGON
%token DEBUGOFF
%token EXIT
%token GOTO
%token PLUS
%token MINUS
%token GROUP
%token FROMGROUP
%token SKIPREPEAT
%token IGNOREGROUPSLEEP
%token SLICEDIVIDER
%token SLICERUN
%token DELETE
%token LOCAL
%token TAXONOMY
%token MATCH
%token NOMATCH

%right EQUAL
%left PLUS MINUS
%left GREATER LESS
%left MODULO

%type <node> declarations declaration localvars localvar
%type <node> action_block expr primary_expr arguments block function
%type <node> statements statement core_action input 
%type <node> array_set array_get matchexprs matchexpr matchblock
%type <node> STRING INTEGER FLOAT VARIABLE FUNCTIONNAME WORD

%%

input: {}
| declarations {
  if (!ami->root) {
     ami->root = ami2_ast_node_new(AMI2_NODE_ROOT);
  }
  ami2_ast_node_append_right(ami->root, $1);
}
;

declarations:   declaration { $$ = $1; }
| declarations declaration { $$ = ami2_ast_node_lr_new(AMI2_NODE_DECLARATION, $1, $2); }
;

declaration: ACTION WORD block {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ACTION, $2, $3);
 }
| REPEAT expr AS VARIABLE block {
  $$ = ami2_ast_node_lr_with_variable_new(AMI2_NODE_REPEAT, $4, $2, $5);
 }
| MATCH VARIABLE matchblock {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_MATCH, $2, $3);
 }
| VARIABLE EQUAL expr {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ASSIGN, $1, $3);
}
| LOCAL VARIABLE EQUAL expr {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ASSIGN_AS_LOCAL, $2, $4);
}
| EXEC WORD {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_EXEC, NULL, $2);
 }
| core_action { $$ = $1; }
;

matchblock: OPENSECTION matchexprs CLOSESECTION {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_MATCH_EXPR, $2, NULL);  
}
;

matchexprs: matchexpr { $$ = ami2_ast_node_append_right(NULL, $1); }
| matchexprs matchexpr { $$ = ami2_ast_node_append_right($2, $1); }
;

matchexpr: STRING block {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_MATCH_EXPR, $1, $2);
 }
| INTEGER block {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_MATCH_EXPR, $1, $2);
 }
| NOMATCH block {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_NOMATCH, NULL, $2);
 }
| MODULO INTEGER block {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_MODULO, $2, $3);
 }
| LESS INTEGER block {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_LESS, $2, $3);
 }
| GREATER INTEGER block {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_GREATER, $2, $3);
 }
| LESS_EQUAL INTEGER block {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_LESS_EQUAL, $2, $3);
 }
| GREATER_EQUAL INTEGER block {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_GREATER_EQUAL, $2, $3);
 }
;

block: OPENSECTION statements CLOSESECTION {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_BLOCK, NULL, $2);
}
;

statements:  statement { $$ =  ami2_ast_node_lr_new(AMI2_NODE_STATEMENT, NULL, $1); }
| statements statement { $$ = ami2_ast_node_lr_new(AMI2_NODE_STATEMENT, $1, $2); }
;

statement: declaration { $$ = $1; } 
;

core_action: WORD expr {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_COREACTION, $1, $2);
 }
;

expr:   primary_expr
      | VARIABLE EQUAL expr {
          $$ = ami2_ast_node_lr_new(AMI2_NODE_ASSIGN, $1, $3); 
}
      | LOCAL VARIABLE EQUAL expr {
          $$ = ami2_ast_node_lr_new(AMI2_NODE_ASSIGN_AS_LOCAL, $2, $4); 
}
      | expr PLUS expr {
          $$ = ami2_ast_node_lr_new(AMI2_NODE_PLUS, $1, $3);
}
      | expr MINUS expr {
          $$ = ami2_ast_node_lr_new(AMI2_NODE_MINUS, $1, $3);
}
      | expr MODULO expr {
          $$ = ami2_ast_node_lr_new(AMI2_NODE_MINUS, $1, $3);
 }
;

primary_expr:   STRING
              | INTEGER
              | FLOAT
              | VARIABLE
              | function
              | array_set
              | array_get
              {
  $$ = $1;
};

arguments: expr { $$ = ami2_ast_node_append_right(NULL, $1); }
| arguments COMMA expr { $$ = ami2_ast_node_append_right($3, $1); }
;

function: FUNCTIONNAME OPENPARENTHESIS arguments CLOSEPARENTHESIS {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_FUNCTION_CALL, $1, $3);
 }
;

array_set: OPENBRACKET arguments CLOSEBRACKET {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ARRAY_SET, NULL, $2);
 }
;

array_get: VARIABLE OPENBRACKET expr CLOSEBRACKET {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ARRAY_GET, $1, $3);
 }
;

%%


void
ami_yyerror (yyscan_t scanner, ami2_t *ami, const char *msg, ...)
{
  (void) scanner;

  if (ami) {
    fprintf(stderr, "AMI Syntax error at %s:%d or just above: ", ami->original_file, ami_yyget_lineno());
  } else {
    fprintf(stderr, "AMI Syntax error line %d: ",  ami_yyget_lineno());
  }
  
  va_list args;
  va_start(args, msg);
  vfprintf(stderr, msg, args);
  va_end(args);
  fputc('\n', stderr);
}

int get_lineno(yyscan_t scanner)
{
  (void) scanner;
  return ami_yyget_lineno();
}
