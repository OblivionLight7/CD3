%{
#include "y.tab.h"
#include<stdio.h>
#include<math.h>
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {yylval.fval=atof(yytext);return NUMBER;}

[ \t ]  ;  /*ignore whitespace*/
\n	return END;
.	return yytext [0];    
%%