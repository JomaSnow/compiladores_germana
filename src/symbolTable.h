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

Symbol *create(char *name, char *type, int scope, int memoryAddress);
void add(Symbol *symbol);
Symbol *find(char *name);
void print();

#endif