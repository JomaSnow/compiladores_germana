%option noyywrap
%option outfile="./output/lexical.c" header-file="./output/lexical.h"

/* definições */

%{
#include <stdio.h>
#include <string.h>

#include "parser.tab.h"

static int next_column = 1;
int column = 1;
#define RETURN_TOKEN column = next_column; next_column += strlen (yytext)
%}

/*analisador léxico */

Number [0-9]
Char [a-zA-Z]
Sign [+-]

id          ({Char}|_)({Number}|{Char}|_)*\n
int         {Sign}?{Number}+\n

%%
{id}        { RETURN_TOKEN; yylval.string = strdup (yytext); return ID; }
{int}       { RETURN_TOKEN; yylval.integer = atoi (yytext); return INTEGER; }

"if"        { RETURN_TOKEN; return IF; }
"else"      { RETURN_TOKEN; return ELSE; }
"while"     { RETURN_TOKEN; return WHILE; }
"return"    { RETURN_TOKEN; return RETURN; }
"void"      { RETURN_TOKEN; return VOID; }
"int"       { RETURN_TOKEN; return INT; }

">" { RETURN_TOKEN; return GREATER; }
">=" { RETURN_TOKEN; return GE; }
"<" { RETURN_TOKEN; return LOWER; }
"<=" { RETURN_TOKEN; return LE; }
"==" { RETURN_TOKEN; return EQ; }
"!=" { RETURN_TOKEN; return NE; }
"=" { RETURN_TOKEN; return ASSIGN; }
"+" { RETURN_TOKEN; return SUM; }
"_" { RETURN_TOKEN; return UNDERSCORE; }
"*" { RETURN_TOKEN; return TIMES; }
"/" { RETURN_TOKEN; return DIVIDE; }

%%