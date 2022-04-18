compile_lexical:
	flex lib/lexical.l

compile_parser:
	bison -d -t lib/parser.y

run: compile_lexical compile_parser
	gcc output/lexical.c parser.tab.c