/*
this includes 1.5 and 1.6 word count
*/

%{
#include<stdio.h>
int wordcount=0;
%}

letter [a-zA-Z]

%%
{letter}+ {wordcount++; printf("\n %s is a word, wordcount = %d", yytext, wordcount);}

\n ;
%%

int main(int argc, char* argv[])
{
   yyin = fopen(argv[1], "r");
   yylex();
   fclose(yyin);
}

int yywrap()
{
   return 1;
}