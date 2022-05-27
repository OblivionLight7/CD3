%{
    // for dynamic allocation we need states represented as numbers, and a linked list to add indefinite number of values

    enum {
        LOOKUP = 0,
        KEYWORD,
        DELIMITER,
        OPERATOR,
        IDENTIFIER
    };

    int state;

    int add_word(int state, char *word)
    int lookup_word(char *word)

    
%}

// rules

%%

[\n]        {state=LOOKUP;}

^keyword    {state=KEYWORD;}

^operator   {state=OPERATOR;}

^delimiter  {state=DELIMITER;}

^identifier {state=IDENTIFIER;}

[a-zA-Z]+   {if(state != LOOKUP)
                add_word(state, word)    
            else{
                    switch(lookup_word(yytext))
                    {
                        case KEYWORD : printf("%s : is a Keyword", yytext);break;

                        case OPERATOR : printf("% : is an Operator", yytext);break;

                        case DELIMITER : printf("%s : is a Delimiter", yytext);break;

                        case IDENTIFIER : printf("%s : is an Identifier". yytext);braek;

                        default : printf("%s not defined", yytext);break;
                    }
                }
            }

%%

struct word{
    char *word_name,
    int word_type,
    struct word *next_word
};

struct word *word_list;
extern void *malloc;

int add_word(int state, char *word){
    struct word *new_word;

    // check if word is already defined 
    if(lookup_word(word) != LOOKUP){
        printf("Word %s Already defined", word);
        return 0;
    }

    new_word = (struct word*) malloc(sizeof(struct word));
    new_word->next = word_list;

    new_word->name = (char *) malloc(strlen(word)+1);
    strcpy(new_word->word_name, word);

    new_word->word_type = type;
    word_list = new_word;

    return 1;    
}

int lookup_word(char *word){
     struct word *wp = word_list;
        /* search down the list looking for the word */
        for(; wp; wp = wp->next) {
            if(strcmp(wp->word_name, word) == 0)
                return wp->word_type;
        }
        return LOOKUP; /* not found */
}

int main(){
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}