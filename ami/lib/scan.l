%option nodefault noinput nounput noyywrap nounistd
%option reentrant bison-bridge
%option prefix="ami_yy"
%option yylineno

%x incl

%{
#define YYSTYPE AMI_YYSTYPE

#include <parse.h>
#include <libgen.h>

#include <ami/ami.h>

static char *filename;
static char *realfile;

char verbatim_buf[8192];
int vbindex;

char verbasub_buf[8192];
int vbsubindex;


#define YY_DECL yylex(YYSTYPE * yylval_param, yyscan_t yyscanner, ami_t *ami)

static char *get_include_file(ami_t *ami, const char *str) {
        char *dname, *da, *result;

        if (!str) {
              return NULL;
        }

        if (strlen(str) <= 0) {
              return NULL;
        }

        if (!ami) {
                printf("ami is null!\n");
                return NULL;
        }

        switch(str[0]) {
                case '/':
                        return strdup(str);
                break;
                default:
	                da = strdup(ami->file);
	                dname = dirname(da);
	                asprintf(&result,"%s/%s", dname, str);
                        free(da);
                        return result;
                break;
        }

        return NULL;

}

int consume_multiline_comments(char *str) {
// The reason for this is to increase the line count for each line return
// so we can give the proper error line.
    const char *s = str;
    char c;
    int ret;
    for (ret = 0; (c = *s); s++) {
        if (c == '\n') { ret++; }                                                                                                                       
    }
    return ret;                                                                                                                                          
}

char *escape_string(char *str) {
    size_t str_len;    
    char *s;
    size_t pos = 0;
    size_t read_pos;
    int replace_count = 0;
    
    str_len = strlen(str);
    if (str_len <= 2) {
        return strdup("");
    }

    s = malloc(str_len - 1);
    if (!s) {
        fprintf(stderr, "Cannot allocate string to be escaped!\n");
        return strdup("");    
    }
    memset(s, '\0', str_len - 1);
    read_pos = 1;
    for (pos = 0; pos < str_len - 2; pos++) {
        if (pos == str_len - 2 - replace_count) {
	    break;
	}
        switch(str[read_pos]) {
	case '\\':
	    if (str[read_pos+1] == '\"') {
	        s[pos] = '\"';
	        read_pos++;
		replace_count++;
	    }
	    break;
	default:
	    s[pos] = str[read_pos];
	    break;
	}
        read_pos++;
    }

    return s;
}

#define MAX_INCLUDE_DEPTH 10
YY_BUFFER_STATE includes[MAX_INCLUDE_DEPTH];
char *filenames[MAX_INCLUDE_DEPTH];
int includes_index = 0;

%}

COMMENT1 #.*\n
COMMENT2 \/\*(.*\n)*.*\*\/
STRING \"[^\"](\\.|\"\"|[^"\n])*\"
%x VERBASTRING
%x VERBASUBSTITUTESTRING
FLOAT [0-9\.]+
INTEGER [0-9]+
GVARIABLE $[a-zA-Z0-9\-_]+
LABEL ^[a-zA-Z0-9\-_]+:

AMIVERSION ami_version
AMIVERSIONSHORT av
REVISION revision
AUTHOR author
SHORTDESC shortdesc
DESCRIPTION description
REFERENCE reference
TAG tag
MESSAGE message
INCLUDE include
SLEEP sleep
REPEAT repeat
AS as
ACTION action
FIELD field
EXEC exec
DEBUGON debugon
DEBUGOFF debugoff
EXIT exit
GOTO goto
TRUE true
FALSE false

%%

"\"\"\"" { vbindex = 0; BEGIN(VERBASTRING); }
<VERBASTRING>"\"\"\"" {
    BEGIN(INITIAL);
    verbatim_buf[vbindex] = '\0';
    yylval->TOK_VERBATIM = strdup(verbatim_buf);
    return TOK_VERBATIM;
}

<VERBASTRING>(.|\n) {
     if (vbindex > 8191) {
         ami_yyerror(yyscanner, NULL, "Verbatim string too long! (max 8192)\n");
     }
     verbatim_buf[vbindex] = yytext[0];
     vbindex++;
}

"s\"\"\"" { vbsubindex = 0; BEGIN(VERBASUBSTITUTESTRING); }
<VERBASUBSTITUTESTRING>"\"\"\"" {
    BEGIN(INITIAL);
    verbasub_buf[vbsubindex] = '\0';
    yylval->TOK_STRING = strdup(verbasub_buf);
    return TOK_STRING;
}

