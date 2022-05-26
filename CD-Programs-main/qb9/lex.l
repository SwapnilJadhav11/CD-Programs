/*replace printf and scanf*/

%{
#include<stdio.h>
#include<string.h>

char replace_printf [] = "writef"; 
char replacep [] = "printf";

char replace_scanf [] = "readf"; 
char replaces [] = "scanf";
int pcount=0;
int scount=0;

%}

%%
[a-zA-Z]+   {  if(strcmp(yytext, replacep)==0) 
               {
                  pcount++;
                  fprintf(yyout, "\n%d\n", pcount); 
                  fprintf(yyout, "%s", replace_printf); 
               }
               else if(strcmp(yytext, replaces)==0)
               {
                  scount++;
                  fprintf(yyout, "\n%d\n", scount);
                  fprintf(yyout, "%s", replace_scanf);
               }
               
               else 
               {
                  fprintf(yyout, "%s", yytext);
               }
            }

. fprintf(yyout, "%s", yytext);

%%


int main(int argc, char* argv[])
{
   yyin = fopen(argv[1], "r");
   yyout = fopen("output.txt", "w");
   yylex();
   return 0;
}

int yywrap()
{
   return 1;
}