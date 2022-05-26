%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int yylex();
void yyerror(char* s);
%}

%token NUM ID SWITCH CASE DEFAULT BREAK COMP NTEQ GTEQ GT LTEQ LT OR AND OP AOP DELIM


%%
S : ST {printf("\nParsing of SWITCH successful!"); return 0;}
;

ST: SWITCH '(' ID ')' '{' B '}'
;

B: C 
| C D
;

C: CASE NUM OP E DELIM
|CASE ID OP E DELIM
|BREAK DELIM
;


D: DEFAULT OP E DELIM BREAK DELIM
;

E: 
ID
|NUM
|ID OP ID
|ID OP NUM
|ID AOP ID OP ID
|ID AOP ID OP NUM
|ID AOP ID
|ID AOP NUM
;

%%


int main(int argc, char* argv[])
{
   printf("\nEnter a expression: ");
   yyparse();
   return 0;
}


void yyerror(char* s)
{
   printf("\nERROR: %s", s);
}