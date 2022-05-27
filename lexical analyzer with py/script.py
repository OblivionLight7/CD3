#design a lexical analyzer for any java language program

#importing libraries
import re
import pandas as pd

#define keywords
keywords = ['import',
        'int',
        'null',
        'char',
        'double',
        'float',
        'extends',
        'case',
        'continue',
        'do',
        'if',
        'else',
        'for',
        'return',
        'while',
        'enum',
        'finally',
        'final',
        'implements',
        'this',
        'throws',
        'try',
        'class',
        'public',
        'static',
        'void']

#define delimiters
delimiters = ['(', ')', '{', '}', '[', ']', ';', "'"," ", '"',",","<",">"]

#define operators
operators = ['>=', '<=', '++', '--', '!=', '&&', '||', '==', "->", '=', '+', '-', '*', '/', ">", "<", '^', "."]

#identifiers regex
identifier_regex =re.compile("^([a-zA-Z_$][a-zA-Z\\d_$]*)$")

num = re.compile("^[0-9]+$")

symtab = []
linelist = []
lexemelist = []
tokenlist = []
tokenidlist = []

def check(lno, word):
    global identifier_regex, num, operators, keywords, symtab
    curr_word = ""
    if word =="" :
        return()
    elif re.search(num,word) : 
        linelist.append(lno)
        lexemelist.append(word)
        tokenlist.append("Constant")
        tokenidlist.append(f"C,{word}")


    elif word in keywords : 
        ind = keywords.index(word)
        linelist.append(lno)
        lexemelist.append(word)
        tokenlist.append("Keyword")
        tokenidlist.append(f"KW,{ind}")


    elif word in operators : 
        ind = operators.index(word)
        linelist.append(lno)
        lexemelist.append(word)
        tokenlist.append("Operator")
        tokenidlist.append(f"OPR,{ind}")

    elif bool(re.search(identifier_regex,word)):
        if word not in symtab:
            symtab.append(word)
        ind = symtab.index(word)
        linelist.append(lno)
        lexemelist.append(word)
        tokenlist.append("Identifier")
        tokenidlist.append(f"ID,{ind}")
    else:
        cur = ""
        curr_word=""
        for ch in word:
            if ch in operators:
                if cur == "op" : 
                    curr_word+=ch
                else:
                    if curr_word != "" : 
                        check(lno, curr_word)
                    cur = "op"
                    curr_word = ch
            elif ch.isalpha() or ch.isnumeric():
                if cur == "Id" : 
                    curr_word+=ch
                else:
                    if curr_word != "" : 
                        check(lno, curr_word)
                    cur = "Id"
                    curr_word = ch
    if curr_word==word:
        # for i in output: 
        #     print(i)
        print("\nERROR AT LINE : ",lno," at : ",word)
        exit(0)
    if curr_word!="" : check(lno,curr_word)


#running out script
file = open("code.java","r")
word=""
IC = ""
flag = 0
line_number=0
quotes = False
for line in file:
    # print(line, line_number)
    IC = ""
    for ch in line.lower().strip("\n").strip("\t"):
        if ch in delimiters:
            if word!="":
                if flag == 1:
                    linelist.append(line_number)
                    lexemelist.append(word)
                    tokenlist.append("Constant")
                    tokenidlist.append(f"C,{word}")
                else:
                    check(line_number,word)
            word=""
            if ch == " ":
                continue
            else:
                ind = delimiters.index(ch)
                linelist.append(line_number)
                lexemelist.append(ch)
                tokenlist.append("Delimiter")
                tokenidlist.append(f"DL,{ind}")
                if ch == delimiters[9] :
                    if flag == 0:
                        flag = 1
                    elif flag == 1:
                        flag = 0
        else:
            word+=ch
    if word!="":
        check(line_number,word)
        word=""
    line_number+= 1

df = pd.DataFrame({'Line Number' : linelist, 'Lexeme' : lexemelist, 'Token' : tokenlist, 'Token ID': tokenidlist})

from tabulate import tabulate
print(tabulate(df, headers='keys', tablefmt='psql'))

print("Symbol Table")
print("Index\t\tSymbol")
for i in range(len(symtab)):
    print(i+1,"\t\t" ,symtab[i])