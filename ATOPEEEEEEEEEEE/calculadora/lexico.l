/*Seccion de definiciones*/

%{
    #include "lexico.h"
    #include <stdio.h>
%}

/*podemos definir marcos de ER, no es necesario hacerlo. Dar un nombre a ER*/
/* no poner doble barra para comentar*/
/* no ponerlo en la primera columna porque lo puede confucnir con */
letra [a-zA-Z$_]
digito [0-9]

/*opcion para contabilizar lineas*/
%option yylineno

/*Declaración contexto de comentario*/
%x comentario

%%
"//".*  { }
[\n\t\r]+ { }

"/*"                {BEGIN(comentario); }
<comentario>"*/"    { BEGIN(INITIAL); }
<comentario>(?s:.)  { }
<comentario><<EOF>> {printf("Comentario sin cerrar"); return 0}


/*Tokens*/

"="               {return ASIG; }
"+"               {return SUMA; }
"-"               {return REST; }
"*"               {return MULT; }
"/"               {return DIVI; }
"("               {return PARI; }
")"               {return PARD; }
";"               {return PYCO; }
"{"               {return LLAI; }
"}"               {return LLAD; }
","               {return COMA; }
"print"           {return PRIN; }
"main"            {return MAIN; }
({letra})({letra}|{digito})* { return IDEN;}
{digito}+         {return ENTE; }

/* Expresión regular para cadenas de caracteres literales con escape */
\"([^"\n\\]|\\.)*\"      { return CADE; }
\"([^"\n\\]|\\.)*        { printf("Cadena sin cerrar en linea %d\n ", yylineno)}

.                 { printf("Error en línea %d: %s\n", yylineno, yytext)}


%%

/*Seccion de funciones auxiliares */
int main (int argc, char *argv[]){
    if (argc != 2){
        print("Uso: %s fichero\n", argv[0])
        exit(1);
    }
    yyin = fopen(argv[1],"r");
    int token;
    while ( (token = yylex()) != 0 ){ /*es redundante el !=0*/
        printf("Token %d: %s\n",token, yytext);
    }
}

/*abrimos terminal en visualcode y ponemos flex lexico.l. Si no dice nada, todo va bien. Podemos abrir lex.yy.c */
/* hay que compilarlo con gcc lex.yy.c -lfl 