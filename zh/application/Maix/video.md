video 视频
=====


支持播放和录制 `avi` 视频

## 全局函数

### open(path, record=False, interval=100000, quality=50, width=320, height=240, audio=False, sample_rate=44100, channels=1)

打开一个文件来播放或者录制

#### 参数

* `path`： 文件路径， 比如 `/sd/badapple.avi`
* `record`： 是否进行录制， 如果选择 `Ture`， 则会进行录制视频，否则是播放视频。 默认 `False`
* `interval`： 录制的帧间隔， 单位是微秒， fps = 1000000/interval， 默认 `100000`， 即每秒`10`帧
* `quality`： `jpeg` 压缩质量（`%`）， 默认`50`
* `width`： 录制屏幕宽度， 默认 `320`
* `height`： 录制屏幕高度， 默认 `240`
* `audio`： 是否录制音频， 默认 `False`
* `sample_rate`： 录制音频采样率， 默认 `44100` (`44.1k`)
* `channels`： 录制音频声道数， 默认 `1`， 即单声道

#### 返回值

返回一个对象， 根据不同格式返回的对象不同。

目前只支持 `avi` 格式， 返回 由 `avi` 类创建的对象

## 类 `avi`

由 `video.open()` 函数返回

### play()

播放视频， 每调用一次解析一次数据（音频或者视频）

#### 返回值

* `0`： 播放结束
* `1`： 正在播放
* `2`： 暂停（保留）
* `3`： 当前解码的帧是视频帧
* `4`： 当前解码的帧是音频帧


### volume(volume)

设置音量

#### 参数

* `volume`： 音量值， 取值范围：[0,100]

#### 返回值

设置的音量值， 取值范围 [0,100]


### record()

录制视频和音频， 每调用一次录制一帧，函数内部会限制速度，如果没有到录制设置的间隔，在到达设定的间隔之前会阻塞

#### 返回值

录制的视频的当前帧的长度




## 例程 

### 例程 1： 播放 `avi` 视频

首先保证视频是 `320x240` 大小， 视频压缩格式为 `mjpeg`， 音频压缩格式位 `PCM`。

可以在这里下载测试可以用的视频： [badapple.avi](http://dl.sipeed.com/MAIX/MaixPy/assets/badapple_320_240_15fps.avi)

```python
import video,time
from Maix import GPIO

fm.register(34,  fm.fpioa.I2S0_OUT_D1)
fm.register(35,  fm.fpioa.I2S0_SCLK)
fm.register(33,  fm.fpioa.I2S0_WS)
fm.register(8,  fm.fpioa.GPIO0)
wifi_en=GPIO(GPIO.GPIO0,GPIO.OUT)
wifi_en.value(0)

v = video.open("/sd/badapple.avi")
print(v)
v.volume(50)
while True:
    if v.play() == 0:
        print("play end")
        break
v.__del__()

```

默认使用了 `I2S0` 来播放音频， 所以需要设置 `I2S0` 对应的引脚， 关闭WiFi是因为`Dock`板WiFi对音质的干扰


### 例程2： 录制 `avi` 视频


```python
import video, sensor, image, lcd, time

lcd.init()  
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.run(1)
sensor.skip_frames(30)
v = video.open("/sd/capture.avi", record=1, interval=200000, quality=50)
i = 0
tim = time.ticks_ms()
while True:
    tim = time.ticks_ms()
    img = sensor.snapshot()
    lcd.display(img)
    img_len = v.record(img)
    # print("record",time.ticks_ms() - tim)
    i += 1
    if i > 100:
        break
print("finish")
v.record_finish()
lcd.clear()
```

可以取消打印屏蔽来看实际的录制间隔有没有达到设置的帧间隔（比如这里设置的`200000us`） 实际打印应该是 `200ms`， 
如果实际帧间隔大于设置的值，则说明实际性能没有达到设置的要求，需要调大设置的帧间隔即减小帧率。 
另外去掉显示和打印也可以一定程度上增加帧率。


