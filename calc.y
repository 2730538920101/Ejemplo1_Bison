%{
#include <stdio.h>
extern FILE *yyin;

%}
%union{
    int entero;
    char *nombre;
}
%token <entero> TOK_ENTERO
%token TOK_OPERAR
%token TOK_PARAPERTURA
%token TOK_PARCIERRE
%token TOK_PTCOMA
%token TOK_PREGUNTA
%token <nombre>TOK_NOMBRE

%start inicio

%left '+' '-'
%left '*' 


//noterminal
%type <entero> expresion_entero
%type <nombre> respuesta

%%
inicio:   instrucciones { return 0;}
    ;

instrucciones: instruccion instrucciones
        | instruccion
    ;

instruccion:    TOK_OPERAR TOK_PARAPERTURA expresion TOK_PARCIERRE TOK_PTCOMA
                | respuesta
  ;  

respuesta:
    TOK_PREGUNTA TOK_NOMBRE TOK_PTCOMA{ printf("%s\n",$2);  }
;

expresion:          expresion_entero{printf("EL RESULTADO DE UNA OPERACION CON ENTEROS ES: %d\n",$1);}
                    ;


expresion_entero:    TOK_ENTERO{$$ = $1;}
                    |expresion_entero '+' expresion_entero{$$ = sumar_e($1,$3);}
                    |expresion_entero '-' expresion_entero{$$ = restar_e($1,$3);}
                    |expresion_entero '*' expresion_entero{$$ = multiplicar_e($1,$3);}
                    |TOK_PARAPERTURA expresion_entero TOK_PARCIERRE {$$ = $2;}
                    ;

%%
int main(){
    FILE *file = fopen("entrada.txt", "r");
    yyin = file;
    yyparse();
    fclose(yyin);
}

void yyerror(char* s){
    fprintf(stderr, "%s\n" , s);
}


int sumar_e(int a, int b){
    return a + b;
}

int restar_e(int a, int b){
    return a - b;
}

int multiplicar_e(int a, int b){
    return a * b;
}
