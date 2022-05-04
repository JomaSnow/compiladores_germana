compile_lexical:
	flex lib/lexical.l

compile_parser:
	bison -d -t lib/parser.y
	mv parser.tab.c ./output/parser.tab.c
	mv parser.tab.h ./output/parser.tab.h

compile_semantic:
	gcc -g -c src/symbolTable.c -o obj/symbolTable.o -I bison
	gcc -g -c src/tree.c -o obj/tree.o -I bison
	gcc -g bison/parser.tab.c flex/lex.yy.c obj/symbolTable.o obj/tree.o -I utils -I bison -I flex -Wall

run: compile_lexical compile_parser
	gcc main.c output/lexical.c output/parser.tab.c -o result
	./result