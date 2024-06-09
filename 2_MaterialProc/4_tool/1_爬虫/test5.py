f4=open('test4.txt','r')
f3=open('test3.txt','r')
f5=open('result.txt','w')
lines4=f4.readlines()
lines3=f3.readlines()
m={}
for i in lines3:
    a,b=i.replace('\n','').split(',')
    m[a]=b
#print(m)


#lines4=lines4[:3]
for i in lines4:
    a,b,c=i.replace('\n','').split(',')
    email=''
    for j in range(int(len(c)/5)):
        w1=c[j*5+3]
        w2=c[j*5+4]
        w3=w2
        if w2.isalpha():
            w3=ord(w2)-ord('A')+10
        
        email+=chr(int(w1)*16+int(w3))
    
    #print(m[a],b,email)
    f5.write(m[a])
    f5.write(',')
    f5.write(b)
    f5.write(',')
    f5.write(email)
    f5.write('\n')
f5.close()
f3.close()
f4.close()
