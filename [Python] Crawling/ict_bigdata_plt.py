#%%
from wordcloud import WordCloud
from konlpy.tag import Okt
from collections import Counter


import matplotlib.pyplot as plt
import platform
import re
#%%

#%%
with open('work.csv', 'r', encoding= 'utf-8') as f:
    a = f.read()
work = a.split(',')[:-1]

with open('stack.csv', 'r', encoding= 'utf-8') as f:
    b = f.read()

stack = b.split(',')[:-1]

with open('com_info.txt', 'r', encoding= 'utf-8') as f:
    info = f.read()

info = info.replace('\t','')
info = info.replace('\n','')
info = info.replace('사업분야','')
info = info.replace('Ÿ', '')
info = info.replace('', '')
info = info.replace('  ', ' ')
print(info)
#%%
okt = Okt()
def remove_stopword(text):
    tokens = okt.pos(text)
    print(tokens)
    token_list = []
    for word, tag in tokens:
        if tag in ['Noun', 'Adjective', 'Alpha']:
            token_list.append(word)
    stopwords = ['및', '서비스', '위', '데이터', '플랫폼', '개발', '계', '등', '분석', '기반', '사업', '기여', '공간', '비대', '통합', '통해', '관련', '체제', 'O', 'B', '분야', '제공', '기술', '국가', '헬', '스케', '장비', '영역', '소재']
    token_list = [t for t in token_list if t not in stopwords]
    print(token_list)
    return token_list
info_noun = remove_stopword(info)
remove_stopword(info)
# %%
# WordCloud를 생성
# 한글을 분석하기 위해 font를 한글로 지정해주어야 된다. 
# macOS는 .otf, window는 .tff 파일 위치 지정
if	platform.system() == 'Windows':
    path = r'c:\Windows\Fonts\malgun.ttf'
elif platform.system() == 'Darwin':	 # Mac OS 
    path = r'/System/Library/Fonts/AppleGothic'
else:
    path = r'/usr/share/fonts/truetype/name/NanumMyeongjo.ttf'

#%%
# work
def make_wordcloud(text):
    wc = WordCloud(font_path = path, background_color = 'white', max_font_size = 100, width=600, height=400)

    counts = Counter(text)
    counts = counts.most_common(50)
    print(counts)

    cloud = wc.generate_from_frequencies(dict(counts))

    plt.figure(figsize = (10, 8))
    plt.axis('off')
    plt.imshow(cloud)
    plt.show()

make_wordcloud(info_noun)
make_wordcloud(work)
make_wordcloud(stack)

# %%
