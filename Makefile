compile:
	flex -o ./output/lex.yy.c lib/lexico.l
	gcc -ansi -o ./output/exec output/lex.yy.c

run: compile
	./output/exec
