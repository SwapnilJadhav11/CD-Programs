/*lookup english*/

%{
   #include<stdio.h>
   #include<string.h>

   enum {
      LOOKUP = 0,
      VERB,
      NOUN,
      PREP,
      CONJ
   };

   int state;
   int add_word(int type, char* word);
   int look_up(char* word);
%}



%%
\n {state = LOOKUP;}
^noun|NOUN  {state = NOUN;}
^verb|VERB  {state = VERB;}
^prep|PREP  {state = PREP;}
^conj|CONJ  {state = CONJ;}

[a-zA-Z]+   {if(state != LOOKUP)
               {
                  add_word(state, yytext);
               }
               else
               {
                  switch(look_up(yytext))
                  {
                     case NOUN: printf("\n %s is a noun",yytext); break; 
                     case VERB: printf("\n %s is a verb",yytext); break; 
                     case PREP: printf("\n %s is a prep",yytext); break; 
                     case CONJ: printf("\n %s is a conj",yytext); break; 
                     default: printf("\n %s is not recognised", yytext); break;
                  }
               }
            }

. ;

%%


struct word {
   int word_type;
   char* word_name;
   struct word *next;
};

struct word* word_list;


int add_word(int type, char* word)
{
   struct word* wp;

   if(look_up(word) != LOOKUP)
   {
      printf("\n%s is already defined!");
      return 0;
   }

   wp = (struct word*)malloc(sizeof(struct word));
   wp->next = word_list;
   wp->word_name = (char*)malloc(strlen(word)+1);
   strcpy(wp->word_name, word);
   wp->word_type = type;
   word_list = wp;
   return 1;         //when success
}


int look_up(char* word)
{
   struct word *wp = word_list;
   for(;wp;wp=wp->next)
   {
      return wp->word_type;
   }
   return LOOKUP;
}




int main()
{
   yylex();
   return 0;
}


int yywrap()
{
   return 1;
}