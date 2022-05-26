/*
Arithmatic
*/


%{
#include<stdio.h>
#include "yacc.tab.h"
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)   {yylval.fval = atof(yytext); return NUMBER;}
sqrt |
SQRT     {return SQRT;}

[ \t ] ;
. return yytext [0];

\n {return END;}
%%
