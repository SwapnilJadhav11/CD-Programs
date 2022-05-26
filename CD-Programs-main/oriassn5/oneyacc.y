%{
#include<stdio.h>
void yyerror(char *);
int yylex();
%}


%token IF ELSE AND OR GT EQ LT NTEQ LTEQ GTEQ ID NUM OP AOP DELIM COMP

%%
stmt:
ifelsestmt elsepart
|ifelsestmt
|elsepart
;

ifelsestmt: 
IF '(' C ')' '{' L '}'      {printf("\nParsing for IF condition Successful!\n");}
|IF '(' C ')' L            {printf("\nParsing for IF condition Successful!\n");}
|IF C ')' '{' L '}'        {printf("\nInValid IF Statement! Missing '(' before condition!\n");}
|IF '(' C '{' L '}'        {printf("\nInValid IF Statement! Missing ')' after condition!\n");}
|IF '(' C ')'  L '}'        {printf("\nInValid IF Statement! Missing '{' before statement!\n");}
|IF '(' C ')' '{' L        {printf("\nInValid IF Statement! Missing '}' after statement!\n");}
;


elsepart:
ELSE '{' L '}'          {printf("\nParsing for ELSE condition Successful!\n");}
|ELSE L                 {printf("\nParsing for ELSE condition Successful!\n");}
|ELSE L '}'          {printf("\nInValid ELSE Statement! Missing '{' before statement!\n");}
|ELSE '{' L          {printf("\nInValid ELSE Statement! Missing '}' after statement!\n");}
;


A: 
ID AOP ID OP ID DELIM
|ID AOP ID DELIM 
|ID OP DELIM
|ID NUM DELIM
|ID ID DELIM
;


C: 
ID
|ID relop ID
|ID relop NUM
|ID relop ID relop ID relop ID
|ID relop NUM relop ID relop NUM
;

L: 
ID
|NUM
|A 
|A L
;



relop: 
NTEQ
|EQ
|GT
|LT
|LTEQ
|GTEQ
|OR
|COMP
;

%%

void yyerror(char *s)
{
   printf("\nParsing Error");
}

int main()
{
   yyparse();
   return 0;
}




