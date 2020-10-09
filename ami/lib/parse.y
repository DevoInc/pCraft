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
    printf("[parse.y] variable: VARIABLE(%s) EQUAL varset\n", $1);
  }
  
  if (ami->_ast->opened_sections == 0) { // We are in the global scope
    char *val = nast_get_current_variable_value(ami->_ast);
    retval = ami_set_global_variable(ami, $1, val);
    if (retval) {
      fprintf(stderr, "Error setting a global variable!\n");
      YYERROR;
    }
    /* free(ami->_ast->current_variable_value); */
  } else {
    // FIXME: for now it is set to global but shall be restained
    char *val = nast_get_current_variable_value(ami->_ast);
    retval = ami_set_global_variable(ami, $1, val);
    if (retval) {
      fprintf(stderr, "Error setting a global variable!\n");
      YYERROR;
    }
      /* printf("Setting a local variable for %s\n", $1); */
      /* retval = ami_set_local_variable(ami, $1, ami->_ast->current_variable_value); */
      /* if (retval) { */
      /* 	fprintf(stderr, "Error setting a local variable!\n"); */
      /* 	YYERROR; */
      /* } */
    
    ami_flow_t *flow = ami_flow_new();
    flow->type = AMI_FT_SETVAR;
    flow->var_name = strdup($1);
    
    if (ami->_ast->var_value_from_function) {
      // If this variable is from a function, it is dynamic and must not be set here.
      flow->var_for_repeat = 1;
    } else {
      flow->var_value = strdup(nast_get_current_variable_value(ami->_ast));
      flow->var_for_repeat = 0;
    }
    kv_push(ami_flow_kvec_t *, ami->_ast->repeat_flow, flow);
    
    /* #if 0 */
    /* retval = ami_set_local_variable(ami, $1, ami->_ast->current_variable_value); */
    /* if (retval) { */
    /*   fprintf(stderr, "Error setting a local variable!\n"); */
    /*   YYERROR; */
    /* } */
    /* free(ami->_ast->current_variable_value); */
    /* if (ami->_ast->repeat_block_id == ami->_ast->opened_sections) { */
    /*   printf("We set a variable in a repeat block\n"); */
    /*   /\* ami->_ast->current_flow = ami_flow_new(); *\/ */
    /*   ami_flow_t *flow = ami_flow_new(); */
    /*   flow->type = AMI_FT_SETVAR; */
    /*   /\* if (ami->_ast->static_var) { *\/ */
    /*   if (!flow->var_for_repeat) { */
    /* 	flow->var_value = strdup(ami->_ast->current_variable_value); */
    /*   } */
    /*   /\* } *\/ */
    /*   kv_push(ami_flow_kvec_t *, ami->_ast->repeat_flow, flow); */

    /* } */
    /* #endif */
    
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
    printf("[parse.y] variable_string: STRING(%s)\n", $1);
  }
  ami->_ast->var_value_from_function = 0;

  if (ami->_ast->opened_sections == 0) { // We are in the global scope
    nast_set_current_variable_value(ami->_ast, $1);
  }
  if (ami->_ast->parsing_function) {
    /* printf("I am in parsing function\n"); */
    char *arg = strdup($1);
    kv_push(char *, ami->_ast->func_arguments, arg);
  } else {
    ami->_ast->static_var = 1;
    nast_set_current_variable_value(ami->_ast, $1);
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
  ami->_ast->var_value_from_function = 1;
 }
;

variable_variable: VARIABLE {
    if (ami->debug) {
      printf("[parse.y] variable_variable: VARIABLE(%s)\n", $1);
    }
    /* flow->replace_with = $1; */
    char *arg = strdup($1);
    kv_push(char *, ami->_ast->replace_val, arg);
    free($1);
}
;

include: INCLUDE STRING {
  if (ami->debug) {
    printf("[parse.y] include: INCLUDE STRING(%s)\n", $2);
  }
}
;

