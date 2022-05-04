#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

typedef struct Symbol
{
    char name[20];
    char type[6];
    char scope[10];
    int memoryAddress;
    int used;
} Symbol;

Symbol *create(char *name, char *type, char *scope, int memoryAddress);
void add(Symbol *symbol);
int find(char *name, char *scope);
void print();

#endif