%{
    #include<math.h>
    #include<stdio.h>
    double vbltable[26];    
%}

%union {
    int vblno;
    double dval;
}

%token <vblno> NAME
%token <dval> NUMBER
%token SQRT 


%left SQRT
%left '+' '-'
%left '^'
%left '*' '/'

%type <dval> expression

%%

start : statement '\n' |
start statement '\n'
;

statement : NAME'='expression {vbltable[$1]=$3;}
| expression {printf("Answer = %g\n",$1);}
;

expression : expression '+' expression {$$ = $1+$3;}
| expression '-' expression {$$ = $1-$3;}
| expression '*' expression {$$ = $1*$3;}
| expression '^' expression {$$ = pow($1,$3);}
| expression '/' expression {if($3==0){printf("Division by 0 not allowed!"); return 0;}
                            else {$$ = $1/$3;} ;}
|SQRT expression {$$ = sqrt($2);}
| NAME {$$ = vbltable[$1];}
| NUMBER {$$ = $1;}
;
%%

int main(){
    printf("Enter a mathematical expression: \n");
    yyparse();
}
int yyerror(char *error){
    printf("%s\n", error);
} 