#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef struct Symbol
{
    char name[20];
    char type[6];
    int scope;
    int memoryAddress;
    int used;
} Symbol;

Symbol *createSymbol(char *name, char *type, int scope, int memoryAddress);
void addSymbol(Symbol *symbol);
Symbol *findSymbol(char *name);
void printSymbolTable();

#endif