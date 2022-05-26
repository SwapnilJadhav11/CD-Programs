from prettytable import PrettyTable

delimiter = ["{","}","(",")",",",";"]
string_delimiter = {"'":7,'"':8}
operator = ["-","+","*","/","%","=","++","--","<",">","<<",">>","==",">=","<=","&","."]
keyword = ["abstract","assert","boolean","byte","case","catch","class","default","do","enum","extends","final","finally","implements","import","instanceof","interface","long","native","new","null","package","private","protected","public","return","short","static","strictfp","super","switch","synchronized","this","throw","throws","transient","try","volatile","while","int","if","char","break","continue","double","else","float","for","void"]

with open("javaprgm.txt","r") as program:
    prog = program.read().split("\n")

space_free_prog = []
found = False
final_table = PrettyTable(["Line","Lexeme","Token","Token Value"])
st = []
symbol_table = PrettyTable(["Index","Name"])
error_table = PrettyTable(["Line","Lexeme","Error"])
str=""
index = ""

def remove_space(lista):
    listb = []
    for ele in lista:
        if ele != " ":
            listb.append(ele)
        else:
            listb.append("`")
    return listb

def find_index(tstr):
    if tstr in st:
        return st.index(tstr)+1
    else:
        st.append(tstr)
        return st.index(tstr)+1

for p in prog:
    p=list(p)
    p=remove_space(p)
    space_free_prog.append(p)

for line_index,line in enumerate(space_free_prog):
    str=""
    for word_index,word in enumerate(line):
        if found:
            str=""
            found = not found
        
        if len(str) > 0 and (str[0] in ("'",'"') or str[0:2] == "/*"):
            if word == "`":
                str += " "
            else:
                str += word
        elif word != "`":
            str += word

        if len(str) > 0:
            if str[:2] == "/*":
                if str[-2:] == "*/":
                    found = not found
                    continue
                else:
                    continue
            if str[:2] == "//":
                found = not found
                break

            if len(str) >= 2 and str[0] in ("'",'"') and str[0] == str[-1]: 
                final_table.add_row([line_index+1,str[0],"Delimiter",["DL",string_delimiter[str[0]]]])
                # index = find_index(str[1:-1])
                final_table.add_row([line_index+1,str[1:-1],"String Constant",["C",str[1:-1]]])
                final_table.add_row([line_index+1,str[-1],"Delimiter",["DL",string_delimiter[str[-1]]]])
                found = not found
                continue
            
            if str.isnumeric() and not line[word_index + 1].isnumeric() :
                if(line[word_index+1] in operator or line[word_index+1] in delimiter):
                    final_table.add_row([line_index+1,str,"Number",["C",str]])
                    found = not found
                    continue
            
            elif str in keyword:
                final_table.add_row([line_index+1,str,"Keyword",["KW",keyword.index(str)+1]])
                found = not found
                continue
            
            elif str in delimiter:
                final_table.add_row([line_index+1,str,"Delimiter",["DL",delimiter.index(str[0])+1]])
                found = not found
                continue
            
            elif str in operator:
                try:
                    if line[word_index+1] in operator:
                        continue
                    else:
                        final_table.add_row([line_index+1,str,"Operator",["OP",operator.index(str)+1]])
                        found = not found
                        continue
                except:
                    pass
            
            try:
                if line[word_index+1] in operator or line[word_index+1] in delimiter or line[word_index+1] == "`":
                    if str[len(str)-1] in ("'",'"'):
                        error_table.add_row([line_index+1,str,"Unterminated String"])
                        # index = find_index(str[:-1])
                        final_table.add_row([line_index+1,str[:-1],"String Constant",["C",str[:-1]]])
                        final_table.add_row([line_index+1,str[-1],"Delimiter",["DL",string_delimiter[str[-1]]]])
                        found = not found
                        continue 
                    if str[0] not in ("'",'"'):
                        if( str[0].isnumeric()):
                            error_table.add_row([line_index+1,str,"Invalid Identifier name"])
                        elif(len(str) > 20):
                            error_table.add_row([line_index+1,str,"Identifier character limit exceeded"]) 
                    
                        index = find_index(str)
                        final_table.add_row([line_index+1,str,"Identifier",["ID",index]])
                        found = not found
                        continue   
            except:
                pass
    if not found:
        if str[0] in ("'",'"'):
            error_table.add_row([line_index+1,str,"Unterminated String"])
            final_table.add_row([line_index+1,str[0],"Delimiter",["DL",string_delimiter[str[0]]]])
            # index = find_index(str[1:])
            final_table.add_row([line_index+1,str[1:],"String Constant",["C",str[1:]]])
            found = not found
        if str[:2] == "/*":
            error_table.add_row([line_index+1,str,"Unterminated Comment"])


print("\n\n")
print("\033[32mAnish Vaidya Roll-62\033[0m")
print("\033[32mCompiler Design Assignment-1\033[0m")
print("\033[33mDesign a Lexical analyzer for the subset of Java Language.\033[0m")
print("\nToken Table")
print(final_table)
print("\n")

for entry_index,entry in enumerate(st):
    symbol_table.add_row([entry_index+1,entry])
print("Symbol Table")
print(symbol_table)
print("\n")

print("Errors")
print(error_table)