from bs4 import BeautifulSoup
from urllib.request import urlopen
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import requests
from konlpy.tag import Okt
from collections import Counter
from wordcloud import WordCloud
import matplotlib.pyplot as plt
import time
import re
import platform

driver = webdriver.Chrome('chromedriver.exe')
path = 'https://www.wanted.co.kr'

driver.get('https://id.wanted.jobs/login')
# driver.get('https://www.wanted.co.kr/search?query=%EB%A8%B8%EC%8B%A0%EB%9F%AC%EB%8B%9D')
driver.implicitly_wait(3)

driver.find_element_by_name('email').send_keys('sojnlee2001@naver.com')
driver.find_element_by_xpath('//*[@id="__next"]/div/div/div/div/form/button').click()
driver.implicitly_wait(3)
driver.find_element_by_name('password').send_keys('thwjd3102.')
driver.find_element_by_xpath('//*[@id="__next"]/div/div/div/div[2]/form/button[1]').click()
driver.find_element_by_xpath('//*[@id="__next"]/div/div[2]/section[4]/div/a[1]').click()
driver.find_element_by_xpath('//*[@id="__next"]/div[1]/div/nav/aside/ul/li[1]/button').click()
# # 스크롤 높이 가져옴
# last_height = driver.execute_script("return document.body.scrollHeight")
# while True:
#     # 끝까지 스크롤 다운
#     driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
#     # 1초 대기
#     time.sleep(1)
#     # 스크롤 다운 후 스크롤 높이 다시 가져옴
#     new_height = driver.execute_script("return document.body.scrollHeight")
#     if new_height == last_height: break
#     last_height = new_height

# url = driver.page_source
# driver.quit()

# soup = BeautifulSoup(url, 'html.parser')
# for html in soup.select('div.List_List_container__JnQMS li a'):
#     print(html['href'])
#     ml_wanted_url = path + html['href']
#     print(ml_wanted_url)
#     ml_wanted_url = urlopen(ml_wanted_url)
#     bs = BeautifulSoup(ml_wanted_url, 'html.parser')
#     for i in bs.select('.JobDescription_JobDescription__VWfcb'):
#         print(i.text)

# print(len(soup.select('div.List_List_container__JnQMS li a')))
