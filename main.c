#include <stdio.h>
#include <string.h>

#include "output/lexical.h"
#include "output/parser.tab.h"

extern FILE *yyin;
extern FILE *yyout;


// Mac OSes doesn't define yyparse function
#ifdef __APPLE__
extern void yyparse();
#endif


int main(int argc, char **argv) {
    yyin = fopen("./lib/tests/fatorial.txt", "r");

    printf("\n");
    printf("Parsing...\n");
    printf("\n");
    
    yyparse(yyin);

    printf("\n");
    printf("All good.\n");
    printf("\n");
}