sleep: SLEEP INTEGER {
  if (ami->debug) {
    printf("[parse.y] sleep: SLEEP INTEGER(%d)\n", $2);
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
    printf("[parse.y] repeat: REPEAT INTEGER(%d) AS VARIABLE(%s) OPENSECTION)\n", $2, $4);
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
    printf("[parse.y] closesection: CLOSESECTION\n");
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
      printf("[parse.y] Closing repeat section. We now repeat %d times\n", ami->_ast->repeat);
    }
    
    size_t n_array = kv_size(ami->_ast->repeat_flow);
    size_t index = 1;
    char *retval;
    int retint;
    while (index <= ami->_ast->repeat) {
      /* printf("index:%d, n_array:%d\n", index, n_array); */
      if (n_array > 0) {
	for (size_t i = 0; i < n_array; i++) {
	    ami_flow_t *flow = kv_A(ami->_ast->repeat_flow, i);
	    switch(flow->type) {
	    case AMI_FT_RUNFUNC:
	      ami_flow_function_replace_argument_for_repeat_as(flow, ami->_ast->repeat_index_as, index);
	      if (ami->debug) {
		ami_flow_debug(flow);
	      }
	      if (!strcmp(flow->func_name, "csv")) {		
		if (kv_size(flow->func_arguments) != 4) {
		  fprintf(stderr, "Not enough arguments for the CSV function. Expected 4, got %d\n", kv_size(flow->func_arguments));
		  YYERROR;
		}
		int line_in_csv = (int)strtod(kv_A(flow->func_arguments, 1), NULL);
		int header = 0;
		if (!strcmp(kv_A(flow->func_arguments, 3), "true")) {
		  header = 1;
		}
		
		retval = ami_csvread_get_field_at_line(kv_A(flow->func_arguments, 0), // filename
						       line_in_csv,                   // line to get
						       kv_A(flow->func_arguments, 2), // field name
						       header);                       // this CSV has a header (mandatory for now)
		if (!retval) {
		  fprintf(stderr, "The CSV function could not be run!\n");
		  YYERROR;
		}
		if (ami->debug) {
		  printf("We set our value from our CSV:%s\n", retval);
		}
		nast_set_current_variable_value(ami->_ast, retval);
	      }
	      break; // AMI_FT_RUNFUNC
	    case AMI_FT_SETVAR:
	      if (ami->debug) {
		printf("case AMI_FT_SETVAR\n");
	      }
	      retint = ami_set_global_variable(ami, flow->var_name, nast_get_current_variable_value(ami->_ast));
	      if (retint) {
		fprintf(stderr, "Error setting a local variable!\n");
		YYERROR;
	      }
	      if (flow->var_for_repeat) {
	      	flow->var_value = strdup(nast_get_current_variable_value(ami->_ast));
		/* printf("******** VARNAME:%s\n", flow->var_name); */
		/* retval = ami_set_global_variable(ami, flow->var_name, flow->var_value);		 */
	      }
	      ami_set_local_variable(ami, flow->var_name, flow->var_value);
	      if (ami->debug) {
		ami_flow_debug(flow);
	      }
	      ami_flow_close(flow);
	      break;
	    case AMI_FT_ACTION: // we start an action
	      /* printf("This is an action flow\n"); */
	      if (ami->debug) {
		ami_flow_debug(flow);
	      }
	      break;
	    case AMI_FT_CLOSEACTION:
	      if (ami->debug) {
		printf("Action to execute:%s\n", ami->_ast->action_exec);
		ami_flow_debug(flow);
	      }
	      ami_action_t *action = ami_action_new();
	      action->name = strdup(ami->_ast->action_name);
	      action->exec = strdup(ami->_ast->action_exec);
	      action->replace_field = strdup(ami->_ast->action_replace_field);
	      /* free(ami->_ast->action_replace_field); */
	      ami_action_copy_variables(ami, action);
	      ami_action_copy_replacements(ami, action);
	      // run the callback
	      if (!ami) {
		fprintf(stderr, "No AMI object!\n");
		YYERROR;
	      }
	      if (ami->action_cb) {
		ami->action_cb(action, ami->action_cb_userdata);
	      } else {
		fprintf(stderr, "*** WARNING: No action callback set!\n");
	      }
	      if (ami->debug) {
		ami_action_debug(ami, action);
	      }  
	      ami_action_close(action);

	      if (n_array == ami->_ast->repeat) {
	      	fprintf(stderr, "*****We are DONE repeating!\n");
	      }

	      if (index == ami->_ast->repeat) {
		if (ami->debug) {
		  printf("We are done repeating those actions!\n");
		}
		/* ami_flow_close(ami->_ast->repeat_flow); */
	      }
	      /* printf("N_ARRAY:%d\n", n_array); */
	      /* kv_push(ami_flow_kvec_t *, ami->_ast->repeat_flow, flow); */
	      /* ami->_ast->repeat_index_as) */
	      
	      break;
	    case AMI_FT_REPLACE:
	      flow->replace_field = nast_get_current_field_value(ami->_ast);
	      if (ami->debug) {
		ami_flow_debug(flow);
	      }
	      size_t repl_array = kv_size(ami->_ast->replace_key);
	      if (repl_array > 0) {
		for (size_t i = 0; i< repl_array; i++) {
		  char *key = kv_A(ami->_ast->replace_key, i);
		  char *value = kv_A(ami->_ast->replace_val, i);

		  if (strlen(value) > 0) {
		    if (value[0] == '$') {
		      value = ami_get_global_variable(ami, value);
		    }		    
		  }
		  if (ami->debug) {
		    printf("** replace %s with %s\n", key, value);
		  }
		}
	      }

	      /* printf("This is a replace flow\n"); */
	      break;
	    default:
	      printf("Unknown handled flow\n");
	      break;
	    }
	    
	      /* kv_pop(ami->_ast->func_arguments); */
	  /* } */
	    /* } */
	    /* ami_flow_close(flow); */
	  /* printf("\targ %d: %s\n", i, ); */
	/* kv_pop(ami->_ast->func_arguments); */
	}
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

  ami->_ast->in_action = 0;
  ami_flow_t *flow = ami_flow_new();
  flow->type = AMI_FT_CLOSEACTION;
  kv_push(ami_flow_kvec_t *, ami->_ast->repeat_flow, flow);
  
  if (ami->_ast->opened_sections <= 0) {
    fprintf(stderr, "Closing section you did not opened!\n");
    YYERROR;
  }
  ami->_ast->opened_sections--;
  /* if (ami->_ast->opened_sections == 0) { */
  /*   ami_erase_local_variables(ami); */
  /* } */
}
;

action: ACTION WORD OPENSECTION {
  if (ami->debug) {
    printf("[parse.y] action: ACTION WORD(%s) OPENSECTION\n", $2);
  }
  ami->_ast->opened_sections++;
  ami->_ast->action_block_id = ami->_ast->opened_sections;
  ami->_ast->in_action = 1;

  ami_flow_t *flow = ami_flow_new();
  flow->type = AMI_FT_ACTION;
  flow->action_name = strdup($2);
  ami->_ast->action_name = strdup($2);
  kv_push(ami_flow_kvec_t *, ami->_ast->repeat_flow, flow);

  free($2);
}
;

field_function_inline: FIELD OPENBRACKET STRING CLOSEBRACKET DOT function {
  if (ami->debug) {
   printf("[parse.y] field_function_inline: FIELD OPENBRACKET STRING(%s) CLOSEBRACKET DOT function\n", $3);
  }
  nast_set_current_field_value(ami->_ast, $3);
  ami->_ast->action_replace_field = strdup($3);
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
  if (ami->_ast->action_block_id != ami->_ast->opened_sections) {
    fprintf(stderr, "Error: exec outside of an action block. Not permitted.\n");
    YYERROR;
  }

  ami->_ast->action_exec = strdup($2);
  
  free($2);
}
;

function: WORD OPENPARENTHESIS function_arguments CLOSEPARENTHESIS {
  if (ami->debug) {
    printf("[parse.y] function: WORD(%s) OPENPARENTHESIS function_arguments CLOSEPARENTHESIS\n", $1);
  }
  
  ami_flow_t *flow = ami_flow_new();
  if (!strcmp("replace", $1)) {
    flow->type = AMI_FT_REPLACE;
    flow->func_name = strdup("replace");
    kv_push(ami_flow_kvec_t *, ami->_ast->repeat_flow, flow);    
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
  ami->_ast->parsing_function = 1;

  char *arg = strdup($1);
  kv_push(char *, ami->_ast->replace_key, arg);
  free($1);
}
;

function_argument_string: STRING {
  if (ami->debug) {
    printf("[parse.y] function_argument_string: STRING(%s)\n", $1);
  }
  ami->_ast->parsing_function = 1;

  char *arg = strdup($1);
  kv_push(char *, ami->_ast->func_arguments, arg);
  free($1);
}
;

function_argument_int: INTEGER {
  if (ami->debug) {
    printf("[parse.y] function_argument_int: INTEGER(%d)\n", $1);
  }
  ami->_ast->parsing_function = 1;

  /* char *arg = strdup($1); */
  /* kv_pushp(char *, ami->_ast->func_arguments, arg); */
  /* free($1);   */
}
;

function_argument_variable: VARIABLE {
  if (ami->debug) {
    printf("[parse.y] function_argument_variable: VARIABLE(%s)\n", $1);
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
    printf("[parse.y] function_argument_word_eq_word: WORD(%s) EQUAL WORD(%s)\n", $1, $3);
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
    printf("[parse.y] function_argument_word_eq_string: WORD(%s) EQUAL STRING(%s)\n", $1, $3);
  }
  ami->_ast->parsing_function = 1;

  free($1);
  free($3);
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

exit: EXIT {
  exit(1);
}
;

_goto: GOTO LABEL {
  if (ami->debug) {
    printf("[parse.y] GOTO LABEL(%s)\n", $2);
  }
  free($2);
}
;

label: LABEL COLON {
  if (ami->debug) {
    printf("[parse.y] LABEL(%s) COLON\n", $1);
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

