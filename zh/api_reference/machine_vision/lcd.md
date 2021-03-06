lcd（屏幕显示）
====



## 函数

### lcd.init(type=1, freq=15000000, color=lcd.BLACK)

初始化 `LCD` 屏幕显示

#### 参数

* `type`： `LCD` 的类型（保留给未来使用）:
  * `0`: None
  * `1`: lcd shield（默认值）
> type 是键值参数，必须在函数调用中通过写入 type= 来显式地调用

* `freq`： `LCD` （实际上指 `SPI` 的通讯速率） 的频率

* `color`： `LCD` 初始化的颜色， 可以是 16 位的 `RGB565` 颜色值，比如 `0xFFFF`； 或者 `RGB888` 元组， 比如 `(236, 36, 36)`， 默认 `lcd.BLACK`

### lcd.deinit()

注销 `LCD` 驱动，释放I/O引脚

### lcd.width()

返回 `LCD` 的宽度（水平分辨率）


### lcd.height()

返回 `LCD` 的高度（垂直分辨率）。


### lcd.type()

返回 `LCD` 的类型（保留给未来使用）：

0: None
1: lcd Shield

### lcd.freq(freq)

设置或者获取 `LCD` （SPI） 的频率

#### Paremeters

* `freq`: LCD (SPI) 的频率

#### Return

LCD 的频率


### lcd.set_backlight(state)

设置 `LCD` 的背光状态， 关闭背光会大大降低lcd扩展板的能耗

> 未实现

#### 参数

* `state`： 背光亮度， 取值 [0,100]

### lcd.get_backlight()

返回背光状态

#### 返回值

背光亮度， 取值 [0,100]

### lcd.display(image, roi=Auto)

在液晶屏上显示一张 `image`（GRAYSCALE或RGB565）。

roi 是一个感兴趣区域的矩形元组(x, y, w, h)。若未指定，即为图像矩形

若 roi 宽度小于lcd宽度，则用垂直的黑色边框使 roi 居于屏幕中心（即用黑色填充未占用区域）。

若 roi 宽度大于lcd宽度，则 roi 居于屏幕中心，且不匹配像素不会显示（即液晶屏以窗口形态显示 roi 的中心）。

若 roi 高度小于lcd高度，则用垂直的黑色边框使 roi 居于屏幕中心（即用黑色填充未占用区域）。

若 roi 高度大于lcd高度，则 roi 居于屏幕中心，且不匹配像素不会显示（即液晶屏以窗口形态显示 roi 的中心）。

> roi 是键值参数，必须在函数调用中通过写入 roi= 来显式地调用。

### lcd.clear()

将液晶屏清空为黑色或者指定的颜色。

#### 参数

* `color`： `LCD` 初始化的颜色， 可以是 16 位的 `RGB565` 颜色值，比如 `0xFFFF`； 或者 `RGB888` 元组， 比如 `(236, 36, 36)`


### lcd.direction(dir)

在 `v0.3.1` 之后已经被舍弃， 请使用`lcd.rotation` 和 `lcd.invert`代替， 如非必要请勿使用， 接口仍会被保留用于调试使用

设置屏幕方向， 以及是否镜像等

#### 参数

* `dir`： 正常情况下推荐 `lcd.YX_LRUD` 和 `lcd.YX_RLDU`， 另外还有其它值，交换 `XY` 或者 `LR` 或者 `DU`即可

### lcd.rotation(dir)

设置 `LCD` 屏幕方向

#### 参数

* `dir`: 取值范围 [0,3]， 从`0`到`3`依次顺时针旋转

#### 返回值

当前方向，取值[0,3]

### lcd.mirror(invert)

设置 `LCD` 是否镜面显示

#### 参数

* `invert`： 是否镜面显示， `True` 或者 `False`

#### 返回值

当前设置，是否镜面显示，返回`True`或者`False`



## 例程

### 例程 1： 显示英文

```python
import lcd

lcd.init()
lcd.draw_string(100, 100, "hello maixpy", lcd.RED, lcd.BLACK)

```

### 例程 2： 显示图片

```python
import lcd
import image

img = image.Image("/sd/pic.bmp")
lcd.display(img)
```

### 例程 3： 利用显示图片的方式显示英文

```python
import lcd
import image

img = image.Image()
img.draw_string(60, 100, "hello maixpy", scale=2) 
lcd.display(img)
```

### 例程 4： 实时显示摄像头捕捉到的图像

```python
import sensor, lcd

sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.run(1)
sensor.skip_frames()
lcd.init()

while(True):
    lcd.display(sensor.snapshot())
```




