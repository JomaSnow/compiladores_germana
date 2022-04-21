#include <stdio.h>
#include <string.h>

#include "output/lexical.h"
#include "output/parser.tab.h"

extern FILE *yyin;
extern FILE *yyout;

extern void yyparse();

int main(int argc, char **argv) {
    yyin = fopen("./lib/test.txt", "r");

    printf("\n");
    printf("Parsing...\n");
    printf("\n");
    
    yyparse(yyin);

    printf("\n");
    printf("All good.\n");
    printf("\n");
}