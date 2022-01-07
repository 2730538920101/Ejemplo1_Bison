%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
#define TOK_ERROR -1
%}


%option noyywrap
%option caseless

blanco          [ \t\r\f\n]+
entero          [0-9]+
operar          "operar" 
parapertura     "("
parcierre       ")"
operador        "+"|"-"|"*"
ptcoma          ";"
nombre          [A-Za-z]+[_0-9A-Za-z]*
pregunta        "Cual es tu nombre:"
%%


{blanco}        ;
{entero}        {yylval.entero = atoi(yytext);
                 return TOK_ENTERO;}
{operar}        {return TOK_OPERAR;}
{parapertura}   {return TOK_PARAPERTURA;}
{parcierre}     {return TOK_PARCIERRE;}
{operador}      {return yytext[0];}
{ptcoma}      {return TOK_PTCOMA;}
{nombre}        {yylval.nombre = strdup(yytext); return TOK_NOMBRE;}
{pregunta}        {return TOK_PREGUNTA;}

.               {printf("ERROR LEXICO\n");
                 return TOK_ERROR;}

%%
