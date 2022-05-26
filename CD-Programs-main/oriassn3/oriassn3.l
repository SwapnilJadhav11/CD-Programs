%{
#include<stdio.h>
#include<string.h>


enum {
   LOOKUP = 0,
   KEYWORD,
   DELIMITER,
   OPERATOR,
   CONSTANT,
   IDENTIFIER
};

int state;
int add_word(int type, char* word);
int look_up(char* word);

%}

%%

\n {state = LOOKUP;}

^keyword|KEYWORD {state=KEYWORD;}
^delimiter|DELIMITER {state=DELIMITER;}
^operator|OPERATOR {state=OPERATOR;}
^identifier|IDENTIFIER {state=IDENTIFIER;}
^constant|CONSTANT {state=CONSTANT;}


[a-zA-Z]+[0-9a-zA-Z]*   {if(state != LOOKUP)
                           {
                              add_word(state, yytext);
                           }
                           else
                           {
                              switch(look_up(yytext))
                              {
                                 case IDENTIFIER: printf("%s is an identifier\n", yytext); break;
                                 case KEYWORD: printf("%s is an keyword\n", yytext); break;
                                 default: printf("%s is not recognised\n", yytext); break;
                              }  
                           }
                        }




"+"|"-"|"*"|"/"|"++"|"--"  {if(state != LOOKUP)
                              {
                                 add_word(state, yytext);
                              }
                              else
                              {
                                 switch(look_up(yytext))
                                 {
                                    case OPERATOR: printf("%s is an operator\n", yytext); break;
                                    default: printf("%s is not recognised", yytext); break;
                                 }
                              }
                           }


"("|")"|","|";"|":"|"{"|"}"|"["|"]"    {if(state != LOOKUP)
                                          {
                                             add_word(state, yytext);
                                          }
                                          else
                                          {
                                             switch(look_up(yytext))
                                             {
                                                case DELIMITER: printf("%s is a delimiter\n", yytext); break;
                                                default: printf("%s is not recognised", yytext); break;
                                             }
                                          }
                                       }   


[0-9]+      {if(state != LOOKUP)
               {
                  add_word(state,yytext);
               }
               else
               {
                  switch(look_up(yytext))
                  {
                     case CONSTANT: {printf("%s is a Constant\n", yytext); break;}
                     default: printf("%s is not recognised",yytext); break;
                  }
               }
            }   


[0-9]+([A-za-z]|[0-9])*    {printf("%s is invalid", yytext);}                                                               


. //ignore everything else                           

%%


int main(int argc, char* argv[])
{
   yylex();
}




struct word 
{
   int word_type;
   char* word_name;
   struct word *next;
};

struct word *word_list; 


int add_word(int type, char* word)
{
   struct word *wp;

   if(look_up(word) != LOOKUP)
   {
      printf("%s word already in list!", yytext);
      return 0;
   }

   wp = (struct word*)malloc(sizeof(struct word));
   wp->next = word_list;

   wp->word_name = (char*)malloc(strlen(word)+1);
   strcpy(wp->word_name, word);
   wp->word_type = type;
   word_list = wp;
   return 1;  
}


int look_up(char *word)
{
   struct word *wp = word_list;
   for(;wp;wp=wp->next)
   {
      if(strcmp(wp->word_name, word)==0)
      {
         return wp->word_type;
      }
   }
   return LOOKUP;  //if not recognised
}


int yywrap()
{
   return 1;
}