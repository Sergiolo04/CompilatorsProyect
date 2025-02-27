
#El programa ejecutable se construye con el fichero c que genera flex utilizando c

lexico: lex.yy.c lexico.h
	gcc lex.yy.c -lfl -o lexico

lex.yy.c: lexico.l
	flex lexico.l

test: lexico entrada.txt
	./lexico  < microC.txt

clean: 
	rm lex.yy.c lexico