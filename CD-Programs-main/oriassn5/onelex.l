%{
#include<stdio.h>
#include<string.h>
#include "oneyacc.tab.h"
void yyerror(char *);
%}



%%
"+"|"-"|"++"|"--"     { return OP; }
"="      { return AOP; }
";"      { return DELIM; }
"if"     { return IF; }
"else"   { return ELSE; }
"$$"     { return AND; }
"||"     { return OR; }
"!="     { return NTEQ; }
">"      { return GT; }
">="     { return GTEQ; }
"<"      { return LT; }
"<="     { return LTEQ; }
"=="     {return COMP;}


[ \t\n]+    ;
[a-zA-Z]+[a-zA-Z0-9]*    {return ID;}
[0-9]+      {return NUM;}
.           return yytext[0];

%%


int yywrap()
{
return 1;
}