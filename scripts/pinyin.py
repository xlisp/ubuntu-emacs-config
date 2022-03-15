from xpinyin import Pinyin
import sys
test = Pinyin()
result = test.get_pinyin(sys.argv[1])
print (result)
