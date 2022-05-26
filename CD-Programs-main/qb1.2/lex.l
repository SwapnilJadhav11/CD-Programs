/*
this includes 1.2, 1.4, subset of C
*/

%{
#include<stdio.h>
int line = 1; 
%}

%%

"float"|"int"|"if"|"else"  { printf(" \n %d\t%s\t\t Keyword", line , yytext); }

\n line++;
%%

int main(int argc, char* argv[])
{  
   yyin = fopen(argv[1], "r");
   //printf("\nEnter a word: ");
   printf("\nLine | Lexeme | \tToken\n");
   yylex();
   fclose(yyin);

}

int yywrap()
{
   return 1;
}
