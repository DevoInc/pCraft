%expect 0
   
%code requires
{
#ifndef YY_TYPEDEF_YY_SCANNER_T
#define YY_TYPEDEF_YY_SCANNER_T 
typedef void *yyscan_t;
#endif

#include <ami/kvec.h>
#include <ami/ami.h>
#include <ami/flow.h>
 
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
%token DEBUGON
%token DEBUGOFF

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
  if (ami->debug) {
    printf("[parse.y](message: MESSAGE STRING): %s\n", $2);
  }
  if (ami->printmessagecb) {
    ami->printmessagecb(strdup($2));
  } else {
    // As we have no callback defined for the print function, we simply print here.
    printf("%s\n", $2);
    /* fprintf(stderr, "*** WARNING: No callback set for the message function!\n"); */
  }
  free($2);
}
;

variable: VARIABLE EQUAL varset {
  int retval;

  if (ami->debug) {
    printf("[parse.y](variable: VARIABLE EQUAL varset): %s\n", $1);
  }

  if (ami->_ast->opened_sections == 0) { // We are in the global scope
    retval = ami_set_global_variable(ami, $1, ami->_ast->current_variable_value);
    if (retval) {
      fprintf(stderr, "Error setting a global variable!\n");
      YYERROR;
    }
    free(ami->_ast->current_variable_value);
  } else {
    retval = ami_set_local_variable(ami, $1, ami->_ast->current_variable_value);
    if (retval) {
      fprintf(stderr, "Error setting a local variable!\n");
      YYERROR;
    }
    free(ami->_ast->current_variable_value);    
  }
  
  /* free($1); */
}
;

varset:   variable_string
        | variable_int
        | variable_function
        | variable_variable
        ;

variable_string: STRING {
  if (ami->debug) {
    printf("[parse.y](variable_string: STRING): %s\n", $1);
  }
  if (ami->_ast->opened_sections == 0) { // We are in the global scope
    ami->_ast->current_variable_value = strdup($1);
  }
  if (ami->_ast->parsing_function) {
    char *arg = strdup($1);
    kv_push(char *, ami->_ast->func_arguments, arg);
  }
 
  free($1);
}
;

variable_int: INTEGER {
  if (ami->debug) {
    printf("[parse.y](variable_int: INTEGER): Set this integer:%d to our variable\n", $1);
  }
}
;

variable_function: function
;

variable_variable: VARIABLE {
    if (ami->debug) {
      printf("[parse.y](variable_variable: VARIABLE): Set FROM this variable %s: ", $1);
    }
}
;

include: INCLUDE STRING {
  if (ami->debug) {
    printf("[parse.y](include: INCLUDE STRING): include from %s\n", $2);
  }
}
;

sleep: SLEEP INTEGER {
  if (ami->debug) {
    printf("[parse.y](sleep: SLEEP INTEGER) Sleeping for %d microseconds\n", $2);
  }
  if (ami->sleepcb) {
    ami->sleepcb($2);
  } else {
    fprintf(stderr, "*** WARNING: No callback set for the sleep function!\n");
  }
}
;

