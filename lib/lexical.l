%option noyywrap
%option outfile="./output/lexical.c" header-file="./output/lexical.h"

/* definições */

%{
#include <stdio.h>
#include <string.h>

#include "parser.tab.h"

static int next_column = 1;
int column = 1;
#define NEXT_CHAR_NUMBER column = next_column; next_column += strlen (yytext)
%}

/*analisador léxico */

Number [0-9]
Char [a-zA-Z]
Sign [+-]

identifier  {Char}+
int         {Sign}?{Number}+

%%
"if"        { NEXT_CHAR_NUMBER; return IF; }
"else"      { NEXT_CHAR_NUMBER; return ELSE; }
"while"     { NEXT_CHAR_NUMBER; return WHILE; }
"return"    { NEXT_CHAR_NUMBER; return RETURN; }
"void"      { NEXT_CHAR_NUMBER; return VOID; }
"int"       { NEXT_CHAR_NUMBER; return INT; }

">" { NEXT_CHAR_NUMBER; return GREATER; }
">=" { NEXT_CHAR_NUMBER; return GE; }
"<" { NEXT_CHAR_NUMBER; return LOWER; }
"<=" { NEXT_CHAR_NUMBER; return LE; }
"==" { NEXT_CHAR_NUMBER; return EQ; }
"!=" { NEXT_CHAR_NUMBER; return NE; }
"=" { NEXT_CHAR_NUMBER; return ASSIGN; }
"+" { NEXT_CHAR_NUMBER; return SUM; }
"_" { NEXT_CHAR_NUMBER; return UNDERSCORE; }
"*" { NEXT_CHAR_NUMBER; return TIMES; }
"/" { NEXT_CHAR_NUMBER; return DIVIDE; }
"(" { NEXT_CHAR_NUMBER; return '('; }
")" { NEXT_CHAR_NUMBER; return ')'; }
"{" { NEXT_CHAR_NUMBER; return '{'; }
"}" { NEXT_CHAR_NUMBER; return '}'; }
";" { NEXT_CHAR_NUMBER; return ';'; }
"[" { NEXT_CHAR_NUMBER; return '['; }
"]" { NEXT_CHAR_NUMBER; return ']'; }
"," { NEXT_CHAR_NUMBER; return ','; }

{int}           { NEXT_CHAR_NUMBER; yylval.integer = atoi (yytext); return INTEGER; }
{identifier}    { NEXT_CHAR_NUMBER; yylval.string = strdup (yytext); return ID; }

%%