compile_lexical:
	flex -o ./output/lexical.c lib/lexical.l
	gcc -ansi -o ./output/exec_lexical output/lexical.c

exec_lexical: compile_lexical
	./output/exec_lexical
