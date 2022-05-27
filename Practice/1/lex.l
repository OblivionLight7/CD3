%{
    #include<stdio.h>
    #include<string.h>

    char symtab[100][100];
    char symbol[100];
    char match[100];

    int lno=1;
    int symtabidx=0;

    void handle_symtab(char *);
    void print_symtab();
%}

digit [0-9]
letter [a-zA-Z_]

%%


[ \t]+ ;

int |
float |
double |
String |
char |
if |
for |
else |
do |
while |
printf |
static |
void |
public {fprintf(yyout,"%s\t\t%d\t\tKeyword\n", yytext, lno);}

; |
, |
\" |
\' |
: |
\{ |
\} |
\( |
\) {fprintf(yyout,"%s\t\t%d\t\tDelimiter\n", yytext, lno);}

\+ |
\- |
\* |
\/ |
\^ {fprintf(yyout,"%s\t\t%d\t\tOperator\n", yytext, lno);}

\= |
\> |
\< |
\|\| |
\&\& |
\>\= |
\<\= |
\! |
\!\= {fprintf(yyout,"%s\t\t%d\t\tLogical Operator\n", yytext, lno);}

{letter}({letter}|{digit})* {fprintf(yyout,"%s\t\t%d\t\tIdentifier\n", yytext, lno);
                             strcpy(match, yytext);
                             handle_symtab(match);}

{digit} |
{digit}.{digit} {fprintf(yyout,"%s\t\t%d\t\tNumeric\n", yytext, lno);}

\"[^"\n]*\" {   strncpy(match, &yytext[1], strlen(yytext) - 2);
                fprintf(yyout, "\"\t\t%d\t\tDelimiter\n", lno);
                fprintf(yyout, "%s\t\t%d\t\tConstant\n", match, lno);
                fprintf(yyout, "\"\t\t%d\t\tDelimiter\n", lno);
}


[\n] {lno++;}


%%

int main(int argv, char *argc[]){
    yyin = fopen(argc[1], "r");
    yyout = fopen("output.txt", "w");

    fprintf(yyout, "Tokenization\n");
    fprintf(yyout, "Lexeme\tLine No.\tToken\n");

    yylex();

    print_symtab();

    return 0;
}

int yywrap(){
    return 1;
}

void handle_symtab(char *symbol){
    for(int i=0;i<symtabidx;i++){
        if(strcmp(symtab[i], symbol)==0){
            return 0;
        }
    }

    strcpy(symtab[symtabidx++], symbol);
}

void print_symtab(){
    fprintf(yyout, "\n\nIndex\tSymbol\n");

    for (int i=0; i<symtabidx; i++){
        fprintf( yyout, "%d\t\t%s\n", (i+1), symtab[i]);
    }
}