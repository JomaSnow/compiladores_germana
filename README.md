# compiladores_germana

1. Install flex:
- Ubuntu: `sudo apt install flex`
- Mac: `brew install flex`

2. Run:
- `make run`
or
- `cd lib && flex -o ./output/lex.yy.c lib/lexico.l && gcc -ansi -o ./output/demo1 output/lex.yy.c`

