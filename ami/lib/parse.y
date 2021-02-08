%expect 0
   
%code requires
{
#ifndef YY_TYPEDEF_YY_SCANNER_T
#define YY_TYPEDEF_YY_SCANNER_T 
typedef void *yyscan_t;
#endif

#include <ami/kvec.h>
#include <ami/ami.h>
#include <ami/action.h> 
#include <ami/csvread.h>

#include <unistd.h>

}

%code provides
{

  void ami_yyerror (yyscan_t scanner, ami_t *ami, const char *msg, ...);
  int get_lineno(yyscan_t scanner);
}

%code top
{
#include <stdio.h>
#include <stdarg.h>
#include <string.h>

}

%code
{
  YY_DECL;
}

%define api.pure full
%define api.prefix {ami_yy}
%define api.token.prefix {TOK_}
%define api.value.type union
%param {yyscan_t scanner}{ami_t *ami}
%define parse.error verbose

%token <char *>WORD
%token <char *>FUNCTIONNAME
%token <char *>STRING
%token <char *>VERBATIM
%token <char *>EVERYTHING
%token <char *>GVARIABLE
%token <char *>LVARIABLE
%token <char *>LABEL
%token <int>INTEGER
%token <float>FLOAT
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

%left PLUS MINUS

%type <char *> string
%type <int> variable_expression_int
%type <float> variable_expression_float
%type <int> expression_int
%type <float> expression_float

%%

input:
       | input amiversion
       | input starttime
       | input revision
       | input author
       | input shortdesc
       | input description
       | input reference
       | input tag
       | input message
       | input variable
       | input sleep_varset
       | input repeat
       | input closesection
       | input action
       | input field_function_inline
       | input field_assigned_to_variable
       | input exec
       | input function
       | input keywords_as_argname
       | input debugon
       | input debugoff
       | input exit
       | input _goto
       | input label
       | input string
       | input array
       | input array_item
       | input expression_int
       | input expression_float
       ;


amiversion: AMIVERSION INTEGER
  {
    if (ami->debug) {
      printf("[parse.y] Version:%d\n", $2);
    }
    ami->version = $2;

    /* ami_tree_append_int_no_leaves(ami->tree, AMI_NT_VERSION, $2); */

  }
  ;

starttime: STARTTIME INTEGER
{
  if (ami->debug) {
    printf("[parse.y] Start Time:%d\n", $2);   
  }
  ami->start_time = $2;
}
;

revision: REVISION INTEGER
  {
    if (ami->debug) {
      printf("[parse.y] Revision:%d\n", $2);
    }
    ami->revision = $2;
    /* ami_tree_append_int_no_leaves(ami->tree, AMI_NT_REVISION, $2); */
  }
  ;

author: AUTHOR string {
  if (ami->debug) {
    printf("[parse.y] Author:%s\n", $2);
  }

  ami->author = strdup($2);
  
  free($2);
}
;

shortdesc: SHORTDESC string {
  if (ami->debug) {
    printf("[parse.y] Short Desc:%s\n", $2);  
  }
  ami->shortdesc = strdup($2);

  free($2);
}
;

description: DESCRIPTION string {
  if (ami->debug) {
    printf("[parse.y] Description:%s\n", $2);  
  }
  ami->description = strdup($2);

  free($2);
}
;


reference: REFERENCE string {
  char *ref = strdup($2);
  if (ami->debug) {
    printf("[parse.y](reference: REFERENCE STRING):%s\n", $2);
  }  
  /* kv_push(char *, ami->references, ref); */
  ami_node_create(&ami->root_node, get_lineno(scanner), AMI_NT_REFERENCE, $2, 0, 0, 0);
  
  free($2);
}
;

tag: TAG string {
  if (ami->debug) {
    printf("[parse.y](tag: TAG STRING):%s\n", $2);
  }
  ami_node_create(&ami->root_node, get_lineno(scanner), AMI_NT_TAG, $2, 0, 0, 0);

  free($2);
}
;

