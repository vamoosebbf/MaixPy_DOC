maix asr
=======

> **本文档在 MaixPy 0.5.1_128 minimum_speech_with_ide_support 固件测试通过，使用前请确保录音功能/调用模型可用。**

这是一个基于声学模型的语音识别模块，用户设置拼音组成的词汇加载到模块中，就可以开始录音识别用户输入的词汇，并返回可能匹配的词汇列表。

## 使用方法

**警告** 不会【使用录音】和【调用模型】的同学，请先去学习前置技能再来使用本篇文档。

- 烧录声学模型

> TODO 之后存放到下载站统一链接。

从这里获取声学模型[maix_asr_2900k_0x500000](https://github.com/sipeed/MaixPy_scripts/blob/master/multimedia/speech_recognizer/maix_asr_2900k_0x500000.kmodel), 烧录到 0x500000 地址即可。

> 没有烧模型就加载模块会 core dump ，不要跑来问怎么报错了。

- 创建录音设备

本模块支持所有 Maix 系列硬件使用，我们只需要配置一个 I2S.DEVICE_0 设备，并设置 CHANNEL_0 通道到录音输入就可以了，如果是 Cube 和 amigo 则需要先配置具体的音频解码芯片，再打开 I2C 录音设备。

```python
from Maix import GPIO, I2S
from fpioa_manager import fm

fm.register(20,fm.fpioa.I2S0_IN_D0, force=True)
fm.register(18,fm.fpioa.I2S0_SCLK, force=True) # dock 32
fm.register(19,fm.fpioa.I2S0_WS, force=True)   # dock 30

rx = I2S(I2S.DEVICE_0)
rx.channel_config(rx.CHANNEL_0, rx.RECEIVER, align_mode=I2S.STANDARD_MODE)
rx.set_sample_rate(16000)
print(rx)
```

- 运行示例代码

请将代码拉到底，这里创建了一个 maix_asr 的辅助类，可以跳过不看。

```python

from speech_recognizer import asr

class maix_asr(asr):

  asr_vocab = ["lv", "shi", "yang", "chun", "yan", "jing", "da", "kuai", "wen", "zhang", "de", "di", "se", "si", "yue", "lin", "luan", "geng", "xian", "huo", "xiu", "mei", "yi", "ang", "ran", "ta", "jin", "ping", "yao", "bu", "li", "liang", "zai", "yong", "dao", "shang", "xia", "fan", "teng", "dong", "she", "xing", "zhuang", "ru", "hai", "tun", "zhi", "tou", "you", "ling", "pao", "hao", "le", "zha", "zen", "me", "zheng", "cai", "ya", "shu", "tuo", "qu", "fu", "guang", "bang", "zi", "chong", "shui", "cuan", "ke", "shei", "wan", "hou", "zhao", "jian", "zuo", "cu", "hei", "yu", "ce", "ming", "dui", "cheng", "men", "wo", "bei", "dai", "zhe", "hu", "jiao", "pang", "ji", "lao", "nong", "kang", "yuan", "chao", "hui", "xiang", "bing", "qi", "chang", "nian", "jia", "tu", "bi", "pin", "xi", "zou", "chu", "cun", "wang", "na", "ge", "an", "ning", "tian", "xiao", "zhong", "shen", "nan", "er", "ri", "zhu", "xin", "wai", "luo", "gang", "qing", "xun", "te", "cong", "gan", "lai", "he", "dan", "wei", "die", "kai", "ci", "gu", "neng", "ba", "bao", "xue", "shuai", "dou", "cao", "mao", "bo", "zhou", "lie", "qie", "ju", "chuan", "guo", "lan", "ni", "tang", "ban", "su", "quan", "huan", "ying", "a", "min", "meng", "wu", "tai", "hua", "xie", "pai", "huang", "gua", "jiang", "pian", "ma", "jie", "wa", "san", "ka", "zong", "nv", "gao", "ye", "biao", "bie", "zui", "ren", "jun", "duo", "ze", "tan", "mu", "gui", "qiu", "bai", "sang", "jiu", "yin", "huai", "rang", "zan", "shuo", "sha", "ben", "yun", "la", "cuo", "hang", "ha", "tuan", "gong", "shan", "ai", "kou", "zhen", "qiong", "ding", "dang", "que", "weng", "qian", "feng", "jue", "zhuan", "ceng", "zu", "bian", "nei", "sheng", "chan", "zao", "fang", "qin", "e", "lian", "fa", "lu", "sun", "xu", "deng", "guan", "shou", "mo", "zhan", "po", "pi", "gun", "shuang", "qiang", "kao", "hong", "kan", "dian", "kong", "pei", "tong", "ting", "zang", "kuang", "reng", "ti", "pan", "heng", "chi", "lun", "kun", "han", "lei", "zuan", "man", "sen", "duan", "leng", "sui", "gai", "ga", "fou", "kuo", "ou", "suo", "sou", "nu", "du", "mian", "chou", "hen", "kua", "shao", "rou", "xuan", "can", "sai", "dun", "niao", "chui", "chen", "hun", "peng", "fen", "cang", "gen", "shua", "chuo", "shun", "cha", "gou", "mai", "liu", "diao", "tao", "niu", "mi", "chai", "long", "guai", "xiong", "mou", "rong", "ku", "song", "che", "sao", "piao", "pu", "tui", "lang", "chuang", "keng", "liao", "miao", "zhui", "nai", "lou", "bin", "juan", "zhua", "run", "zeng", "ao", "re", "pa", "qun", "lia", "cou", "tie", "zhai", "kuan", "kui", "cui", "mie", "fei", "tiao", "nuo", "gei", "ca", "zhun", "nie", "mang", "zhuo", "pen", "zun", "niang", "suan", "nao", "ruan", "qiao", "fo", "rui", "rao", "ruo", "zei", "en", "za", "diu", "nve", "sa", "nin", "shai", "nen", "ken", "chuai", "shuan", "beng", "ne", "lve", "qia", "jiong", "pie", "seng", "nuan", "nang", "miu", "pou", "cen", "dia", "o", "zhuai", "yo", "dei", "n", "ei", "nou", "bia", "eng", "den", "_"]

  def get_asr_list(string='xiao-ai-fas-tong-xue'):
    return [__class__.asr_vocab.index(t) for t in string.split('-') if t in __class__.asr_vocab]

  def get_asr_string(listobj=[117, 214, 257, 144]):
    return '-'.join([__class__.asr_vocab[t] for t in listobj if t < len(__class__.asr_vocab)])

  def unit_test():
    print(__class__.get_asr_list('xiao-ai'))
    print(__class__.get_asr_string(__class__.get_asr_list('xiao-ai-fas-tong-xue')))

  def config(self, sets):
    self.set([(sets[key], __class__.get_asr_list(key)) for key in sets])

  def recognize(self):
    res = self.result()
    # print(tmp)
    if res != None:
      sets = {}
      for tmp in res:
        sets[__class__.get_asr_string(tmp[1])] = tmp[0]
        #print(tmp[0], get_asr_string(tmp[1]))
      return sets
    return None

from machine import Timer

def on_timer(timer):
  #print("time up:",timer)
  #print("param:",timer.callback_arg())
  timer.callback_arg().state()

try:
  # default: maix dock / maix duino set shift=0
  t = maix_asr(0x500000, I2S.DEVICE_0, 3, shift=0) # maix bit set shift=1
  tim = Timer(Timer.TIMER0, Timer.CHANNEL0, mode=Timer.MODE_PERIODIC, period=64, callback=on_timer, arg=t)
  tim.start()

  #for i in range(50):
    #time.sleep_ms(100)
  #t.stop()
  #for i in range(50):
    #time.sleep_ms(100)
  #t.run()

  t.config({
    'xiao-ai-ya' : 0.3,
    'hao-de-ya' : 0.2,
    'ni-hao-ya' : 0.3,
  })

  print(t.get())

  while True:
    #time.sleep(1)
    tmp = t.recognize()
    # print(tmp)
    if tmp != None:
      print(tmp)
except Exception as e:
  print(e)
finally:
  tim.stop()
  t.__del__()
  del t
```

- 对麦克风说话

我们可以看到代码中定义了以下词汇：

```python
  t.config({
    'xiao-ai-ya' : 0.3,
    'hao-de-ya' : 0.2,
    'ni-hao-ya' : 0.3,
  })

  print(t.get())
```

也就是你对着麦克风在 6 秒内，说【你-好-鸭】、【好-的-鸭】、【小-爱-鸭】就可以完成识别了，配置项为两个字段，第一个字段长度不超过六组拼音，第二个字段表示识别的最低门限，也就是匹配值的阈值，低于该值就丢弃。

最开始测试的时候，说话可以大声一点，具体效果看[演示视频](https://www.bilibili.com/video/BV1C5411L7JC/)。

## 模块接口

### class maix_asr

该模块由继承 asr 模块而来的辅助类，实现已经在【示例代码】提供，成员函数如下：

```shell
>>> maix_asr.
__class__       __module__      __name__        __qualname__
get             set             stop            __del__
config          recognize       result          run
state           asr_vocab       get_asr_list    get_asr_string
unit_test
```

#### function config()

可以配置语音识别的所需要的词汇列表，最大不超过 6 个音符，超了会忽略，参数为 `'xiao-ai-ya' : 0.3` 对应的 中文拼音字符串 和 匹配的最低概率（门限），且注意它不区分音调，所以 `你-好-鸭` 和 `尼-浩-雅` 没有区别，所以设计的时候要注意词汇的语调是否会形成新词。

```python
  t.config({
    'xiao-ai-ya' : 0.3,
    'hao-de-ya' : 0.2,
    'ni-hao-ya' : 0.3,
  })
```

#### function recognize()

将会识别 config 函数中所配置的词汇。

用例如下：

```python
tmp = t.recognize()
# print(tmp)
if tmp != None:
    print(tmp)
```

返回结果：

```python
{
    'xiao-ai-ya' : 0.9,
    'xiao-ai' : 0.2,
}
```

跟 config 时的参数一样，只是作为返回值给出，可以见到此处出现 `小-爱-鸭` 和 `小-爱` 两个匹配结果。

#### function state()

期望保持在 100ms 内能够执行 asr 模块，它会返回当前模块状态，可以忽略返回结果，用法如下：

```python
from machine import Timer

def on_timer(timer):
  #print("time up:",timer)
  #print("param:",timer.callback_arg())
  timer.callback_arg().state()

# default: maix dock / maix duino set shift=0
t = maix_asr(0x500000, I2S.DEVICE_0, 3, shift=0) # maix bit set shift=1
tim = Timer(Timer.TIMER0, Timer.CHANNEL0, mode=Timer.MODE_PERIODIC, period=64, callback=on_timer, arg=t)
tim.start()
```

可见 on_timer 会在 64 ms 的周期内执行 timer.callback_arg().state() 函数，其中 timer.callback_arg() 为 maix_asr 类的实例。

#### function run()

控制模块运行（录音）。

#### function stop()

控制模块停止（录音）。

#### function __del__()

主动调用可释放模块，可被 gc.collect() 主动回收。
