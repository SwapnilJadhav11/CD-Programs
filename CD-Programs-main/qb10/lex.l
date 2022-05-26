/*comment lines*/

%{
int count =0;
%}


start \/\*
end \*\/

%%
\/\/(.*) ; 

{start}.*{end} {count++; fprintf(yyout, "%d", count);}

%%

int main(int argc, char* argv[])
{
   yyin = fopen(argv[1], "r");
   yyout = fopen("out.txt", "w");
   yylex();
   return 1;
}

int yywrap()
{
   return 1;
}