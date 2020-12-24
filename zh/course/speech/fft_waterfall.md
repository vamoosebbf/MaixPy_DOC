FFT 瀑布图(雨图)
========

FFT 瀑布图即为数据随时间变化的频率分布图，下面将介绍如何使用 MaixPy 绘制瀑布图。

## 绘制方法

* 准备时域信号（例如音频数据）

```python
rx = I2S(I2S.DEVICE_0)
rx.channel_config(rx.CHANNEL_0, rx.RECEIVER, align_mode = I2S.STANDARD_MODE)
rx.set_sample_rate(sample_rate)
audio = rx.record(sample_points)
```

* 进行FFT运算（将数据进行 FFT 运算并获取其频率分布情况）

```python
fft_points = 512
fft_res = FFT.run(audio.to_bytes(),fft_points)
fft_amp = FFT.amplitude(fft_res)
```

* 绘制在 image （由于 FFT 结果的对称性，只需要绘制其中一部分即可）

```python
hist_x_num = 128
img = image.Image(size=(128,128))
for i in range(hist_x_num):
        img[i] = fft_amp[i]
```

*详细API参考[I2S-API](../../api_reference/Maix/i2s.md), [FFT-API](../../api_reference/Maix/fft.md)*

## 完整例程

实时采集音频数据并绘制为 FFT 瀑布图

> 以下例程在固件v0.5.1 MaixDock 测试通过

```python
from Maix import GPIO, I2S,  FFT
import image, lcd, math
from board import board_info
from fpioa_manager import fm
import KPU as kpu

sample_rate = 11025
sample_points = 1024
fft_points = 512
hist_x_num = 128

lcd.init()
# close WiFi
fm.register(8,  fm.fpioa.GPIO0)
wifi_en=GPIO(GPIO.GPIO0,GPIO.OUT)
wifi_en.value(0)
fm.register(20,fm.fpioa.I2S0_IN_D0)
fm.register(30,fm.fpioa.I2S0_WS)    # 30 on dock/bit Board
fm.register(32,fm.fpioa.I2S0_SCLK)  # 32 on dock/bit Board

rx = I2S(I2S.DEVICE_0)
rx.channel_config(rx.CHANNEL_0, rx.RECEIVER, align_mode = I2S.STANDARD_MODE)
rx.set_sample_rate(sample_rate)
img = image.Image(size=(128,128))
img=img.to_grayscale()

while True:
    audio = rx.record(sample_points)
    fft_res = FFT.run(audio.to_bytes(),fft_points)
    fft_amp = FFT.amplitude(fft_res)
    img_tmp = img.cut(0,0,128,127)
    img.draw_image(img_tmp, 0,1)
    for i in range(hist_x_num):
        img[i] = fft_amp[i]
    del(img_tmp)
    imgc = img.to_rainbow(1)
    lcd.display(imgc)
    del(imgc)
    fft_amp.clear()
```
