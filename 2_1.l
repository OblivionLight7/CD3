%{
    // Word Recognizer with symbol table

enum{
    LOOKUP = 0, //Default - looking rather than defining
    VERB,
    NOUN,
    PREP,
    CONJ
};

int state;

int add_word(int type, char *word);
int lookup_word(char *word);

%}

%%

\n      {state = LOOKUP; }
^verb   { state = VERB; }
^noun   { state = NOUN; }
^prep   { state = PREP; }
^conj   {state = CONJ; }

[a-zA-Z]+ {
                if(state!=LOOKUP){
                    add_word(state, yytext);
                } else {
                    switch(lookup_word(yytext)){
                        case VERB: printf("%s : verb\n", yytext); break;
                        case NOUN: printf("%s : noun\n", yytext); break;
                        case PREP: printf("%s : preposition\n", yytext); break;
                        case CONJ: printf("%s : conjunction\n", yytext); break;
                        default:
                            printf( "%s : doesn't recognize\n", yytext) ;
                            break;
                    }
                }
        }
. ;

%%

int main()
{
    yylex();
    return 0;
}

// define a linked list of words and types

struct word {
    char *word_name;
    int word_type;
    struct word *next;
};

struct word *word_list;
extern void *malloc();

int add_word(int type, char *word)
{
    struct word *wp;

    if(lookup_word(word) != LOOKUP){
        printf("Word %s Already defined", word);
        return 0;
    }

    // word not there, allocate a new entry and link it onto the list

    wp = (struct word *) malloc(sizeof(struct word));

    wp->next = word_list;

    // have to copy the word itself as well

    wp->word_name = (char *) malloc(strlen(word)+1);
    strcpy(wp->word_name, word);
    wp->word_type = type;
    word_list = wp;
    return 1;
}

int lookup_word (char *word){
        struct word *wp = word_list;
        /* search down the list looking for the word */
        for(; wp; wp = wp->next) {
            if(strcmp(wp->word_name, word) == 0)
                return wp->word_type;
        }
        return LOOKUP; /* not found */
}

int yywrap()
{
    return 1;
}