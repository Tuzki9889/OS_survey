import requests
from bs4 import BeautifulSoup

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36'
}
response = requests.get('https://www.dxsbb.com/news/123257.html', headers=headers)
response.encoding='gb2312'
html=response.text

f=open('test2.txt','w')
soup = BeautifulSoup(html,'lxml')
num=0
for tbody in soup.select('tbody'):
    for tr in tbody.select('tr'):
        count=0
        for td in tr.select('td'):
            if count==1:
                f.write(td.text)
                f.write('\n')
                num+=1
            count+=1
print(num)
f.close()

    
