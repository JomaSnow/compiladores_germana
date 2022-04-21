compile_lexical:
	flex lib/lexical.l

compile_parser:
	bison -d -t lib/parser.y
	mv parser.tab.c ./output/parser.tab.c
	mv parser.tab.h ./output/parser.tab.h

run: compile_lexical compile_parser
	gcc main.c output/lexical.c output/parser.tab.c -o result
	./result