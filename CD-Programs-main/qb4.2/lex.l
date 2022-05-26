/*
switch case
*/

%{
#include<stdio.h>
#include "yacc.tab.h"
void yyerror(char* s);
%}

%%
"switch"    {return SWITCH;}
"case"    {return CASE;}
"break"    {return BREAK;}
"default"    {return DEFAULT;}
";"      {return DELIM;}
"+"|"-"|"*"|"/"|":"     {return OP;}
"="      {return AOP;}
"||"     {return OR;}
"&&"     {return AND;}
"=="     {return COMP;}
"!="     {return  NTEQ;}
">"     {return GT;}
">="     {return GTEQ;}
"<"     {return LT;}
"<="     {return LTEQ;}
[ \t\n]+ ;
[a-zA-Z]+[a-zA-Z0-9]*   {return ID;}
[0-9]+ {return NUM;}
. return yytext [0];
%%

int yywrap()
{
   return 1;
}