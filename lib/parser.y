%{
  #include <stdio.h>
  #include <math.h>
  #include "lexical.h"
  #include "parser.tab.h"

  #include <stdlib.h>
  #include <string.h>
  #include <stdarg.h>
  extern int yylineno;
  extern int column;
  int has_errors = 0;

  void yyerror(const char *s, ...) {
      has_errors = 1;

      va_list ap;
      va_start(ap, s);
      fprintf(stderr, "%d, %d - ", yylineno, column);
      vfprintf(stderr, s, ap);
      fprintf(stderr, "\n");
  }
  int yylex();
%}

/*
    The first section of the parser uses the %union construct to declare types
    to be used in the values of symbols in the parser. In a bison parser, every
    symbol, both tokens and nonterminals, can have a value associated with it

    Ref: https://web.iitd.ac.in/~sumeet/flex__bison.pdf - page 53
*/
%union {
  int integer;
  char *string;
}

%token <string> ID
%token <integer> INTEGER
%token INT "int"
%token VOID "void"

%token GREATER ">"
%token GE   ">="
%token LOWER "<"
%token LE   "<="
%token EQ   "=="
%token NE   "!="
%token ASSIGN "="
%token SUM "+"
%token UNDERSCORE "_"
%token TIMES "*"
%token DIVIDE "/"
%token IF   "if"
%token ELSE "else"
%token RETURN "return"
%token WHILE "while"

%%

program: declaration_list ;

declaration_list: declaration_list declaration | declaration ;

declaration: var_declaration | fun_declaration ;

var_declaration: type_specifier ID ';' | type_specifier ID '[' INTEGER ']' ;

type_specifier: INT | VOID ;

fun_declaration: type_specifier ID '(' params ')' compound_stmt ;

params: param_list | VOID ;

param_list: param_list ',' param | param ;

param: type_specifier ID ';' | type_specifier ID '[' ']' ;

compound_stmt: '{' local_declarations statement_list '}'

local_declarations: | local_declarations var_declaration ;

statement_list: | statement_list statement ;

statement: expression_stmt | compound_stmt | selection_stmt | iteration_stmt | return_stmt ;

expression_stmt: expression ';' | ';' ;

selection_stmt: IF '(' expression ')' statement | IF '(' expression ')' statement ELSE statement ;

iteration_stmt: WHILE '(' expression ')' statement ';' ;

return_stmt: RETURN ';' | RETURN expression ';' ;

expression: var ASSIGN expression | simple_expression ;

var: ID | ID '[' expression ']' ;

simple_expression: additive_expression relop additive_expression | additive_expression ;

relop: LOWER | GREATER | GE | EQ | NE | LE ;

additive_expression: additive_expression addop term | term ;

addop: SUM | UNDERSCORE ;

term: term mulop factor | factor ;

mulop: TIMES | DIVIDE ;

factor: '(' expression ')' | var | call | INTEGER ;

call: ID '(' args ')' ;

args: | arg_list ;

arg_list: arg_list ',' expression | expression ;

%%