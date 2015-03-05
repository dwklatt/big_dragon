dragon: parser.tab.c lexer.c
	clang -g -o $@ $^

parser.tab.c: parser.y
	bison -d -v $<

lexer.c: scanner.l
	flex -o  $@ $<

clean:
	rm -f dragon *.o lexer.c parser.tab.* parser.output
