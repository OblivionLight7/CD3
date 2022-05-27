%{

%}
start \/\*
end  \*\/
  
/*Rule Section*/
%%
  
\/\/(.*) ;

{start}.*{end} ;

%%

/*Driver function*/
int main(int k,char **argcv)
{
    yyin=fopen(argcv[1],"r");
    yyout=fopen("out.txt","w");
    int yylex();
    return 1 ;
}

int yywrap()
{
    return 1;
}
