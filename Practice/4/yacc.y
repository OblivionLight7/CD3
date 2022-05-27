%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token DO WHILE RELOP NUM ID

%%

statement : expression {printf("Input accepted!");}
;

expression : WHILE '(' condition ')' '{' action ';' '}' 
| DO '{' action ';' '}' WHILE '(' condition ')' 
;

condition : ID RELOP ID 
| ID RELOP NUM 
| NUM RELOP ID
;

action : action '+' action
| action '-' action
| action '*' action 
| action '=' action 
| ID 
| NUM
;

%%

int main(){
    printf("Enter the expression : \n");
    yyparse();
}

int yyerror(){
    printf("Input rejected");
}