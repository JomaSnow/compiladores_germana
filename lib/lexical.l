%option outfile="./output/lexical.c" header-file="./output/lexical.h"

/* definições */

Number [0-9]
Char [a-zA-Z]
Sign [+-]
Point [\.]
Slash [\/]
Astherisc [\*]

%{
#include <stdio.h>
%}

/*analisador léxico */

id          ({Char}|_)({Number}|{Char}|_)*\n
int         {Sign}?{Number}+\n
float       {Sign}?({Number}+{Point}{Number}*|{Number}*{Point}{Number}+)\n
comment     {Slash}({Slash}.*|{Astherisc}.*({Astherisc}{Slash}))\n
empty       .*

%%
{id}		  {printf("Identificador\n");}
{int}     {printf("Inteiro\n");}
{float}   {printf("Flutuante\n");}
{comment} {printf("Comentario\n");}
{empty}		{printf("Erro\n");}
%%

/* recomendavel declarar sempre
   funcao yywrap() */
int yywrap ();

/* programa principal */
main() {
  printf("\nStarting lex \n");
  yylex(); /* scanner gerado por Flex */
}

int yywrap() {
 return 1;
}
