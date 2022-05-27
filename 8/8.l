%{
    int identifier=0;
%}

digit [0-9]
letter [a-zA-Z_]

%%

[ \t]+ ;


int |
float |
double |
String |
char |
if |
for |
else |
do |
while |
printf |
static |
void |
public ;

; |
, |
\" |
\' |
: |
\{ |
\} |
\( |
\) ;

\+ |
\- |
\* |
\/ |
\^ ;

\= |
\> |
\< |
\|\| |
\&\& |
\>\= |
\<\= |
\! |
\!\= ;

{digit} |
{digit}.{digit} ;

\"[^"\n]*\" ;


{letter}({letter}|{digit})* {printf("Identifier - %s\n",yytext);
                            identifier++;}

[\n] ;


%%

int main(){


    yyin = fopen("input.txt", "r");
    yylex();
    printf("The number of identifiers are : %d", identifier);
    return 1;

}

int yywrap(){
    return 1;
}