/*
identifier count
*/

%{
   #include<stdio.h>
   int idcount = 0;
%}


%%
[a-zA-Z]+[a-zA-Z0-9]*   {idcount++;}
[ \t\n] ;

%%

int main(int argc, char* argv[])
{
   yyin = fopen(argv[1], "r");
   yylex();
   printf("\n The count is: %d", idcount);
   fclose(yyin);
   
   return 0;
}

int yywrap()
{
   return 1;
}