repeat: REPEAT INTEGER AS VARIABLE OPENSECTION {
  if (ami->debug) {
    printf("[parse.y](repeat: REPEAT INTEGER AS VARIABLE OPENSECTION) We repeat %d times and set var to %s\n", $2, $4);
  }
  ami->_ast->repeat = $2;
  ami->_ast->repeat_index_as = strdup($4);  

  ami->_ast->opened_sections++;
  ami->_ast->repeat_block_id = ami->_ast->opened_sections;
  
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
    printf("[parse.y](closesection: CLOSESECTION)\n");
  }
  if (ami->_ast->action_block_id == ami->_ast->opened_sections) {
    // add action
    if (ami->debug) {
      printf("[parse.y] Closing action section\n");
    }
    ami->_ast->action_block_id = 0;
  }
  if (ami->_ast->repeat_block_id == ami->_ast->opened_sections) {
    if (ami->debug) {
      printf("[parse.y] Closing repeat section\n");
    }

    printf("We we now repeat %d times\n", ami->_ast->repeat);
    
    size_t n_array = kv_size(ami->_ast->repeat_flow);
    size_t index = 1;
    while (index <= ami->_ast->repeat) {
      printf("index:%d, n_array:%d\n", index, n_array);
      if (n_array > 0) {
	for (size_t i = 0; i < n_array; i++) {
	  if (ami->debug) {
	    ami_flow_t *flow = kv_A(ami->_ast->repeat_flow, i);
	    printf("flow type:%d\n", flow->type);
	    printf("flow name:%s\n", flow->func_name);
	    size_t args_array = kv_size(flow->func_arguments);
	    if (args_array > 0) {
	      for (size_t i = 0; i < args_array; i++) {
		if (ami->debug) {
		  char *arg = kv_A(flow->func_arguments, i);
		  if (!strcmp(arg, ami->_ast->repeat_index_as)) {
		    asprintf(&arg, "%d", index);
		  }
		  printf("arg %d: %s\n", i, arg);
		}
	      /* if (ami->debug) { */
	      /*   printf("\targ %d: %s\n", i, kv_A(ami->_ast->func_arguments, i)); */
	      /* } */      
	      /* kv_pop(ami->_ast->func_arguments); */
	      }
	    }
	    /* ami_flow_close(flow); */
	  } // ami->debug()
	  
	  /* printf("\targ %d: %s\n", i, ); */
	}      
	/* kv_pop(ami->_ast->func_arguments); */
      }
      index++;
    } // while (index <= n_array)
    ami->_ast->repeat = 0;

    ami_nast_repeat_flow_reset(ami);
    /* kv_destroy(ami->_ast->repeat_flow); */
    /* size_t len_array = kv_size(ami->_ast->repeat_flow); */
    /* if (len_array > 0) { */
    /*   for (size_t i = 0; i < len_array; i++) { */
    /* 	kv_pop(ami->_ast->repeat_flow); */
    /*   }       */
    /* } */
    
    ami->_ast->repeat_block_id = 0;
  }
  
  if (ami->_ast->opened_sections <= 0) {
    fprintf(stderr, "Closing section you did not opened!\n");
    YYERROR;
  }
  ami->_ast->opened_sections--;
  if (ami->_ast->opened_sections == 0) {
    ami_erase_local_variables(ami);
  }
}
;

action: ACTION WORD OPENSECTION {
  if (ami->debug) {
    printf("[parse.y](action: ACTION WORD OPENSECTION): Running action %s\n", $2);
  }
  ami->_ast->opened_sections++;
  ami->_ast->action_block_id = ami->_ast->opened_sections;
}
;

field_function_inline: FIELD OPENBRACKET STRING CLOSEBRACKET DOT function {
  if (ami->debug) {
   printf("[parse.y](field_function_inline: FIELD OPENBRACKET STRING CLOSEBRACKET DOT function): Field %s\n", $3);
  }
}
;

field_assigned_to_variable: FIELD OPENBRACKET STRING CLOSEBRACKET EQUAL varset {
  if (ami->debug) {
    printf("[parse.y](field_assigned_to_variable: FIELD OPENBRACKET STRING CLOSEBRACKET EQUAL varset): Field %s assigned to variable\n", $3);
  }
}
;

exec: EXEC WORD {
  if (ami->debug) {
    printf("[parse.y](exec: EXEC WORD): We execute: %s\n", $2);
  }
  if (ami->_ast->action_block_id != ami->_ast->opened_sections) {
    fprintf(stderr, "Error: exec outside of an action block. Not permitted.\n");
    YYERROR;
  }

}
;

