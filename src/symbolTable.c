#include "symbolTable.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int position = 0;
Symbol *symbols[100];

Symbol *create(char *name, char *type, char *scope, int memoryAddress)
{
    Symbol *symbol = (Symbol *)malloc(sizeof(Symbol));
    strcpy(symbol->name, name);
    strcpy(symbol->type, type);
    strcpy(symbol->scope, scope);
    symbol->memoryAddress = memoryAddress;
    symbol->used = 0;
    return symbol;
}

void add(Symbol *symbol)
{
    symbols[position] = symbol;
    position++;
}

Symbol *find(char *name)
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
    for (int i = 0; i < 88; i++)
    {
        printf("-");
    }
    printf("\n");
}

void printHeader()
{
    printLine();
    printf("| NAME               | TYPE               | SCOPE              | MEMORY ADDRESS | USED |\n");
    printLine();
}

void printSymbol(int i)
{
    printf("| %-18s | %-18s | %-18s | %-14d | %-4d |\n",
           symbols[i]->name,
           symbols[i]->type,
           symbols[i]->scope,
           symbols[i]->memoryAddress,
           symbols[i]->used);
}

void print()
{
    printHeader();
    for (int i = 0; i < position; i++)
    {
        printSymbol(i);
        printLine();
    }
}