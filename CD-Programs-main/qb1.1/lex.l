/*lex for subset of english*/

%{
#include<stdio.h>
%}


letter [a-zA-Z]
number   [0-9]+

%%
"phone"|"table"|"chair"    {printf("%s is a noun", yytext);}
"see"|"sleep"|"eat"|"drink"    {printf("%s is a verb", yytext);}
{letter}+   {printf("%s is a letter/word", yytext);}
{number}  {printf("%s is a number", yytext);}
%%

int main()
{
   printf("\nEnter a word: ");
   yylex();
}

int yywrap()
{
   return 1;
}
