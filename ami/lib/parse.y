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
#include <ami/flow.h>
#include <ami/csvread.h>
#include <ami/nast.h>
 
#include <unistd.h>

}

%code provides
{
/* #define YY_DECL       \ */
/*   ami_yytoken_kind_t yylex(YYSTYPE *yylval, yyscan_t yyscanner, scanres_t *res) */
/*   YY_DECL; */

  void ami_yyerror (yyscan_t scanner, ami_t *ami, const char *msg, ...);
}

%code top
{
#include <stdio.h>
#include <stdarg.h>
}


%define api.pure full
%define api.prefix {ami_yy}
%define api.token.prefix {TOK_}
%define api.value.type union
%param {yyscan_t scanner}{ami_t *ami}
%define parse.error verbose

%token <char *>WORD
%token <char *>STRING
%token <char *>EVERYTHING
%token <char *>VARIABLE
%token <char *>LABEL
%token <int>INTEGER
%token AMIVERSION
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
%token INCLUDE
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

%%

input:
       | input amiversion
       | input revision
       | input author
       | input shortdesc
       | input reference
       | input tag
       | input message
       | input variable
       | input include
       | input sleep
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
       ;


amiversion: AMIVERSION INTEGER
  {
    if (ami->debug) {
      printf("[parse.y] Version:%d\n", $2);
    }
    ami->version = $2;
  }
  ;

revision: REVISION INTEGER
  {
    if (ami->debug) {
      printf("[parse.y] Revision:%d\n", $2);
    }
    ami->revision = $2;
  }
  ;

author: AUTHOR STRING {
  if (ami->debug) {
    printf("[parse.y] Author:%s\n", $2);
  }

  ami->author = strdup($2);
  
  free($2);
}
;

shortdesc: SHORTDESC STRING {
  if (ami->debug) {
    printf("[parse.y] Short Desc:%s\n", $2);  
  }
  ami->shortdesc = strdup($2);

  free($2);
}
;

reference: REFERENCE STRING {
  char *ref = strdup($2);
  if (ami->debug) {
    printf("[parse.y](reference: REFERENCE STRING):%s\n", $2);
  }  
  kv_push(char *, ami->references, ref);
  
  free($2);
}
;

tag: TAG WORD {
  if (ami->debug) {
    printf("[parse.y](tag: TAG WORD):%s\n", $2);
  }
  ami->tag = strdup($2);
  free($2);
}
;

message: MESSAGE STRING {
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

variable: VARIABLE EQUAL varset {
  if (ami->debug) {
    printf("[parse.y] variable: VARIABLE(%s) EQUAL varset\n", $1);
  }
  
  free($1);
}
;

varset:   variable_string
        | variable_int
        | variable_function
        | variable_variable
        ;

variable_string: STRING {
  if (ami->debug) {
    printf("[parse.y] variable_string: STRING(%s)\n", $1);
  }
 
  free($1);
}
;

variable_int: INTEGER {
  if (ami->debug) {
    printf("[parse.y] variable_int: INTEGER(%d)\n", $1);
  }
}
;

variable_function: function {
  if (ami->debug) {
    printf("[parse.y] variable_function: function\n");
  }

 }
;

variable_variable: VARIABLE {
    if (ami->debug) {
      printf("[parse.y] variable_variable: VARIABLE(%s)\n", $1);
    }
    free($1);
}
;

include: INCLUDE STRING {
  if (ami->debug) {
    printf("[parse.y] include: INCLUDE STRING(%s)\n", $2);
  }
  free($2);
}
;

sleep: SLEEP INTEGER {
  if (ami->debug) {
    printf("[parse.y] sleep: SLEEP INTEGER(%d)\n", $2);
  }
}
;

repeat: REPEAT INTEGER AS VARIABLE OPENSECTION {
  if (ami->debug) {
    printf("[parse.y] repeat: REPEAT INTEGER(%d) AS VARIABLE(%s) OPENSECTION)\n", $2, $4);
  }
  
  free($4);
}
;

/* opensection: OPENSECTION { */
/*   if (ami->debug) { */
/*     printf("[parse.y](opensection: OPENSECTION)\n"); */
/*   } */
/*   ami->_ast->opened_sections++; */
/* } */
/* ; */

closesection: CLOSESECTION {
  if (ami->debug) {
    printf("[parse.y] closesection: CLOSESECTION\n");
  }
}
;

action: ACTION WORD OPENSECTION {
  if (ami->debug) {
    printf("[parse.y] action: ACTION WORD(%s) OPENSECTION\n", $2);
  }

  free($2);
}
;

field_function_inline: FIELD OPENBRACKET STRING CLOSEBRACKET DOT function {
  if (ami->debug) {
   printf("[parse.y] field_function_inline: FIELD OPENBRACKET STRING(%s) CLOSEBRACKET DOT function\n", $3);
  }

  free($3);
}
;

field_assigned_to_variable: FIELD OPENBRACKET STRING CLOSEBRACKET EQUAL varset {
  if (ami->debug) {
    printf("[parse.y] field_assigned_to_variable: FIELD OPENBRACKET STRING(%s) CLOSEBRACKET EQUAL varset\n", $3);
  }
}
;

exec: EXEC WORD {
  if (ami->debug) {
    printf("[parse.y] exec: EXEC WORD(%s)\n", $2);
  }
  
  free($2);
}
;

function: WORD OPENPARENTHESIS function_arguments CLOSEPARENTHESIS {
  if (ami->debug) {
    printf("[parse.y] function: WORD(%s) OPENPARENTHESIS function_arguments CLOSEPARENTHESIS\n", $1);
  }
  
  free($1);
}
;

function_arguments:   function_argument
                    | function_arguments COMMA function_argument
                    ;

function_argument:   variable
                   | function_argument_variable
                   | function_argument_string
                   | function_argument_int
                   | function_argument_word_eq_string
                   | function_argument_word_eq_word
                   | function_argument_assign
                   | keywords_as_argname
                   ;

function_argument_assign: STRING ASSIGN varset {
  if (ami->debug) {
    printf("[parse.y] function_argument_assign: STRING(%s) ASSIGN varset\n", $1);
  }
  free($1);
}
;

function_argument_string: STRING {
  if (ami->debug) {
    printf("[parse.y] function_argument_string: STRING(%s)\n", $1);
  }
  free($1);
}
;

function_argument_int: INTEGER {
  if (ami->debug) {
    printf("[parse.y] function_argument_int: INTEGER(%d)\n", $1);
  }
}
;

function_argument_variable: VARIABLE {
  if (ami->debug) {
    printf("[parse.y] function_argument_variable: VARIABLE(%s)\n", $1);
  }
  free($1);

}
;

function_argument_word_eq_word: WORD EQUAL WORD {
  if (ami->debug) {
    printf("[parse.y] function_argument_word_eq_word: WORD(%s) EQUAL WORD(%s)\n", $1, $3);
  }

  free($1);
  free($3);
}
;

function_argument_word_eq_string: WORD EQUAL STRING {
  if (ami->debug) {
    printf("[parse.y] function_argument_word_eq_string: WORD(%s) EQUAL STRING(%s)\n", $1, $3);
  }

  free($1);
  free($3);
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

%%


void
ami_yyerror (yyscan_t scanner, ami_t *ami, const char *msg, ...)
{
  (void) scanner;

  fprintf(stderr, "ami_yyerror: ");
  
  va_list args;
  va_start(args, msg);
  vfprintf(stderr, msg, args);
  va_end(args);
  fputc('\n', stderr);
}

