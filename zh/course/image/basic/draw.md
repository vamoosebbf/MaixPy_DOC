画图 写字
======


有两种方式，推荐第二种

## 第一种， 使用`lcd`模块直接在屏幕上画

```
lcd.draw_string(0, 0, "hello")
```

更多的函数和参数，参见[lcd API 手册](/api_reference/machine_vision/lcd.md)

## 第二种， 使用`image` 模块在内存中画，画完后使用`lcd.display`函数将整张图片展示到屏幕

```python
import image, lcd

lcd.init()

img = image.Image(size=(320, 240))
img.draw_string(0,0, "hello")
lcd.display(img)

```

更多的函数和参数，可以看 [image API 手册](/api_reference/machine_vision/image.md) , 在页面搜索`image.draw` 可以找到所有画图函数



