import requests# 导入requests库，用于发送网络请求
from bs4 import BeautifulSoup# 导入BeautifulSoup库，用于解析HTML文档

# 设置请求头，模拟浏览器访问，防止被网站阻止
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36'
}

def get(page,f):
    # 发送GET请求，访问网站的某一页，并传递自定义的headers
    response = requests.get('https://pi-review.com/universities/?page='+str(page)+'&region=CN', headers=headers)
    html=response.text# 获得了网页源代码信息
    # 使用BeautifulSoup解析HTML内容，使用'lxml'作为解析器
    soup = BeautifulSoup(html,'lxml')# 其实就是整理一下让机器理解这是一个网页

    print(response)
    for h2 in soup.select("h2"):# 定位到学校代码
        h2=str(h2)
        h2=h2.split('\n')
        n=h2[1].split('/')[-1][:-2]
        name=h2[2].split(' ')[-1]
        f.write(n)
        f.write(',')
        f.write(name)
        f.write('\n')
def main():
    f=open('test.txt','w')
    for i in range(1,63):
        get(i,f)
    f.close()
main()
    
