%{
  #include <stdio.h>
  #include <math.h>
  #include "lexical.h"
  #include "parser.tab.h"
  #include "symbolTable.h"
  #include <stdlib.h>
  #include <string.h>
  #include <stdarg.h>

/*   #include "code.c" */
  #include "../lib/code.h"

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

  /* TM location number for current instruction emission */
  static int emitLoc = 0 ;

  /* Highest TM location emitted so far
    For use in conjunction with emitSkip,
    emitBackup, and emitRestore */
  static int highEmitLoc = 0;

  void emitRO( char *op, int r, int s, int t, char *c)
  { fprintf(yyout,"%3d:  %5s  %d,%d,%d ",emitLoc++,op,r,s,t);
  //  if (TraceCode) fprintf(code,"\t%s",c) ;
    fprintf(yyout,"\n") ;
  //  if (highEmitLoc < emitLoc) highEmitLoc = emitLoc ;
  } /* emitRO */

  /* Procedure emitRM emits a register-to-memory
  * TM instruction
  * op = the opcode
  * r = target register
  * d = the offset
  * s = the base register
  * c = a comment to be printed if TraceCode is TRUE
  */
  void emitRM( char * op, int r, int d, int s, char *c)
  { fprintf(yyout,"%3d:  %5s  %d,%d(%d) ",emitLoc++,op,r,d,s);
  //  if (TraceCode) fprintf(code,"\t%s",c) ;
    fprintf(yyout,"\n") ;
  //  if (highEmitLoc < emitLoc)  highEmitLoc = emitLoc ;
  } /* emitRM */
  int scope = 0;
  int memoryAddress = 0;
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
%token <string> ASSIGN "="
%token SUM "+"
%token MINUS "-"
%token TIMES "*"
%token DIVIDE "/"
%token IF   "if"
%token ELSE "else"
%token RETURN "return"
%token WHILE "while"

%type <string> addop
%type <string> mulop
%type <string> relop
%type <string> type_specifier
%type <string> var

%%

program: declaration_list {
  emitRO("HALT", 0, 0, 0, "");
} ;

declaration_list: declaration_list declaration | declaration ;

declaration: var_declaration | fun_declaration ;

var_declaration: type_specifier ID ';' {
  Symbol *symbol = find($2);
  if (symbol == NULL) {
    Symbol *symbol = create($2, $1, scope, memoryAddress);
    add(symbol);
    memoryAddress += 4;
  }
  else {
    yyerror("Variable already declared: %s", $2);
  }
} | type_specifier ID '[' INTEGER ']' ;

type_specifier: INT {
  $$ = "int";
} | VOID {
  $$ = "void";
} ;

fun_declaration: type_specifier ID '(' params ')' compound_stmt ;

params: param_list | VOID ;

param_list: param_list ',' param | param ;

param: type_specifier ID {
  Symbol *symbol = find($2);
  if (symbol == NULL) {
    Symbol *symbol = create($2, $1, scope, memoryAddress);
    add(symbol);
    memoryAddress += 4;
  }
  else {
    yyerror("Variable already declared: %s", $2);
  }
} | type_specifier ID '[' ']' ;

compound_stmt: '{' {
  scope++;
} local_declarations statement_list '}' {
  scope--;
} ;

local_declarations: | local_declarations var_declaration ;

statement_list: | statement_list statement ;

statement: expression_stmt | compound_stmt | selection_stmt | iteration_stmt | return_stmt ;

expression_stmt: expression ';' | ';' ;

selection_stmt: IF '(' expression ')' statement | IF '(' expression ')' statement ELSE statement ;

iteration_stmt: WHILE '(' expression ')' statement ;

return_stmt: RETURN ';' | RETURN expression ';' ;

expression: var ASSIGN expression {
  emitRM("LDC", ac, 1, 0, "load const");
} | simple_expression ;

var: ID | ID '[' expression ']' ;

simple_expression: additive_expression relop additive_expression | additive_expression ;

relop: LOWER | GREATER | GE | EQ | NE | LE {
  $$="";
} ;

additive_expression: additive_expression addop term {
  emitRO($2, ac1, 1, 0, "sum x");
} | term ;

addop: SUM {
  $$="ADD";
}  | MINUS ;

term: term mulop factor {
  emitRO($2, ac1, 1, 0, "multiple fat");
} | factor ;

mulop: TIMES {
  $$="MUL";
} | DIVIDE ;

factor: '(' expression ')' | var {
  Symbol *symbol = find($1);
  if (symbol == NULL) {
    yyerror("Undeclared variable: %s", $1);
  }
  else {
    symbol->used = 1;
  }
} | call | INTEGER ;

call: ID '(' args ')' ;

args: | arg_list ;

arg_list: arg_list ',' expression | expression ;

%%