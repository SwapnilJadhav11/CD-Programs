delimiter = {"{","}","(",")",",",";",}
operator = {"-","+","*","/","%","=","++","--","<",">","==",">=","<=","&"}
keyword = {"int","if","char","break","continue","double","else","float","for","void"}
invalid = {"@","$"}
space_free_prog = []

with open("prog.txt","r") as program:
    prog = program.read().split("\n")

def remove_space(lista):
    listb = []
    for ele in lista:
        if ele != " ":
            listb.append(ele)
    return listb

for p in prog:
    p=list(p)
    p=remove_space(p)
    space_free_prog.append(p)

found = False
final_table = []
error = []

for line_index,line in enumerate(space_free_prog):
    str=""
    for word_index,word in enumerate(line):
        if found:
            str=""
            found = not found
        str += word
        if word in invalid and str[0] not in ("'",'"'):
            error.append([line_index+1,str,"Invalid Character"])
        if str.isnumeric() and not line[word_index + 1].isnumeric() :
            if(line[word_index+1] in operator or line[word_index+1] in delimiter):
                final_table.append([line_index+1,str,"Number"])
                found = not found
                continue
        if str in keyword:
            final_table.append([line_index+1,str,"Keyword"])
            found = not found
            continue
        if str in delimiter:
            final_table.append([line_index+1,str,"Delimiter"])
            found = not found
            continue
        if str in operator:
            try:
                if line[word_index+1] in operator:
                    continue
                else:
                    final_table.append([line_index+1,str,"Operator"])
                    found = not found
                    continue
            except:
                pass
        try:
            if line[word_index+1] in operator or line[word_index+1] in delimiter:
                if( str[0] in ("'",'"') and str[len(str)-1] in ("'",'"') ):
                    final_table.append([line_index+1,str[0],"Delimiter"])
                    final_table.append([line_index+1,str[1:-1],"String Constant"])
                    final_table.append([line_index+1,str[-1],"Delimiter"])
                else:
                    if str[0] in ("'",'"'):
                        final_table.append([line_index+1,str[0],"Delimiter"])
                        final_table.append([line_index+1,str[1:],"String Constant"])
                        error.append([line_index+1,str,"Unterminated String"])
                    if str[len(str)-1] in ("'",'"'):
                        error.append([line_index+1,str,"Unterminated String"])
                        final_table.append([line_index+1,str[:-1],"String Constant"])
                        final_table.append([line_index+1,str[-1],"Delimiter"])
                    if( str[0].isnumeric()):
                        error.append([line_index+1,str,"Invalid Identifier name"])
                        final_table.append([line_index+1,str,"Identifier"])
                    if(len(str) > 20):
                        error.append([line_index+1,str,"Identifier character limit exceeded"])
                        final_table.append([line_index+1,str,"Identifier"])
                found = not found
                continue   
        except:
            pass

print("Line\tLexeme\tToken")
for entry in final_table:
    for item in entry:
        print(item,end="\t")
    print("")
print("\n\n")
print("Line\tLexeme\tError")
for entry in error:
    for item in entry:
        print(item,end="\t")
    print("")
print("\n\n")