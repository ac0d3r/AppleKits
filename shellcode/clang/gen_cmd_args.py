a = [
    '/bin/zsh',
    '-c',
    'open /System/Applications/Calculator.app',
]
j = 0
for s in a:
    i = 0
    for c in s:
        print("arg%d[%d]='%s';"%(j,i, c))
        i+=1
    print("arg%d[%d]=0;\n\n"%(j,i))
    j+=1