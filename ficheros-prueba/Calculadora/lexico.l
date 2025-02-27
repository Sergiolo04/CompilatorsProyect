/*SECCIÓN DE DEFINICIONES*/
%{
    #inclue "lexico.h"
    #include <stdio.h>
%}

letra   [a-zA-Z]
digito  [0-9]

//Opción para contabilizar líneas
%option yylineno

%%
#define ASIG 1
#define SUMA 2
#define REST 3
#define MULT 4
#define DIVI 5
#define PARI 6
#define PARD 7
#define IDEN 9
#define ENTE 10
#define PYCO 11

"="     { return ASIG; }
"+"     { return SUMA; }
"-"     { return REST; }
"*"     { return MULT; }
"/"     { return DIVI; }
...
"print" { return PRIN; }
({letra}|_)({letra}|{digito}|_) { return IDEN; }


%%
/*SECCIÓN DE FUNCIONES AUXILIARES*/


