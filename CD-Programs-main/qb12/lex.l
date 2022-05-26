/*count of vowels and consonants*/


%{
#include<stdio.h>
#include<string.h>
int cons=0;
int vow=0;
%}

%%
[aeiouAEIOU]  {vow++;}
[a-zA-Z]   {cons++;}
%%

int main()
{
   yylex();
   printf("\nThe number of vowels are %d, consonents are %d", vow, cons);
   return 0;
}

int yywrap()
{
   return 1;
}

