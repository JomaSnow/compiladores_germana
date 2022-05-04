#ifndef TREE_H
#define TREE_H

#include "symbolTable.h"

typedef struct Node
{
    struct Node *left;
    struct Node *right;
    struct Symbol *symbolToken;
    char title[100];
    char type[6];
    char cast[6];
} Node;

#endif