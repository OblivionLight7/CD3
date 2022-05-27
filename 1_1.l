%{
    // This is a lexical analyzer for a subset of C languages

    // this is the definition section, important when using header files
%}

%%

    /*this is the rules section*/

[\t]+   /*ignores white space*/ ;


is |
am |
are |
were |
was |
be |
being |
been |
do |
does |
did |
will |
would |
should |
can |
could |
has |
have |
had |
go {printf("%s: is a verb\n", yytext);} //array yytext contains the text that the pattern matched

a |
an |
the {printf("%s: is an article\n", yytext);}

if |
then |
and |
but |
or |
so {printf("%s: this is a conjunction\n", yytext);}

he |
her |
him |
she |
them |
they {printf("%s: this is a preonoun\n", yytext);}

[a-zA-Z]+ {printf("%s: is not recognized, may be noun\n", yytext);}

.|\n {ECHO; /*normal default*/}
%%

// user subroutines section which consists of any legal c code
main()
{
    yylex();
}

int yywrap()
{
    return(1);
}