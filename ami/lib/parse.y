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

%type <node> action_block expr primary_expr function function_arguments
%type <node> statements core_action input
%type <node> STRING INTEGER FLOAT VARIABLE FUNCTIONNAME WORD

%%

input: 
       | input action_block {
             if (!ami->root) {
	       ami->root = ami2_ast_node_new(AMI2_NODE_ROOT);
	     }
	     ami2_ast_node_append_right(ami->root, $2);
       }
       | input statements {
             if (!ami->root) {
	       ami->root = ami2_ast_node_new(AMI2_NODE_ROOT);
	     }
	     ami2_ast_node_append_right(ami->root, $2);
       }
       | input core_action {
             if (!ami->root) {
	       ami->root = ami2_ast_node_new(AMI2_NODE_ROOT);
	     }
	     ami2_ast_node_append_right(ami->root, $2);
       }
       ;

statements: VARIABLE EQUAL expr {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ASSIGN, $1, $3);
}
| VARIABLE EQUAL function {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ASSIGN, $1, $3);
 }
| LOCAL VARIABLE EQUAL expr {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ASSIGN_AS_LOCAL, $2, $4);
}
| LOCAL VARIABLE EQUAL function {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ASSIGN_AS_LOCAL, $2, $4);  
}
;

core_action: WORD expr {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_COREACTION, $1, $2);
 }
            | WORD function {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_COREACTION, $1, $2);
}
;

expr:   primary_expr
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
              {
  $$ = $1;
};

function: FUNCTIONNAME OPENPARENTHESIS function_arguments CLOSEPARENTHESIS {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_FUNCTION_CALL, $1, NULL);
  ami2_ast_node_append_right($$, $3);  
 }
;

function_arguments:   expr 
                    | function_arguments COMMA expr
{
  ami2_ast_node_append_right($$, $3);
  /* $$ = $3; */
}
;

action_block: ACTION WORD OPENSECTION statements CLOSESECTION {
  $$ = ami2_ast_node_lr_new(AMI2_NODE_ACTION, $2, $4);
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
