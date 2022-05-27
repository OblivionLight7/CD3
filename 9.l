%{
    #include<stdio.h>
    #include<string.h>
  
    char replace_printf [] = "writef";
    char replacep [] ="printf";

    char replace_scanf [] = "readf";
    char replaces [] ="scanf";
  
%}

%%

[a-zA-Z]+ { if(strcmp(yytext, replacep)==0)
                fprintf(yyout,"%s",replace_printf);
            else if(strcmp(yytext, replaces)==0)
                fprintf(yyout,"%s",replace_scanf);
            else
                    fprintf(yyout, "%s", yytext);
                    }


.   fprintf(yyout, "%s", yytext);

%%

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    yyout = fopen("output.txt", "w");

    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}