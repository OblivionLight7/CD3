%{
    #include<stdio.h>
    int i=0,yr=0,valid=0,leap=0;
    void check(char *date);
%}
%%
([0-2][0-9]|[3][0-1])\/((0(1|3|5|7|8))|(10|12))\/([1-2][0-9][0-9][-0-9]) {valid=1; check(yytext);}

([0-2][0-9]|30)\/((0(4|6|9))|11)\/([1-2][0-9][0-9][0-9]) {valid=1; check(yytext);}

([0-1][0-9]|2[0-8])\/02\/([1-2][0-9][0-9][0-9]) {valid=1; check(yytext);}

29\/02\/([1-2][0-9][0-9][0-9]) { while(yytext[i]!='/')i++; i++;while(yytext[i]!='/')i++;i++;while(i<yyleng)yr=(10*yr)+(yytext[i++]-'0'); if(yr%4==0||(yr%100==0&&yr%400!=0))leap = valid = 1;}

%%
main()
{
    yylex();
    if(valid==1) printf("It is a valid date\n");
    else printf("It is not a valid date\n");

    if(leap==1)
        printf("It is a leap year");
}
int yywrap()
{
    return 1;
}

void check(char *date){
    i=0;
    while(date[i]!='/')
        i++;
    
    i++;
    while(date[i]!='/')
        i++;
    i++;
    while(i<strlen(date)){
        yr=(10*yr)+(yytext[i++]-'0');
    }

    if(yr%4==0||(yr%100==0&&yr%400!=0))
        printf("Leap Year");
    else
        printf("Not a Leap Year");

}