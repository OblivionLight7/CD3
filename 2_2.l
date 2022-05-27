%{
    int count = 0;
%}

%%

"//".*\n            { count++; }
"/*"[^*/]*"*/"      { count++; }


%%

int main()
{
    yyin=fopen("input.txt","r");
    yyout=fopen("output.txt","w");
    yylex();
    fprintf(yyout, "\n\n NOTE: Number of comments removed : %d", count);
    return 0;
}

int yywrap()
{
    return 1;
}