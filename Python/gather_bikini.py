# http://d.hatena.ne.jp/heavenshell/20121214/1355499643
import re
import requests
c = requests.get('http://matome.naver.jp/odai/2135350364969742801').content
print(''.join([x.group(0) for x in re.finditer(r'<img src=".+".*?class="MTMItemThumb".*?/>', c)]))
