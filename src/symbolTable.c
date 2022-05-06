#include "symbolTable.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int position = 0;
Symbol *symbols[100];

Symbol *createSymbol(char *name, char *kind, char *type, int scope)
{
    Symbol *symbol = (Symbol *)malloc(sizeof(Symbol));
    strcpy(symbol->name, name);
    strcpy(symbol->kind, kind);
    strcpy(symbol->type, type);
    symbol->scope = scope;
    symbol->used = 0;
    return symbol;
}

void addSymbol(Symbol *symbol)
{
    symbols[position] = symbol;
    position++;
}

Symbol *findSymbol(char *name)
{
    for (int i = 0; i < position; i++)
    {
        if ((strcmp(symbols[i]->name, name) == 0))
        {
            return symbols[i];
        }
    }
    return NULL;
}

void printLine()
{
    for (int i = 0; i < 53; i++)
    {
        printf("-");
    }
    printf("\n");
}

void printHeader()
{
    printLine();
    printf("| %-10s | %-10s | %-10s | %-10s |\n",
           "NAME", "KIND", "TYPE", "USED");
    printLine();
}

char *getScope(int scope)
{
    return (scope == 0) ? "param" : "local";
}

void printSymbol(int i)
{
    printf("| %-10s | %-10s | %-10s | %-10s |\n",
           symbols[i]->name,
           symbols[i]->kind,
           symbols[i]->type,
           symbols[i]->used == 1 ? "YES" : "NO");
}

void printSymbolTable()
{
    printHeader();
    for (int i = 0; i < position; i++)
    {
        printSymbol(i);
        printLine();
    }
}