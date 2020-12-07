SP_LCD1.14 的使用
====

<img src="../../../assets/hardware/module_spmod/sp_lcd1.14.png"/>

SP_LCD 拥有一块1.14’寸 LCD，4线 SPI 接口控制，8P FPC(0.5mm 间距)接口的 TFT 液晶屏，180°可视角, 240*135分辨率.

## 使用说明

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

[示例代码](https://github.com/sipeed/MaixPy_scripts/blob/master/hardware/demo_sp_lcd114.py)
