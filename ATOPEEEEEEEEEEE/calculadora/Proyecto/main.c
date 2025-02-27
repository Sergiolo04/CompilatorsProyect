#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"

extern char *yytext;
extern int yyleng;
extern FILE *yyin;
extern int yylex();
FILE *fich;

int main() {
    int token;
    char nombre[80];

    // Pedir al usuario el nombre del archivo fuente
    printf("INTRODUCE NOMBRE DE FICHERO FUENTE: ");
    scanf("%s", nombre);
    printf("\n");

    // Intentar abrir el archivo
    if ((fich = fopen(nombre, "r")) == NULL) {
        printf("*** ERROR: No puedo abrir el fichero %s\n", nombre);
        exit(1);
    }

    yyin = fich; // Asignar el archivo a Flex

    // Leer tokens uno por uno
    while ((token = yylex())) {
        printf("TOKEN %d ", token);

        switch (token) {
            case VARI:  printf("(VARI)\n"); break;
            case CONS:  printf("(CONS)\n"); break;
            case INTT:  printf("(INTT)\n"); break;
            case IFFF:  printf("(IFFF)\n"); break;
            case ELSE:  printf("(ELSE)\n"); break;
            case WHIL:  printf("(WHIL)\n"); break;
            case PRIN:  printf("(PRIN)\n"); break;
            case READ:  printf("(READ)\n"); break;
            case MAIN:  printf("(MAIN)\n"); break;
            
            case PLUS:  printf("(PLUS)\n"); break;
            case MINU:  printf("(MINU)\n"); break;
            case MULT:  printf("(MULT)\n"); break;
            case DIVI:  printf("(DIVI)\n"); break;
            case ASIG:  printf("(ASIG)\n"); break;
            case PYCO:  printf("(PYCO)\n"); break;
            case COMA:  printf("(COMA)\n"); break;
            case PARI:  printf("(PARI)\n"); break;
            case PARD:  printf("(PARD)\n"); break;
            case LLAI:  printf("(LLAI)\n"); break;
            case LLAD:  printf("(LLAD)\n"); break;
            case QUES:  printf("(QUES)\n"); break;
            case COLN:  printf("(COLN)\n"); break;

            case IDEN:  printf("(IDEN) LEXEMA: %s  LONGITUD: %d\n", yytext, yyleng); break;
            case ENTE:  printf("(ENTE) VALOR: %s\n", yytext); break;
            case CADE:  printf("(CADE) TEXTO: %s\n", yytext); break;

            default:
                printf("(TOKEN DESCONOCIDO: %s)\n", yytext);
        }
    }

    fclose(fich);
    return 0;
}
