compile_lexical:
	flex lib/lexical.l

compile_parser:
	bison -d -t lib/parser.y
	mv parser.tab.c ./output/parser.tab.c
	mv parser.tab.h ./output/parser.tab.h

compile_semantic:
	gcc -g -c src/symbolTable.c -o symbolTable.o -I bison

run: compile_lexical compile_parser compile_semantic
	gcc main.c output/lexical.c output/parser.tab.c symbolTable.o -o result -I src
	./result