%{
    #include "y.tab.h"
    #include <math.h>
    extern double vbltable[26];
%}

%%

[ \t] ;

[0-9]+ {yylval.dval = atof(yytext);
        return NUMBER;}

sqrt {return SQRT;}

[a-z]+ {yylval.vblno = yytext[0] - 'a';
        return NAME;}

\$ return 0;

\n|. return yytext[0];
%%

int yywrap(){
    return 1;
}