function: WORD OPENPARENTHESIS function_arguments CLOSEPARENTHESIS {
  if (ami->debug) {
    printf("[parse.y](function: WORD OPENPARENTHESIS function_arguments CLOSEPARENTHESIS): Calling function %s\n", $1);

    printf("Arguments to use:\n");
  }

  ami_flow_t *flow = ami_flow_new();
  if (!strcmp("replace", $1)) {
    flow->type = AMI_FT_REPLACE;
    flow->func_name = strdup("replace");    
  } else {
    flow->type = AMI_FT_RUNFUNC;
    flow->func_name = strdup($1);
    kv_copy(char *,flow->func_arguments, ami->_ast->func_arguments);
    kv_push(ami_flow_kvec_t *, ami->_ast->repeat_flow, flow);
  
    size_t n_array = kv_size(ami->_ast->func_arguments);
    if (n_array > 0) {
      for (size_t i = 0; i < n_array; i++) {
	/* if (ami->debug) { */
	/*   printf("\targ %d: %s\n", i, kv_A(ami->_ast->func_arguments, i)); */
	/* } */      
	kv_pop(ami->_ast->func_arguments);
      }
    }
  }
   
  /* ami->_ast->current_variable_value = // Output of that function */
  ami->_ast->parsing_function = 0;
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
    printf("[parse.y](function_argument_assign: STRING ASSIGN varset) WE ASSIGN TO THIS STRING:%s\n", $1);
  }
  ami->_ast->parsing_function = 1;
}
;

function_argument_string: STRING {
  if (ami->debug) {
    printf("[parse.y](function_argument_string: STRING): This is function argument string:%s\n", $1);
  }
  ami->_ast->parsing_function = 1;

  char *arg = strdup($1);
  kv_push(char *, ami->_ast->func_arguments, arg);
  free($1);
}
;

function_argument_int: INTEGER {
  if (ami->debug) {
    printf("[parse.y](function_argument_int: INTEGER): This is function argument int:%d\n", $1);
  }
  ami->_ast->parsing_function = 1;

  /* char *arg = strdup($1); */
  /* kv_pushp(char *, ami->_ast->func_arguments, arg); */
  /* free($1);   */
}
;

function_argument_variable: VARIABLE {
  if (ami->debug) {
    printf("[parse.y](function_argument_variable: VARIABLE): This is the FUNCTION ARGUMENT VARIABLE:%s\n", $1);
  }
  ami->_ast->parsing_function = 1;

  if (strcmp($1, ami->_ast->repeat_index_as)) {
    char *vardata = ami_get_local_variable(ami, $1);
    if (!vardata) {
      vardata = ami_get_global_variable(ami, $1);
    }
    if (!vardata) {
      fprintf(stderr, "No such variable:%s\n", $1);
      YYERROR;
    }
    kv_push(char *, ami->_ast->func_arguments, vardata);
  } else {
    char *arg = strdup($1);
    kv_push(char *, ami->_ast->func_arguments, arg);
  }
  
  free($1);

}
;

function_argument_word_eq_word: WORD EQUAL WORD {
  if (ami->debug) {
    printf("[parse.y](function_argument_word_eq_word: WORD EQUAL WORD): %s = %s\n", $1, $3);
  }
  ami->_ast->parsing_function = 1;

  char *arg = strdup($3);
  kv_push(char *, ami->_ast->func_arguments, arg);

  free($1);
  free($3);
}
;

function_argument_word_eq_string: WORD EQUAL STRING {
  if (ami->debug) {
    printf("[parse.y](function_argument_word_eq_string: WORD EQUAL STRING): %s = %s\n", $1, $3);
  }
  ami->_ast->parsing_function = 1;
}
;

keywords_as_argname: keyword_field
                     ;

keyword_field: FIELD EQUAL varset {
  if (ami->debug) {
    printf("[parse.y](keyword_field: FIELD EQUAL varset): This would be a keyword, but it is not used as a keyword. Simply as an argument. (field)\n");
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

