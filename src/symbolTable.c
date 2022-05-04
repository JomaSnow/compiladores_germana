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

int find(char *name, char *scope)
{
    for (int i = 0; i < position; i++)
    {
        if ((strcmp(symbols[i]->name, name) == 0 && strcmp(symbols[i]->scope, scope) == 0))
        {
            return i;
        }
    }
    return -1;
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
    printf("| %-20s | %-20s | %-20s | %-6d | %-6d |\n",
           symbols[i]->name,
           symbols[i]->type,
           symbols[i]->scope,
           symbols[i]->memoryAddress,
           symbols[i]->used ? "YES" : "NO");
}

void print()
{
    printHeader();
    for (int i = 0; i < position; i++)
    {
        printSymbols(i);
        printLine();
    }
}