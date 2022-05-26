/*count of negative and positive int*/ 

%{
int pos=0;
int neg=0;
%}


%%
^[-][0-9]+  {neg++; printf("\nNegative int: %s", yytext);}   
[0-9]+  {pos++; printf("\nPositive int: %s", yytext);}   

[\t]+ ;
%%


int main(int argc, char* argv[])
{
   yylex();
   printf("\nThe number of positive int are %d and  negative integers are %d", pos, neg);
   return 1;
}

int yywrap()
{
   return 1;
}
