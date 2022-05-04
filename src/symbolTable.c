#include "symbolTable.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int position = 0;
Symbol *symbols[100];

Symbol *create(char *name, char *type, int scope, int memoryAddress)
{
    Symbol *symbol = (Symbol *)malloc(sizeof(Symbol));
    strcpy(symbol->name, name);
    strcpy(symbol->type, type);
    symbol->scope = scope;
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
    for (int i = 0; i < 70; i++)
    {
        printf("-");
    }
    printf("\n");
}

void printHeader()
{
    printLine();
    printf("| %-10s | %-10s | %-10s | %-14s | %-10s |\n",
           "NAME", "TYPE", "SCOPE", "MEMORY ADDRESS", "USED");
    printLine();
}

void printSymbol(int i)
{
    printf("| %-10s | %-10s | %-10d | %-14d | %-10s |\n",
           symbols[i]->name,
           symbols[i]->type,
           symbols[i]->scope,
           symbols[i]->memoryAddress,
           symbols[i]->used == 1 ? "YES" : "NO");
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