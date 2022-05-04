#include <stdio.h>
#include <string.h>

#include "output/lexical.h"
#include "output/parser.tab.h"
#include "src/symbolTable.h"

extern FILE *yyin;
extern FILE *yyout;


// Mac OSes doesn't define yyparse function
#ifdef __APPLE__
extern void yyparse();
#endif


int main(int argc, char **argv) {
    yyin = fopen("./lib/tests/fatorial.txt", "r");
    yyout = fopen("./output/fatorial-gerador.TM", "w");

    printf("\n");
    printf("Parsing...\n");
    printf("\n");

    yyparse(yyin);
    
    print();

    printf("\n");
    printf("All good.\n");
    printf("\n");
    fclose(yyout);
}