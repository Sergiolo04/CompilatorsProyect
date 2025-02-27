
#El programa ejecutable se construye con el fichero c que genera flex utilizando c

minic: lex.yy.c minic.h
	gcc lex.yy.c -lfl -o minic

lex.yy.c: minic.l
	flex minic.l

test: minic entrada.txt
	./minic  < microC.txt

clean: 
	rm lex.yy.c minic