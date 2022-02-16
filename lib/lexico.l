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
inteiro     {Sign}?{Number}+\n
flutuante   {Sign}?({Number}+{Point}{Number}*|{Number}*{Point}{Number}+)\n
comentario  {Slash}({Slash}.*|{Astherisc}.*({Astherisc}{Slash}))\n
vazio       .*

%%
{id}		  {printf("Identificador\n");}
{inteiro} {printf("Inteiro\n");}
{flutuante} {printf("Flutuante\n");}
{comentario} {printf("Comentario\n");}
{vazio}		{printf("Erro\n");}
%%

/* recomendavel declarar sempre
   funcao yywrap() */
int yywrap ();

/* programa principal */
main() {
  yylex(); /* scanner gerado por Flex */
}

int yywrap() {
 return 1;
}
