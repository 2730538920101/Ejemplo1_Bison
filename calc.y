%{
#include <stdio.h>
%}
%union{
    int entero;
}
%token <entero> TOK_ENTERO
%token TOK_OPERAR
%token TOK_PARAPERTURA
%token TOK_PARCIERRE

%start inicio

%left '+' '-'
%left '*' 

%type <entero> expresion_entero

%%
inicio:     TOK_OPERAR TOK_PARAPERTURA expresion TOK_PARCIERRE '\n'{printf("ANALISIS REALIZADO CON EXITO");}
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
    return(yyparse());
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
