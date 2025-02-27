%{
    #include <stdio.h>
    #include <stdlib.h>
    extern int yylex();
    extern int yylineno;   
    void yyerror(const char *msg); 
%}

//Definición de tipos de datos de símbolos de la gramática
%union {
    int entero;
    char *cadena;
}

%token MAS "+"
%token MENOS "-"
%token POR "*"
%token DIV "/"
%token <entero> NUM "number"
%token PARI "("
%token PARD ")"
%token PYC ";"
%token <cadena> REG "register"
%token IGUAL "="

//usamos type para definir el tipo de no terminales
%type <entero> expresion termino factor


%define parse.error verbose

//Precedencia y asociatividad
// Asociatividad izquierda %left MAS
// Asociatividad derecha %right MAS
// No tiene asociatividad %nonassoc MAS
//Los operadres cuya asociatividad se define primero tienen menos precedencia (si se definen después tienen más precedencia)

%left "+" "-"
%left "*" "/" //como están en la linea siguiente, tienen mayor precedencia

%%

entrada   : { inicializar(); } lista
          ;
//lista es un no terminal
lista     : lista asignacion 
          | asignacion
          | error ";"
          ;

//Definimios el token asignación
asignacion: REG "=" expresion ";" {printf("%s=%d\n", $1, $3) ; }  //el registro es el $1

expresion : expresion "+" termino   { printf("e->e+t\n"); $$ = $1+$3; }
          | expresion "-" termino   { printf("e->e-t\n"); $$ = $1-$3; }
          | termino                 { printf("e->t\n"); $$ = $1;  }
          ;

termino   : termino "*" factor      { printf("t->t*f\n"); $$ = $1*$3 }
          | termino "/" factor      { printf("t->t/f\n"); 
                                      if ($3==0){
                                         printf("Division por cero\n");
                                         exit(1);
                                      }
                                      $$ = $1/$3;  
                                    }
          | factor                  { printf("t->f\n"); $$ = $1  }
          ;

factor    : NUM                     { printf("f->NUM %d\n", $1); $$ = $1; }
          | "(" expresion ")"       { printf("f->(e)\n"); $$ = $2;  }
          | "-" factor              { printf("f->-f\n"); $$ = -$2;   }
          ;

%%

void yyerror(const char *msg) {
    printf("Error en linea %d: %s\n", yylineno, msg);
}
