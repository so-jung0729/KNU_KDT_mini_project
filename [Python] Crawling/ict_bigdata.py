from bs4 import BeautifulSoup
from selenium import webdriver
import time
import pandas as pd
import csv

options = webdriver.ChromeOptions()
options.add_experimental_option('excludeSwitches', ['enable-logging'])
driver = webdriver.Chrome(options=options)

driver.get('https://www.ictintern.or.kr/homepage/trainingCompany/companyList.do')
driver.implicitly_wait(2)

driver.find_element_by_xpath('//*[@id="WORK_CD_16"]').click()
driver.implicitly_wait(2)

driver.execute_script('btnSearch()')
time.sleep(1)

data_list, com, work, stack = [], [], [], []

for _ in range(2):
    html = driver.page_source
    bs = BeautifulSoup(html, 'html.parser')

    href_c = bs.select('.left a')
    
    for i in href_c:
        try:
            script_url = i['href'].split(':')[1]
            print('script_url: ', script_url)
            driver.execute_script(script_url)
            time.sleep(2)

            html = driver.page_source
            bs = BeautifulSoup(html, 'html.parser')

            ht = bs.find_all('tbody')[4]
            com.append(ht.find_all('tr')[7].text)

            std_wokr = bs.find_all('tbody')[13]
            std_wokr_tr = std_wokr.find_all('tr')

            # 실습생 
            for work_j in std_wokr_tr[0].select('td div div div.item'):
                work.append(work_j.text)

            # 실습생
            for stack_j in std_wokr_tr[1].select('td div div div.item'):
                stack.append(stack_j.text)

            driver.find_element_by_xpath('//*[@id="contents_area"]/div/div[3]/a').click()
            time.sleep(1) 

        except:
            print(i['href'])
            continue
    driver.find_element_by_xpath(f'//*[@id="pagingNavi"]/div[2]/a[2]').click()
    time.sleep(1)
    print('-'*30)
driver.quit()

with open('com.txt', mode = 'w', encoding = 'utf-8') as f:
    f.write(com)

with open('work.csv', mode = 'w', encoding = 'utf-8') as f:
    for i in work:
        f.write(i)

with open('stack.csv', mode = 'w', encoding = 'utf-8') as f:
    for i in work:
        f.write(i)

# bigData_table = pd.DataFrame({'info': com, 'work' : work, 'stack':stack})
# print(bigData_table.head(5))
# bigData_table.to_csv('bigData1.csv', encoding = 'utf-8', mode = 'w', index = True)

# # print(com)
# # print('work: ', work)
# # print(len(work))
# # print(stack)
