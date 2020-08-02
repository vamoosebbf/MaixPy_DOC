KPU
=========

KPU是通用的神经网络处理器，它可以在低功耗的情况下实现卷积神经网络计算，时时获取被检测目标的大小、坐标和种类，对人脸或者物体进行检测和分类。

* KPU 具备以下几个特点：
  * 支持主流训练框架按照特定限制规则训练出来的定点化模型
  * 对网络层数无直接限制，支持每层卷积神经网络参数单独配置，包括输入输出通道数目、输入输 出行宽列高
  * 支持两种卷积内核 1x1 和 3x3
  * 支持任意形式的激活函数
  * 实时工作时最大支持神经网络参数大小为 5.5MiB 到 5.9MiB
  * 非实时工作时最大支持网络参数大小为（Flash 容量-软件体积）

## 模块方法

### 加载模型

从flash或者文件系统中加载模型

```python
import KPU as kpu
task = kpu.load(offset or file_path)
```

#### 参数

* `offtset`: 模型在 flash 中的偏移大小，如 `0xd00000` 表示模型烧录在13M起始的地方
* `file_path`: 模型在文件系统中为文件名， 如 `“/sd/xxx.kmodel”`

##### 返回

* `kpu_net`: kpu 网络对象

### 初始化yolo2网络

为yolo2网络模型传入初始化参数

```python
import KPU as kpu
task = kpu.load(offset or file_path)
anchor = (1.889, 2.5245, 2.9465, 3.94056, 3.99987, 5.3658, 5.155437, 6.92275, 6.718375, 9.01025)
kpu.init_yolo2(task, 0.5, 0.3, 5, anchor)
```

#### 参数

* `kpu_net`: kpu 网络对象

* `threshold`: 概率阈值

* `nms_value`: box_iou 门限

* `anchor_num`: 锚点数

* `anchor`: 锚点参数与模型参数一致

### 反初始化

```python
import KPU as kpu
task = kpu.load(offset or file_path)
kpu.deinit(task)
```

#### 参数

`kpu_net`: kpu_load 返回的 kpu_net 对象


### 运行yolo2网络

```python
import KPU as kpu
import image
task = kpu.load(offset or file_path)
anchor = (1.889, 2.5245, 2.9465, 3.94056, 3.99987, 5.3658, 5.155437, 6.92275, 6.718375, 9.01025)
kpu.init_yolo2(task, 0.5, 0.3, 5, anchor)
img = image.Image()
kpu.run_yolo2(task, img) #此处不对，请参考例程
```

#### 参数

* `kpu_net`: kpu_load 返回的 kpu_net 对象
* `image_t`：从 sensor 采集到的图像

##### 返回

* `list`: kpu_yolo2_find 的列表 

### 网络前向运算(forward)

计算已加载的网络模型到指定层数，输出目标层的特征图

```python
import KPU as kpu
task = kpu.load(offset or file_path)
……
fmap=kpu.forward(task,img,3)
```

#### 参数

* `kpu_net`: kpu_net 对象
* `image_t`: 从 sensor 采集到的图像
* `int`: 指定计算到网络的第几层

##### 返回

* `fmap`: 特征图对象，内含当前层所有通道的特征图


### fmap 特征图

取特征图的指定通道数据到image对象

```python
img=kpu.fmap(fmap,1)
```

#### 参数

* `fmap`: 特征图 对象
* `int`: 指定特征图的通道号

##### 返回

* `img_t`: 特征图对应通道生成的灰度图


### fmap_free 释放特征图

释放特征图对象

```python
kpu.fmap_free(fmap)
```

#### 参数

* `fmap`: 特征图 对象

##### 返回

* 无

### netinfo 

获取模型的网络结构信息

```python
info=kpu.netinfo(task)
layer0=info[0]
```

#### 参数

* `kpu_net`: kpu_net 对象

##### 返回

* `netinfo list`：所有层的信息list, 包含信息为：
```
index：当前层在网络中的层数
wi：输入宽度
hi：输入高度
wo：输出宽度
ho：输出高度
chi：输入通道数
cho：输出通道数
dw：是否为depth wise layer
kernel_type：卷积核类型，0为1x1， 1为3x3
pool_type：池化类型，0不池化; 1：2x2 max pooling; 2:...
para_size：当前层的卷积参数字节数
```

## 例程

#### 运行人脸识别demo

模型下载地址：http://dl.sipeed.com/MAIX/MaixPy/model/face_model_at_0x300000.kfpkg

```python
import sensor
import image
import lcd
import KPU as kpu

lcd.init()
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.run(1)
task = kpu.load(0x300000) #使用kfpkg将 kmodel 与 maixpy 固件打包下载到 flash
anchor = (1.889, 2.5245, 2.9465, 3.94056, 3.99987, 5.3658, 5.155437, 6.92275, 6.718375, 9.01025)
a = kpu.init_yolo2(task, 0.5, 0.3, 5, anchor)
while(True):
    img = sensor.snapshot()
    code = kpu.run_yolo2(task, img)
    if code:
        for i in code:
            print(i)
            a = img.draw_rectangle(i.rect())
    a = lcd.display(img)
a = kpu.deinit(task)
```

#### 运行特征图

模型下载地址：http://dl.sipeed.com/MAIX/MaixPy/model/face_model_at_0x300000.kfpkg

该模型是8bit定点模型，约380KB大小，层信息为：
```
1 2        :160x120
3 4 5 6	   :80x60
7 8 9 10   :40x30
11~16      :20x15
```

```python
import sensor
import image
import lcd
import KPU as kpu
index=3  
lcd.init()
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.run(1)
task=kpu.load(0x300000)
img=image.Image()
info=kpu.netinfo(task)
layer=info[index]
w=layer.wo()
h=layer.ho()
num=int(320*240/w/h)
list=[None]*num
x_step=int(320/w)
y_step=int(240/h)
img_lcd=image.Image()
while True:
    img=sensor.snapshot()
    fmap=kpu.forward(task,img,index)
    for i in range(0,num):
        list[i]=kpu.fmap(fmap,i)
    for i in range(0,num):
        list[i].stretch(64,255)
    for i in range(0,num):
        a=img_lcd.draw_image(list[i],((i%x_step)*w,(int(i/x_step))*h))
	   lcd.display(img_lcd)
   	kpu.fmap_free(fmap)
```
