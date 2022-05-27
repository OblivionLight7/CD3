digit [0-9]

%{
    //headers
    int neg = 0;
    int pos = 0;
%}

%% 

^[-][0-9]+ {neg++;
                    printf("negative number = %s\n",
                                    yytext);}


[0-9]+ {pos++;
                    printf("negative number = %s\n",
                                                        yytext);}

[\t]+ ;

%%

int main(){

    yylex();

    printf("The number of negative integers are %d, and the number of positive integers are %d", neg, pos);

    return 0;
}

int yywrap()
{
    return 1;
}
