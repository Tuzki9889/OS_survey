f=open('test.txt','r')
f2=open('test2.txt','r')
f3=open('test3.txt','w')
lines = f.readlines()
lines2=f2.readlines()

for i in range(len(lines)):
    lines[i]=lines[i].replace('\n','')
for i in range(len(lines2)):
    lines2[i]=lines2[i].replace('\n','')

lines3=[]
count=0
for i in lines:
    if i.split(',')[1] in lines2:
        f3.write(i)
        f3.write('\n')
        count+=1
print(count)


f.close()
f2.close()
f3.close()
