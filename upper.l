lower [a-z]

upper [A-Z]

%%

[ \t] printf(" ") ;

{lower} {printf("%c", yytext[0]-32);}
{upper} {printf("%c", yytext[0]+32);}

. ;

%%

int main(){
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}