%{
#include "oriassn4y.tab.h"
#include<stdio.h>
#include<math.h>
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  {yylval.fval = atof(yytext); return NUMBER;}
sqrt |
SQRT {return SQRT;}
log |
LOG  {return LOG;}
sin |
SIN  {return SIN;}
cos |
COS  {return COS;}
tan |
TAN  {return TAN;}
cosec |
COSEC {return COSEC;}
sec |
SEC {return SEC;}
cot |
COT  {return COT;}

[ \t ]  ;

\n return END;
. return yytext [0];

%%
