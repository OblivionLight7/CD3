digit [0-9]
letter [A-Za-z_]
%{
    //This is a lexical analyzer for a subset of C language
    #include <stdio.h>
    #include <string.h>
    int lno = 1;
    char symtab[100][100];
    int symtabidx = 0;
    void handle_symtab(char*);
    void print_symtab();
    char match[100];
%}

%%

[\t]+ ;

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

[\n] {lno++;}

%%

int main()
{

    extern FILE *yyout;

    yyout = fopen("output.txt", "w");
    fprintf(yyout, "Token Listing for Subset of C languages\n");
    fprintf(yyout, "Lexeme\tLine\t\tToken\n");

    yylex();

    print_symtab();

    fclose(yyout);

    return 0;
}

void handle_symtab(char *text)
{
    for (int i = 0; i<symtabidx; i++)
    {
        if(strcmp(symtab[i], text) == 0)
            return ;
    }
    strcpy(symtab[symtabidx++], text);
}

void print_symtab()
{
    fprintf(yyout, "\n\nSymbol Table\n");
    fprintf(yyout,"Index\t\tSymbol\n");
    for(int i=0;i<symtabidx;i++)
    {
        fprintf(yyout, "%d\t\t%s\n", (i+1), symtab[i]);
    }
}

int yywrap()
{
    return(1);
}