%{
  #include <stdio.h>
  #include <math.h>

  // Needs to declare the propotype of this functions below, it's something realated to
  // the current bison's version
  int yylex(void);
  int yyerror(char* s);
%}

/*
    The first section of the parser uses the %union construct to declare types
    to be used in the values of symbols in the parser. In a bison parser, every
    symbol, both tokens and nonterminals, can have a value associated with it

    Ref: https://web.iitd.ac.in/~sumeet/flex__bison.pdf - page 53
*/
%union {
  int integer;
  float decimal;
  char *string;
  char character;
}

%token <decimal> NUMBER
%token <integer> INT
%token <ast> CHAR_CONST
%token <ast> STRING_CONST
%token <string> ID

%%

input: NUMBER;

%%

int main() {
    yyparse();
    return 0;
}