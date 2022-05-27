%{
    #include "y.tab.h"
%}

alpha [A-Za-z]
digit [0-9]

%%

do {return DO;}

while {return WHILE;}

"==" |
"<=" |
">=" |
">" |
"<" |
"!" |
"!=" {return RELOP;}

{digit}+ {return NUM;}

{alpha}({alpha}|{digit})* {return ID;}

. {return yytext[0];}

%%

int yywrap(){
    return 1;
}
