import requests
from bs4 import BeautifulSoup


headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36'
}

def get(n,f,page):
    print(n,page)
    response = requests.get('https://pi-review.com/universities/'+str(n)+'?page='+str(page), headers=headers)
    html=response.text
    soup = BeautifulSoup(html,'lxml')
    ls=soup.find_all(class_='d-flex flex-column p-md-3 p-3 justify-content-center col-12 col-sm-6')
    if ls==[]:
        return False
    for item in soup.find_all(class_='d-flex flex-column p-md-3 p-3 justify-content-center col-12 col-sm-6'):
        for div in item.select('div'):
            for span in div.select('span'):
                for a in span.select('a'):
                    t=a.text
                    #t=t.split('(')[1].split(')')[0]
                    f.write(n)
                    f.write(',')
                    f.write(t)
                    f.write(',')
        for ul in item.select('ul'):
            for li in ul.select('li'):
                for style in li.select('style'):
                        t=style.text
                        t=t.split('\'')[-2]
                        f.write(t)
                        f.write('\n')
    return True

def main():
    f=open('test4.txt','w')
    f3=open('test3.txt','r')
    lines3 = f3.readlines()
    for i in range(len(lines3)):
        lines3[i]=lines3[i].replace('\n','').split(',')[0]
    for i in lines3:
        j=1
        while get(i,f,j)==True:
            j+=1
    f3.close()
    f.close()
main()
