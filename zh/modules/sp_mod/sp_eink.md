SP_EINK 的使用
====

<img src="../../../assets/hardware/module_spmod/sp_eink.png"/>

SP_EINK 模块所采用的 GDEW0154M09 是一款 1.54”, SPI 接口控制, 拥有 24P FPC(0.5mm 间距)接口的电子墨水屏, 200x200像素, 黑白红三色显示能力.

## 使用方式

程序如下:

```python
# init
epd = SPEINK(spi1, cs, dc, rst, busy, EPD_WIDTH, EPD_HEIGHT)
epd.init()

# create red image
img_r = image.Image()
img_r = img_r.resize(EPD_WIDTH, EPD_HEIGHT)
img_r.draw_line(0, 0, 100, 100)

# create black/white image
img_bw = image.Image()
img_bw = img_bw.resize(EPD_WIDTH, EPD_HEIGHT)
img_bw.draw_line(100, 50, 200, 100)

# display
epd.display(img_r, img_bw)

# sleep mode
epd.sleep()
```

主要步骤如下:

* 创建 SPEINK 对象(参数为: SPI 对象, 片选脚, 复位脚, 忙标志脚, 横向分辨率, 纵向分辨率, 屏幕旋转角度(0, 90, 180, 270)), 初始化.

* 创建红色和黑色图像, 设置为屏幕大小并填充图像.

* 调用 display(参数依次为: 红色图像, 黑色图像), 此时屏幕将会闪烁并显示图像.
  
* 进入睡眠状态.

[示例代码](https://github.com/sipeed/MaixPy_scripts/blob/master/hardware/demo_sp_eink.py)
