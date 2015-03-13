dragon: parser.tab.o lexer.o tree.o scope.o node.o
	gcc -g -o $@ $^ -lfl

tree.o: tree.c
	gcc -g -c tree.c
scope.o: scope.c
	gcc -g -c scope.c
node.o: node.c
	gcc -g -c node.c

parser.tab.o: parser.tab.c
	gcc -g -c parser.tab.c
parser.tab.c: parser.y
	bison -d -v $<

lexer.o: lexer.c
	gcc -g -c lexer.c
lexer.c: scanner.l
	flex -o  $@ $<

clean:
	rm -f dragon *.o lexer.c parser.tab.* parser.output
