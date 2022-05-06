#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef struct Symbol
{
    char name[10];
    char kind[10];
    char type[10];
    int scope;
    int used;
} Symbol;

Symbol *createSymbol(char *name, char *kind, char *type, int scope);
void addSymbol(Symbol *symbol);
Symbol *findSymbol(char *name);
void printSymbolTable();

#endif