message: MESSAGE string {

  ami_append_item(ami, get_lineno(scanner), AMI_NT_MESSAGE, $2, 0, 0, 0);

  /* if (ami->debug) { */
  /*   printf("[parse.y](message: MESSAGE STRING): %s\n", $2); */
  /* } */
  /* if (ami->printmessagecb) { */
  /*   ami->printmessagecb(strdup($2)); */
  /* } else { */
  /*   // As we have no callback defined for the print function, we simply print here. */
  /*   printf("%s\n", $2); */
  /*   /\* fprintf(stderr, "*** WARNING: No callback set for the message function!\n"); *\/ */
  /* } */
  free($2);
}
;

variable: GVARIABLE EQUAL varset {
  if (ami->debug) {
    printf("[parse.y] variable: GVARIABLE(%s) EQUAL varset\n", $1);
  }

   /* ami_node_create(&ami->root_node, AMI_NT_VARNAME, $1, 0); */
  ami_append_item(ami, get_lineno(scanner), AMI_NT_VARNAME, $1, 0, 0, 0);
  
  free($1);
 }
 | LVARIABLE EQUAL varset {
   if (ami->debug) {
    printf("[parse.y] variable: LVARIABLE(%s) EQUAL varset\n", $1);
   }

   if (!ami->_action_block_id) {
     fprintf(stderr, "Error with variable %s: it must be local to an action.\n", $1);
     exit(1);
   }

   ami_append_item(ami, get_lineno(scanner), AMI_NT_LOCALVARNAME, $1, 0, 0, 0);

  free($1);
 }
;

varset:   variable_string
        | variable_expression_int
        | variable_expression_float
        | variable_function
        | variable_variable
        | variable_array
        ;

variable_string: string {
  if (ami->debug) {
    printf("[parse.y] variable_string: STRING(%s)\n", $1);
  }  
    
  ami_append_item(ami, get_lineno(scanner), AMI_NT_VARVALSTR, $1, 0, 0, 0);
  
  free($1);
}
;


variable_function: function {
  if (ami->debug) {
    printf("[parse.y] variable_function: function\n");
  }

  /* ami_append_item(ami, AMI_NT_FUNCTION, NULL, 0); */

}
;

variable_variable: GVARIABLE {
    if (ami->debug) {
      printf("[parse.y] variable_variable: GVARIABLE(%s)\n", $1);
    }

    
    ami_append_item(ami, get_lineno(scanner), AMI_NT_VARVAR, $1, 0, 0, 0);

    free($1);
}
;

variable_array:   array
                | array_item
                ;

variable_expression_int: expression_int {
  ami_append_item(ami, get_lineno(scanner), AMI_NT_VARVALINT, NULL, $1, 0, 0);
  $$ = $1;
 }
;

variable_expression_float: expression_float {
  ami_append_item(ami, get_lineno(scanner), AMI_NT_VARVALFLOAT, NULL, 0, $1, 0);

  $$ = $1;
 }
;


sleep_varset: SLEEP varset {
  if (ami->debug) {
    printf("[parse.y] sleep: SLEEP varset\n");
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_SLEEP, NULL, 0, 0, 0);
}
;


repeat: REPEAT varset AS GVARIABLE OPENSECTION {
  if (ami->debug) {
    printf("[parse.y] repeat: REPEAT varset AS GVARIABLE(%s) OPENSECTION)\n", $4);
  }

  ami->_opened_sections++;
  ami->_repeat_block_id = ami->_opened_sections;

  ami_append_repeat(ami, get_lineno(scanner), AMI_NT_REPEAT, $4, 0, 0, 0);
  
  free($4);
  }
;

closesection: CLOSESECTION {
  if (ami->debug) {
    printf("[parse.y] closesection: CLOSESECTION\n");
  }

  if (ami->_action_block_id == ami->_opened_sections) {
    if (ami->debug) {
      printf("[parse.y] Closing Action Block\n");
    }
    ami_append_item(ami, get_lineno(scanner), AMI_NT_ACTIONCLOSE, NULL, 0, 0, 0);
  }

  if (ami->_repeat_block_id == ami->_opened_sections) {
    if (ami->debug) {
      printf("[parse.y] Closing Repeat Block\n");
    }
    /* printf("We close the repeat that has block id:%d\n", ami->_repeat_block_id); */
    ami->_repeat_block_id = 0;
    ami_append_item(ami, get_lineno(scanner), AMI_NT_REPEATCLOSE, NULL, 0, 0, 0);
  }
  
  ami->_opened_sections--;

  
}
;

