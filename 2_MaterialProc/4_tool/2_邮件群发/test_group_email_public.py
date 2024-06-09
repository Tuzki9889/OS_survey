# -*- coding: utf-8 -*-
"""
Created on Mon Jul 17 04:51:24 2023

@author: jiachen liu
"""


import smtplib
from email.mime.text import MIMEText #发邮件正文需要此模块
from email.utils import formataddr     # 发送邮件时需要附加名称，如**公司

def mail(mail_address,mail_contect,mail_subject,mail_cc,authorization_code):
    #共四个部分：导入相关库；设置；邮件内容；登录发送


    #设置发送人/接收人/密码
    from_addr='222312030@njnu.edu.cn'
    to_addrs=(mail_address+','+mail_cc).split(',')
    password=authorization_code #不是邮箱密码，是邮箱授权码，如qq邮箱，设置→账户→开启POP3/SMTP服务后有个授权码

    #邮件内容
    message=MIMEText(mail_contect,_subtype='plain', _charset='utf_8') # plain设置文本格式，utf-8设置编码
    message['subject']=mail_subject
    #message['from']=from_addr
    message['from']=formataddr(['开放科学中文社区（COSN）•开放科学调查小组',from_addr])
    message['to']=mail_address
    message['Cc']=mail_cc

    #登录发送
    try:
        server=smtplib.SMTP_SSL('smtp.qq.com', 465) #连接服务器
        server.login(from_addr, password) #登录
        server.sendmail(from_addr,to_addrs,message.as_string()) #发送
        print(mail_address+' success')
        server.quit()
    except smtplib.SMTPException as e: # 如果 try 中的语句没有执行，则会执行下面的
        print('error',e) #如果发送失败，会返回错误代码，进而找到原因
    
    
    
import pandas as pd

df=pd.read_excel('test_group_email.xlsx',sheet_name='重测被试') 
#df_to=df['收件人'].values.tolist()  #将表格变成列表形式，收件人一列，文本（数字码）一列
#df_content=df['文本'].values.tolist() #文本是每一个被试独有的被试编号




mail_subject = '作为国内一流的研究者，您对开放科学了解多少？'
mail_cc = 'spring9889@163.com'#siqi.duan@estudiante.uam.es
authorization_code = 'tiger15995' #replace with your own code

for index, row in df.iterrows():
    mail_address, subj_number = row
    #邮件内容
    mail_contect = f"""
    尊敬的老师，
    您好！

我们是开放科学中文社区COSN的开放科学调查小组。我们——开放科学中文社区——是一个在线的社区，由于心理学/脑科学的研究者发起，主要推广开放科学的理念，以增强科学研究中的透明度、可重复性和开放性。我们的微信公众号是：OpenScience.
我们冒昧地发出这封邮件，是希望诚邀您参与一项关于开放科学态度与实践的问卷调查。这项调查旨在了解中国研究者，包括海外从事研究且能理解中文的研究者对开放科学的看法和实践经验。我们尤其希望知道大家对开放科学实践有什么疑虑，或者是觉得实践开放科学有什么困难。这将帮助我们和其他同样对开放科学理念感兴趣的同行一起解决这些困难，共建开放和透明的学术共同体。
	欢迎您通过扫描邮件下方的二维码或点击以下链接来填写问卷：https://shenzhenshss.au1.qualtrics.com/jfe/form/SV_5hFHI5NWcTB1hb0
您的参与不仅能帮助我们更好地理解和推动开放科学的实践，还将直接转化为对公益项目的支持。对每份有效的问卷数据，我们将向腾讯公益“为困境抑郁女孩推窗”项目捐款0.5元，帮助家境经济困难的抑郁症休学生和家长。
填写问卷预计需花费10分钟左右，我们将对所有数据进行匿名处理，确保您的隐私安全。
非常感谢您宝贵的时间和支持。您的每一份反馈，都对我们的研究和所支持的公益项目至关重要。
如有任何疑问，欢迎随时通过以下邮箱联系我们：
•	opensci@outlook.com
•	hu.chuan-peng@nnu.edu.cn
期待您的参与，让我们共同为推动开放科学和支持公益事业做出贡献！

祝好，
开放科学中文社区（COSN）

    """
    mail(mail_address,mail_contect,mail_subject,mail_cc,authorization_code)
    
    
    
    
    