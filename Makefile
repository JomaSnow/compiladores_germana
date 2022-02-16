run:
	flex -o ./output/lex.yy.c lib/lexico.l
	gcc -ansi -o ./output/demo1 output/lex.yy.c