action: ACTION WORD OPENSECTION {
  if (ami->debug) {
    printf("[parse.y] action: ACTION WORD(%s) OPENSECTION\n", $2);
  }

  ami->_opened_sections++;
  ami->_action_block_id = ami->_opened_sections;

  ami_append_item(ami, get_lineno(scanner), AMI_NT_ACTION, $2, 0, 0, 0);
  /* ami_node_create(&ami->root_node, AMI_NT_ACTION, $2, 0); */
  
  free($2);
}
;

field_function_inline: FIELD OPENBRACKET string CLOSEBRACKET DOT function {
  if (ami->debug) {
   printf("[parse.y] field_function_inline: FIELD OPENBRACKET STRING(%s) CLOSEBRACKET DOT function\n", $3);
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_FIELDFUNC, $3, 0, 0, 0);
  
  free($3);
}
;

field_assigned_to_variable: FIELD OPENBRACKET string CLOSEBRACKET EQUAL varset {
  if (ami->debug) {
    printf("[parse.y] field_assigned_to_variable: FIELD OPENBRACKET STRING(%s) CLOSEBRACKET EQUAL varset\n", $3);
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_FIELDVAR, $3, 0, 0, 0);

 }
;

exec: EXEC WORD {
  if (ami->debug) {
    printf("[parse.y] exec: EXEC WORD(%s)\n", $2);
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_EXEC, $2, 0, 0, 0);
  
  free($2);
}
;

function: FUNCTIONNAME OPENPARENTHESIS function_arguments CLOSEPARENTHESIS {
  if (ami->debug) {
    printf("[parse.y] function: FUNCTIONNAME(%s) OPENPARENTHESIS function_arguments CLOSEPARENTHESIS\n", $1);
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_FUNCTION, $1, ami->arguments_count, 0, 0);

  ami->arguments_count = 0;
  
  free($1);
}
| WORD OPENPARENTHESIS function_arguments CLOSEPARENTHESIS {
  if (ami->debug) {
    printf("[parse.y] function: WORD(%s) OPENPARENTHESIS function_arguments CLOSEPARENTHESIS\n", $1);
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_FUNCTION, $1, ami->arguments_count, 0, 0);

  ami->arguments_count = 0;
  
  free($1);
}
;

function_arguments:   function_argument
                    | function_arguments COMMA function_argument
{
  // done parsing function arguments.
}
                    ;

/* function_argument: variable <- Why variable?
                      | function_argument_variable */

function_argument: function_argument_variable
                   | function_argument_string
                   | function_argument_int
                   | function_argument_word_eq_string
                   | function_argument_word_eq_int
                   | function_argument_assign
                   | keywords_as_argname
                   | function
                   ;

function_argument_assign: string ASSIGN varset {
  if (ami->debug) {
    printf("[parse.y] function_argument_assign: STRING(%s) ASSIGN varset\n", $1);
  }

  ami->arguments_count++;
  
  ami_append_item(ami, get_lineno(scanner), AMI_NT_REPLACE, $1, 0, 0, 0);
  
  free($1);
}
;

function_argument_string: string {
  if (ami->debug) {
    printf("[parse.y] function_argument_string: STRING(%s)\n", $1);
  }

  ami->arguments_count++;
  
  ami_append_item(ami, get_lineno(scanner), AMI_NT_VARVALSTR, $1, 0, 0, 0);

  free($1);
}
;

function_argument_int: INTEGER {
  if (ami->debug) {
    printf("[parse.y] function_argument_int: INTEGER(%d)\n", $1);
  }

  ami->arguments_count++;

  
  ami_append_item(ami, get_lineno(scanner), AMI_NT_VARVALINT, NULL, $1, 0, 0);
}
;

