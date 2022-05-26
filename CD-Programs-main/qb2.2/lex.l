/*count comments, ignore and store in output*/


%{
#include<stdio.h>
int comcount =0;
int line=0;
%}

letter [a-zA-Z]
num [0-9]

%%
"//"   {comcount++;}

"int"|"float"     {printf("\n %d\t%s \t\tKeyword", line,yytext);}
"("|")"           {printf("\n %d\t%s \t\tDelimiter", line,yytext);}
"+"|"-"           {printf("\n %d\t%s \t\tOperator",line, yytext);}

{letter}+|({letter}+{num})*   {printf("\n %d\t%s \t\tIdentifier", line,yytext);}
{num}+                        {printf("\n %d\t%s \t\tConstant", line,yytext);}

\n {line++;}

%%

int main(int agrc, char* argv[])
{
   yyin = fopen(argv[1], "r");
   yyout = fopen("output.txt", "w");
   yylex();
   fprintf(yyout, "\nThe number of comments are: %d", comcount);
   fclose(yyin);
   fclose(yyout);
}


int yywrap()
{
   return 1;
}