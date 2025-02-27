%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "calculadora.tab.h"    
%}

%option yylineno

%% 

[ \n\t\r]+  { }
"+"         { return MAS;  }
"-"         { return MENOS;}
"*"         { return POR;  }
"/"         { return DIV;  }
"("         { return PARI; }
")"         { return PARD; }
";"         { return PYC;  }
"="         { return IGUAL; }

//strdup es un duplicado en memoria dinámica de una cadena de caracteres
r[0-9]      { yylval.cadena = strdup(yytext); return REG;}
//ytext contiene con la secuencia de caraccteres que ha encajado con la expresion regular. En este caso la estamos convirtiendo
//en un entero
[0-9]+      { yylval = atoi(yytext); return NUM;  }
[^+*()0-9;\-/ \n\t\r]+ { printf("Error lexico en linea %d: %s\n", yylineno, yytext); }

%%