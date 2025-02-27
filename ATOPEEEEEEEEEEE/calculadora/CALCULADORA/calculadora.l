%{
    #include <stdio.h>
    #include "calculadora.tab.h"    
%}

%optino yylineno

%%
"+"     { return MAS; }
"*"     { return POR; }
"("     { return PARI; }
")"     { return PARD; }
[0-9]+     { return NUM; }
[^+*()0-9]+     {printf("Error lexico en linea %d: %s", yylineno, yytext);}



%%








