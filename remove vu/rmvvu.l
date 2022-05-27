%{  
    int count=0; 
    char replace[] = "vu";
%}

%%

[a-zA-Z]+ {if (strcmp(yytext, replace)==0)
            {printf("");
            count++;}
            else{
                printf("%s", yytext);
            };}

. {printf("%s", yytext);}

%%

int main(int argc, char *argv[]){
    yyin = fopen(argv[1], "rb+");
    yylex();

    printf("\n\n%d vu", count);

    return 0;
}

int yywrap(){
    return 1;
}