%{
    #include<string.h>

    char replacep[] = "writef";
    char replacedp[] = "printf";

    char replaces[] = "readf";
    char replaceds[] = "scanf";

%}

%%

[a-zA-Z]+ {if(strcmp(yytext, replacedp)==0){
                fprintf(yyout, "%s", replacep);
            }
            else if(strcmp(yytext, replaceds)==0){
                fprintf(yyout, "%s", replaces);
            }
            else{
                fprintf(yyout, "%s", yytext);
            };
          }

. {fprintf(yyout, "%s", yytext);}


%%

int main(int argc, char *argv[]){
    yyin = fopen(argv[1], "r");
    yyout = fopen("output.txt", "w");

    yylex();
    return 1;
}

int yywrap(){
    return 1;
}