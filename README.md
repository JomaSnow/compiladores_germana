# Compiladores - Projeto Final

Professora Germana

2021.2

## Alunos

    Artur Filgueiras Scheiba Zorron - 180013696
    Gabriel dos Santos Martins      - 150126298
    João Marcos Schmaltz Duda       - 150132131
    Mateus Luiz Freitas Barros      - 150140801

## Objetivo

O objetivo deste projeto foi desenvolver um compilador para a linguagem C implementando analisadores léxicos, sintáticos, semânticos e geradores de código.

## Instalação

Install flex:
    
- Ubuntu:

        sudo apt install flex 

- Mac:
        
        brew install flex

Install bison:

- Ubuntu:
        
        sudo apt install bison
- Mac:
        
        brew install bison

## Execução

    make run

obs.: A depender da versão do Bison no ambiente Linux, a geração do arquivo parser.tab.h trará na penúltima linha uma declaração de "int yyparse (void);". Essa linha deve ser removida após a execução do make run, e em seguida rodar:
    
    gcc main.c output/lexical.c output/parser.tab.c symbolTable.o -o result -I src && ./result
