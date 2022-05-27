%{
    int count = 0;
%}

letter [a-zA-Z]

%%

{letter}{letter}* {count++;}

[\t]+ ;

[\n] ;

%%

int main(int argc, char *argv[])
{
    yylex();
    yyin = fopen(argv[1], "rb+");
    printf("Number of words are : %d", count);
    return 0;
}

int yywrap()
{
    return(1);
}