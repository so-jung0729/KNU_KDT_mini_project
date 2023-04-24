"""
# URL : http://localhost:8686cgi-bin/web.py
"""
# 모듈 로딩 ---------------------------------------------------
import cgi, sys, codecs, os
import joblib

# WEB 인코딩 설정 ---------------------------------------------
sys.stdout=codecs.getwriter('utf-8')(sys.stdout.detach())

# 함수 선언 --------------------------------------------------
# WEB 페이지 출력 --------------------------------------------
def displayWEB(grade, items):
    print("Content-Type: text/html; charset=utf-8")
    print("")
    html="""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>식료품점 분석</title>
    </head>
    <body align="center">
        <h2>식료품점 고객 분석</h2>
    <form>
        <div style = 'width: 100%; height: 600px;'>
            <div class = 'left', style = 'width: 50%; float: left; box-sizing: border-box; background: #f8f8eb;'>
                <h3>🏪고객 등급 분류</h3>
                <input id="Recency" type="text" placeholder="마지막 방문" name="Recency"> </br>
                <input id="Visit" type="text" placeholder="방문 횟수" name="Visit"></br>
                <input id="Monetary" type="text" placeholder="구매 건수" name="Monetary"></br></br>
                <input type="submit" value="등급 예측"></br></br>
                <p><font color='blue'>{}</font></p>
            </div>
            <div class="right" , style = 'width: 50%; float: right; box-sizing: border-box; background: #edfcfc;'>
                <h3>🛒고객 등급 분류</h3>
                <select name="item">
                    <option value='' selected>-- 선택 --</option>
                    <option value='rolls/buns'>rolls/buns</option>
                    <option value='soda'>soda</option>
                    <option value='yogurt'>yogurt</option>
                    <option value='root vegetables'>root vegetables</option>
                    <option value='tropical fruit'>tropical fruit</option>
                    <option value='citrus fruit''>citrus fruit'</option>
                    <option value='whole milk'>whole milk</option>
                    <option value='sausage'>sausage</option>
                    <option value='bottled water'>bottled water</option>
                    <option value='othervegetables'>other vegetables</option>
                </select>
                <input type="submit" value="연관 상품"></br></br>
                <p><font color='blue'>{}</font></p>
            </div>
        </div>
        
    </form></body></html>""".format(grade, items)
    print(html)


# 판정 --------------------------------------------------------

# 고객분류 =======================================================
# 기능 구현 -----------------------------------------------------
# (1) 학습 데이터 읽기

os.path.dirname(__file__)
pklfile = os.path.dirname(__file__) + "\\not_customerClass.pkl"
lr = joblib.load(pklfile)

# # (2) WEB 페이지 <Form> -> <INPUT> 리스트 가져오기
form = cgi.FieldStorage()
Recency_value = form.getvalue('Recency')
Visit_value = form.getvalue('Visit')
Monetary_value = form.getvalue('Monetary')


# (3) 판정 하기
if Recency_value is not None and Visit_value is not None and Monetary_value is not None:
    # custrom_class = lr.predict([[Recency_value, Visit_value, Monetary_value]])
    result = 'custrom_class'

    # if custrom_class == 0: grade = '이탈 가능 고객'
    # elif custrom_class == 1: grade = '일반 고객'
    # elif custrom_class == 2: grade = '우수 고객'
    # result = f"{grade}입니다."
else: 
    result = '분류할 수 없습니다.'

## 연관상품 =======================================================
# 기능 구현 -----------------------------------------------------

    

# (1) 학습 데이터 읽기

# pklfile2 = os.path.dirname(__file__) + "\\rules.pkl"
# rules = joblib.load(pklfile2)

import pandas as pd
rules = pd.read_csv('C:\\Users\\user\\PROGRAMMING\\KNU_STUDY\\EXAM_ML\\04 Mini_Procet\\cgi-bin\\rules2.csv')



# # (2) WEB 페이지 <Form> -> <INPUT> 리스트 가져오기
# form2 = cgi.FieldStorage()
item_value = form.getvalue('item')

# (3) 판정 하기
def Search(item1):
    global rules
    for i in set(rules.antecedents):
        if list(i) == [item1]:
            dfdf = rules[rules.antecedents == i].sort_values('confidence')
            if len(dfdf) > 5:
                return [list(dfdf.iloc[j, 1]) for j in range(5)]
            elif len(dfdf) > 0:
                for n in range(len(dfdf)):
                    return [list(dfdf.iloc[_, 1]) for _ in range(len(dfdf))]
    else:
        return '연관된 상품이 없습니다.'

### 데이터 입력관련     

if item_value is not None:
    as_item = Search(item_value)
else: 
    as_item = '연관된 상품을 찾을 수 없습니다.'

# (4) WEB 출력하기
displayWEB(result, as_item)




