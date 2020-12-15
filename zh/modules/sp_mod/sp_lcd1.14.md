SP_LCD1.14 的使用
====

<img src="../../../assets/hardware/module_spmod/sp_lcd1.14.png"/>

SP_LCD 拥有一块1.14’寸 LCD， 8P FPC(0.5mm 间距)接口的 TFT 液晶屏，180°可视角.

## 参数

* 屏幕大小: 1.14 英寸
* 分辨率: 240*135
* 色彩: 132 个 RGB 通道
* 通信接口: SPI
* 有效显示区域:21.7mm * 10.8mm
* 工作电压: 2.5V~4.8V
* 工作温度: -30°C~85°C

## 使用方法

连接模块, 取出文末的示例代码, 修改代码中 config 包围的配置为自己的, 即可运行查看效果.

程序如下:

```python
# init
ips = SPLCD114(spi1, cs, dc, rst, busy, IPS_WIDTH, IPS_HEIGHT, IPS_MODE)

# create an 'image' and fill it
img = image.Image()
img.draw_rectangle(80, 80, 30, 30)

# display
ips.display(img)
```

主要步骤为:

* 初始化(参数从左到右为: SPI 对象, 片选脚, 复位脚, 忙标志脚, 屏幕宽, 屏幕高度, 屏幕方向).

* 创建 Image.
  
* 调用 display 显示图片(传入参数为 Image 对象).

[示例代码](https://github.com/sipeed/MaixPy_scripts/tree/master/modules/spmod/sp_lcd114)
