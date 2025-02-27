calculadora: main.c lexi.yy.c calculadora.tab.c
	gcc main.c lexx.yy.c calculadora.tab.c -lfl -o calculadora

lex.yy.c: calculadora.l 

calculadora.tab.h calculadora.tab.c : calculadora.y
	bison -d calculadora.y

clean : 
	rm -f calculadora calculadora.tab.* lex.yy.c

run : calculadora entrada.txt
	./calculadora entrada.txt 

