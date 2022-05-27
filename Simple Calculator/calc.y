%{
   #include<stdio.h>
   #include<math.h>
%}

%union
{
   float fval;   
}


%token<fval>NUMBER
%token END
%left '+' '-'
%left '*' '/'


%type<fval>expression



%%
statement: 
expression END  {printf(" = %.4f \n ", $1); return 0;}
;
expression:
expression '+' expression {$$ = $1 + $3;}
|expression '-' expression {$$ = $1 - $3;}
|expression '*' expression {$$ = $1 * $3;}
|expression '/' expression { if($3==0){printf("Divide by zero not allowed!"); return 0;}
				else{
				$$ = $1 / $3;}}
;
expression:
NUMBER {$$=$1;}
%%

int main()
{
   yyparse();
}

int yyerror(char* s)
{
   printf("%s\n",s);
   return 0;
}

int yywrap()
{
   return 0;
}
