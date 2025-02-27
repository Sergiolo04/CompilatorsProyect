%{
    #include <stdio.h>
    #include <stdlib.h>  // Librería estándar para atol()
    #include "tokens.h"  // Se usa en lugar de "y.tab.h" para los tokens
%}

/* Definición de patrones */
DIGITO      [0-9]
LETTER      [a-zA-Z_]
ID          {LETTER}({LETTER}|{DIGITO})*
NUMBER      -?{DIGITO}+
STRING      \"(\\.|[^"\\])*\"  /* Cadenas con comillas dobles */
WHITESPACE  [ \t\r\n]+

%%

/* Palabras reservadas */
"var"     { return VARI; }
"const"   { return CONS; }
"int"     { return INTT; }
"if"      { return IFFF; }
"else"    { return ELSE; }
"while"   { return WHIL; }
"print"   { return PRIN; }
"read"    { return READ; }
"main"    { return MAIN; }

/* Operadores y símbolos */
"+"       { return PLUS; }
"-"       { return MINU; }
"*"       { return MULT; }
"/"       { return DIVI; }
"="       { return ASIG; }
";"       { return PYCO; }
","       { return COMA; }
"("       { return PARI; }
")"       { return PARD; }
"{"       { return LLAI; }
"}"       { return LLAD; }
"?"       { return QUES; }
":"       { return COLN; }

/* Identificadores y números */
{ID}  { 
        if (yyleng > 32) {
            fprintf(stderr, "Error: Identificador demasiado largo en línea %d\n", yylineno);
        } else {
            return IDEN;
        }
    }
    
{NUMBER}  { return ENTE; }
{STRING}  { return CADE; }

/* Validación de enteros largos */
{DIGITO}+   {
            if (atol(yytext) > 2147483648L)
                fprintf(stderr, "Error: Entero demasiado largo en línea %d\n", yylineno);
            else    
                return ENTE;
}

/* Comentarios */
"//".*    { /* Ignorar comentarios de línea */ }
"/*"([^*]|\*[^/])*"*/" { /* Ignorar comentarios multilínea */ }

/* Ignorar espacios en blanco */
{WHITESPACE}  { /* No devuelve nada, simplemente ignora */ }

/* Manejo de errores */
.         { fprintf(stderr, "Error: Caracter desconocido '%s' en línea %d\n", yytext, yylineno); }

%%

int yywrap() { return 1; }

