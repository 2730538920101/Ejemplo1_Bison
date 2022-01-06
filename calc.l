%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
#define TOK_ERROR -1
%}


%option noyywrap

blanco          [ \t\r\f\n]+
entero          [0-9]+
operar          "operar" 
parapertura     "("
parcierre       ")"
operador        "+"|"-"|"*"

%%


{blanco}        ;
{entero}        {yylval.entero = atoi(yytext);
                 return TOK_ENTERO;}
{operar}        {return TOK_OPERAR;}
{parapertura}   {return TOK_PARAPERTURA;}
{parcierre}     {return TOK_PARCIERRE;}
{operador}      {return yytext[0];}
.               {printf("ERROR LEXICO\n");
                 return TOK_ERROR;}

%%
