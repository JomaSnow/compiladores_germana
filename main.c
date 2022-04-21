#include <stdio.h>
#include <string.h>

#include "output/lexical.h"
#include "output/parser.tab.h"

extern FILE *yyin;
extern FILE *yyout;

extern void yyparse();

int main(int argc, char **argv) {
    yyin = fopen("./lib/test.txt", "r");

    printf("Parsing...\n");
    yyparse(yyin);
    printf("All good.\n");
}