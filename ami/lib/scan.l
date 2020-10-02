%option nodefault noinput nounput noyywrap nounistd
%option reentrant bison-bridge
%option prefix="ami_yy"

%{
#define YYSTYPE AMI_YYSTYPE
#include <parse.h>

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
    memcpy(s, &str[1], str_len - 2);
    return s;
}
    
%}

COMMENT1 #.*\n
COMMENT2 \/\*(.*\n)*.*\*\/
STRING (\"|\')([^\\(\"|\')]|\\.)*(\"|\')
NUMBER [0-9]+
VARIABLE $[a-zA-Z0-9\-_]+

AMIVERSION ami_version
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

%%

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

{AMIVERSION} { return TOK_AMIVERSION; }
{REVISION} { return TOK_REVISION; }
{AUTHOR} { return TOK_AUTHOR; }
{SHORTDESC} { return TOK_SHORTDESC; }
{DESCRIPTION} { return TOK_DESCRIPTION; }
{REFERENCE} { return TOK_REFERENCE; }
{TAG} { return TOK_TAG; }
{MESSAGE} { return TOK_MESSAGE; }
{INCLUDE} { return TOK_INCLUDE; }
{SLEEP} { return TOK_SLEEP; }
{REPEAT} { return TOK_REPEAT; }
{AS} { return TOK_AS; }
{ACTION} { return TOK_ACTION; }
{EXEC} { return TOK_EXEC; }
{FIELD} { return TOK_FIELD; }
{DEBUGON} { return TOK_DEBUGON; }
{DEBUGOFF} { return TOK_DEBUGOFF; }

{VARIABLE} {
              yylval->TOK_VARIABLE = strdup(yytext);
              return TOK_VARIABLE;
           }


{NUMBER} { yylval->TOK_INTEGER = (int)strtol(yytext, NULL, 10);
           return TOK_INTEGER;
}

{STRING} {
           yylval->TOK_STRING = escape_string(yytext);
           return TOK_STRING;
         }

[a-zA-Z0-9_:<>@]+ {
        yylval->TOK_WORD = strdup(yytext);
	return TOK_WORD;
}

{COMMENT1} {}
{COMMENT2} {}

[\n] {}

[ \t\r]+ ;

. ami_yyerror(yyscanner, NULL, "Syntax error: invalid character '%c'\n", yytext[0]);

%%

