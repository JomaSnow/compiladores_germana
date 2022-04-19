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
Point [\.]
Slash [\/]
Astherisc [\*]

id          ({Char}|_)({Number}|{Char}|_)*\n
int         {Sign}?{Number}+\n
float       {Sign}?({Number}+{Point}{Number}*|{Number}*{Point}{Number}+)\n
string      \"(\\.|[^"#{}\\])*\"
char        \'(\\.|[^"#{}\\])\'

%%
{id}        { RETURN_TOKEN; yylval.string = strdup (yytext); return ID; }
{int}       { RETURN_TOKEN; yylval.integer = atoi (yytext); return INT; }
{float}     { RETURN_TOKEN; yylval.decimal = atof (yytext); return NUMBER; }
%%