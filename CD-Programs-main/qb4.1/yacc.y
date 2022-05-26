%{
#include<stdio.h>
void yyerror(char *s);  
int yylex();
%}

%token ID NUM OP AOP GT GTEQ LT LTEQ DELIM FOR COMP

%%
statement:
for
;

for:
FOR '(' C ')' '{' L '}'    {printf("\nParsing of For Loop successful!");}
FOR '(' C ')'  L           {printf("\nParsing of For Loop successful!");}
|FOR C ')' '{' L '}'    {printf("\nERROR! Missing '(' ");}
|FOR '(' C  '{' L '}'    {printf("\nERROR! Missing ')' ");}
|FOR '(' C ')'  L '}'    {printf("\nERROR! Missing '{' ");}
|FOR '(' C ')' '{' L     {printf("\nERROR! Missing '}' ");}
;

A:
ID AOP ID OP ID DELIM
|ID AOP ID DELIM 
|ID OP DELIM
|ID NUM DELIM
|ID ID DELIM
;

C:
ID AOP NUM DELIM ID relop ID DELIM ID OP
|ID AOP NUM DELIM ID relop NUM DELIM ID OP
;


L:
ID
|NUM
|A 
|A L
;

relop:
COMP
|GT 
|LT 
|GTEQ 
|LTEQ 
;

%%

int main()
{
   yyparse();
   return 0;
}

void yyerror(char* s)
{
   printf("ERROR: %s", s);
}