<VERBASUBSTITUTESTRING>(.|\n) {
     if (vbsubindex > 8191) {
         ami_yyerror(yyscanner, NULL, "Verbatim substitute string too long! (max 8192)\n");
     }
     verbasub_buf[vbsubindex] = yytext[0];
     vbsubindex++;
}


"=" return TOK_EQUAL;
"=>" return TOK_ASSIGN;
"{" return TOK_OPENSECTION;
"}" return TOK_CLOSESECTION;
"[" return TOK_OPENBRACKET;
"]" return TOK_CLOSEBRACKET;
"(" return TOK_OPENPARENTHESIS;
")" return TOK_CLOSEPARENTHESIS;
"." return TOK_DOT;
"," return TOK_COMMA;
":" return TOK_COLON;

{AMIVERSION} { return TOK_AMIVERSION; }
{AMIVERSIONSHORT} { return TOK_AMIVERSION; }
{REVISION} { return TOK_REVISION; }
{AUTHOR} { return TOK_AUTHOR; }
{SHORTDESC} { return TOK_SHORTDESC; }
{DESCRIPTION} { return TOK_DESCRIPTION; }
{REFERENCE} { return TOK_REFERENCE; }
{TAG} { return TOK_TAG; }
{MESSAGE} { return TOK_MESSAGE; }
{INCLUDE} { BEGIN(incl); }
<incl>[ \t]*
<incl>[^ \t\n]+	{ /* got the include file name */
		  if (includes_index >= MAX_INCLUDE_DEPTH) {
			  ami_yyerror(yyscanner, NULL, "Includes nested too deeply");
			  exit(1);
		  }

		filename = get_include_file(ami, yytext);
                if (!filename) {
			  ami_yyerror(yyscanner, NULL, "Error reading file '%s'", yytext);
			  exit(1);
                }

		filenames[includes_index] = filename;
		includes[includes_index++] = YY_CURRENT_BUFFER;

		realfile = strdup(filename);

		yyin = fopen(realfile, "r");
		if (!yyin) {
			printf("Can not open %s\n", realfile);
                        free(realfile);
			exit(1);
		}
		free(realfile);
		free(filename);

		ami_yy_switch_to_buffer(ami_yy_create_buffer(yyin, YY_BUF_SIZE, yyscanner), yyscanner);

                  BEGIN(INITIAL);
		}
<<EOF>>		{
		  if (--includes_index < 0) {
                          YY_NEW_FILE;
			  yyterminate();
		  } else {
			  free(filenames[includes_index + 1]);
			  filename = filenames[includes_index];
			  ami_yy_delete_buffer(YY_CURRENT_BUFFER, yyscanner);
			  ami_yy_switch_to_buffer(includes[includes_index], yyscanner);
		  }
		}



{SLEEP} { return TOK_SLEEP; }
{REPEAT} { return TOK_REPEAT; }
{AS} { return TOK_AS; }
{ACTION} { return TOK_ACTION; }
{EXEC} { return TOK_EXEC; }
{FIELD} { return TOK_FIELD; }
{DEBUGON} { return TOK_DEBUGON; }
{DEBUGOFF} { return TOK_DEBUGOFF; }
{EXIT} { return TOK_EXIT; }
{GOTO} { return TOK_GOTO; }
{TRUE} { yylval->TOK_INTEGER = 1; return TOK_INTEGER; }
{FALSE} { yylval->TOK_INTEGER = 0; return TOK_INTEGER;}

{GVARIABLE} {
              yylval->TOK_GVARIABLE = strdup(yytext);
              return TOK_GVARIABLE;
           }

{LABEL} {
              yylval->TOK_LABEL = strdup(yytext);
              return TOK_LABEL;
           }


{INTEGER} { yylval->TOK_INTEGER = (int)strtol(yytext, NULL, 10);
           return TOK_INTEGER;
}

{FLOAT} { yylval->TOK_FLOAT = (float)strtof(yytext, NULL);
           return TOK_FLOAT;
}

{STRING} {
           yylval->TOK_STRING = escape_string(yytext);
           return TOK_STRING;
         }

[a-zA-Z0-9_\-:<>@]+ {
        yylval->TOK_WORD = strdup(yytext);
	return TOK_WORD;
}

[a-zA-Z][\.a-zA-Z0-9_:<>@]+ {
        yylval->TOK_FUNCTIONNAME = strdup(yytext);
	return TOK_FUNCTIONNAME;
}

{COMMENT1} {}
{COMMENT2} {}

[\n] {  }

[ \t\r]+ ;

. ami_yyerror(yyscanner, NULL, "Syntax error: invalid character '%c'\n", yytext[0]);

%%