function_argument_variable: GVARIABLE {
  if (ami->debug) {
    printf("[parse.y] function_argument_variable: GVARIABLE(%s)\n", $1);
  }

  ami->arguments_count++;
  
  ami_append_item(ami, get_lineno(scanner), AMI_NT_VARVAR, $1, 0, 0, 0);
  
  free($1);
}
;

function_argument_word_eq_string: WORD EQUAL string {
  if (ami->debug) {
    printf("[parse.y] function_argument_word_eq_string: WORD(%s) EQUAL STRING(%s)\n", $1, $3);
  }

  ami->arguments_count++;
  
  ami_append_item(ami, get_lineno(scanner), AMI_NT_VARVALSTR, $3, 0, 0, 0);
  
  free($1);
  free($3);
}
;

function_argument_word_eq_int: WORD EQUAL INTEGER {
  if (ami->debug) {
    printf("[parse.y] function_argument_word_eq_int: WORD(%s) EQUAL INTEGER(%d)\n", $1, $3);
  }

  ami->arguments_count++;
  
  ami_append_item(ami, get_lineno(scanner), AMI_NT_VARVALINT, NULL, $3, 0, 0);
  
  free($1);
}
;

keywords_as_argname: keyword_field
                     ;

keyword_field: FIELD EQUAL varset {
  if (ami->debug) {
    printf("[parse.y] keyword_field: FIELD EQUAL varset: This would be a keyword, but it is not used as a keyword. Simply as an argument. (field)\n");
  }  
  
}
;

debugon: DEBUGON {
  ami->debug = 1;
}
;

debugoff: DEBUGOFF {
  ami->debug = 0;
}
;

exit: EXIT {
  fprintf(stderr, "Exiting. As it was requested from the script!\n");
  exit(1);
}
;

_goto: GOTO WORD {
  if (ami->debug) {
    printf("[parse.y] GOTO WORD(%s)\n", $2);
  }
  free($2);
}
;

label: LABEL {
  if (ami->debug) {
    printf("[parse.y] LABEL(%s)\n", $1);
  }
  free($1);
}
;

string: STRING {
  ami->_is_verbatim_string = 0;
  $$ = $1;
 }
| VERBATIM {
  ami->_is_verbatim_string = 1;
  $$ = $1;
 }
 ;

array: GVARIABLE EQUAL OPENBRACKET function_arguments CLOSEBRACKET {
  if (ami->debug) {
    printf("[parse.y] array[...]\n");
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_ARRAYVAR, $1, ami->arguments_count, 0, 0);

  ami->arguments_count = 0;
  
 }
| LVARIABLE EQUAL OPENBRACKET function_arguments CLOSEBRACKET {
  if (ami->debug) {
    printf("[parse.y] array[...]\n");
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_ARRAYVAR, $1, ami->arguments_count, 0, 0);
  
  ami->arguments_count = 0;
  
 }
 ;

array_item: GVARIABLE OPENBRACKET varset CLOSEBRACKET {
  if (ami->debug) {
    printf("[parse.y] array_item[varset]\n");
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_ARRAYGET, $1, 0, 0, 0);
  
 }
| LVARIABLE OPENBRACKET varset CLOSEBRACKET {
  if (ami->debug) {
    printf("[parse.y] array_item[varset]\n");
  }

  ami_append_item(ami, get_lineno(scanner), AMI_NT_ARRAYGET, $1, 0, 0, 0);  
 }
 ;

expression_int: INTEGER { $$ = $1; }
          | expression_int PLUS expression_int { $$ = $1 + $3; }
          | expression_int MINUS expression_int { $$ = $1 - $3; }
;

expression_float: FLOAT { $$ = $1; }
          | expression_float PLUS expression_float { $$ = $1 + $3; }
          | expression_float MINUS expression_float { $$ = $1 - $3; }
;
%%


void
ami_yyerror (yyscan_t scanner, ami_t *ami, const char *msg, ...)
{
  (void) scanner;

  fprintf(stderr, "AMI Syntax error with line %d or just above: ", ami_yyget_lineno());
  
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
