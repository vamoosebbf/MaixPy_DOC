# Maixhub 模型训练平台使用说明

Maixhub 模型训练平台可以一键训练 AI 模型给 Maixpy 使用，用户只需提供简单的标注数据， 模型训练与转换都会在云端完成，任务完成后，用户会收到带有模型的邮件。

目前提供分类模型和目标检测模型的训练。

搜集完成数据集之后, 在训练之前请使用预处理软件生产 zip 格式的数据集文件 [点击下载 DataAssitantV1.2(20200602).zip](<https://cn.dl.sipeed.com/MAIX/MaixHub_Tools/DataAssitantV1.2(20200602).zip>)

**更新**
现在也可以使用上述工具中的`Data_Collection_Assitant(Classification).py`, `Data_Collection_Assitant(ObjectDection).py`运行在 maixpy 开发板中一站式收集数据和预处理.

- 原初的模型训练平台使用流程:
<iframe src="//player.bilibili.com/player.html?aid=75107985&cid=128487602&page=1" width="100%" height="400" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"></iframe>

- 当前的模型训练平台使用流程:
<iframe src="//player.bilibili.com/player.html?aid=710936944&bvid=BV14D4y1D7S3&cid=197582703&page=1" scrolling="no" width="100%" height="400" border="0" frameborder="0" framespacing="0" allowfullscreen="true"> </iframe>

## 使用步骤
*鉴于流程较长, 推荐参考上述**当前的模型训练平台使用流程***

### 准备数据集

#### 数据集的采集

- 可使用视频 2 中所用的程序(即`DataAssitantV1.2(20200602).zip`)采集数据
- 可以使用智能手机、相机拍摄
- 可以从网络上搜索

  ![](https://cdn.sipeed.com/document/assets/step_1.png)
  ![](https://cdn.sipeed.com/document/assets/step_1_1.png)

#### 数据集处理

首先将图片数据集按分类保存为单独的文件夹, 子目录的名字为最后生成 label 的名字。
注意: 分类文件夹数量要大于**2**个

例如:

```
数据集文件夹
   |-Class_1
      |- pic01.jpg
      |- pic02.jpg
      |- pic03.jpg
   |-Class_2
      |- pic01.jpg
      |- pic02.jpg
      |- pic03.jpg
   |-Class_3
      |- pic01.jpg
      |- pic02.jpg
      |- pic03.jpg
```

![](https://cdn.sipeed.com/document/assets/step_2_1.png)
将所有分类文件夹打包为 zip 文件即可。
![](https://cdn.sipeed.com/document/assets/step_2_2.png)

注意: 建议的图片分辨率 224\*224, 上传之前可以使用工具批量转换一下
每个分类不要低于 40 张图片，否则无法开始训练
数据集压缩后大小不超过 20M
子目录名不能使用汉字

### 使用转换工具处理

 工具下载地址:[点击下载 DataAssitantV1.2(20200602).zip](<https://cn.dl.sipeed.com/MAIX/MaixHub_Tools/DataAssitantV1.2(20200602).zip>)

1.  将预处理软件下载完成之后，解压即可使用,双击.exe 文件

     ![20200519163844](https://cdn.sipeed.com/document/assets/20200519163844.png)

2.  选择数据集预处理模型 目标检测或目标分类

3.  点击选择文件夹![Snipaste_2020-05-19_16-59-52](https://cdn.sipeed.com/document/assets/Snipaste_2020-05-19_16-59-52.png)

4.  点击开始处理即可, 处理模型为目标分类，直接把生成的 zip 文件上传到模型平台进行训练即可。

#### 目标检测转换

 使用工具转换之后，在使用 VoTT 标注生成 TFRecord 文件。

 [VoTT 下载地址](https://github.com/microsoft/VoTT/releases/tag/v2.1.0) [VoTT 帮助文档](https://github.com/Microsoft/VoTT/blob/master/README.md)



1. 安装完成后打开软件
2. 然后左边这个export选项 选择 tensorflow records,![](https://cdn.sipeed.com/document/assets/Snipaste_2020-05-19_17-08-56.png)
3. 全部标注完后 点export  ![](https://cdn.sipeed.com/document/assets/Snipaste_2020-05-19_17-10-20.png)
4. 会在工程目录生成文件夹 ![](https://cdn.sipeed.com/document/assets/Snipaste_2020-05-19_17-11-59.png)
5. 将文件夹下面的文件全部打包成.zip 上传训练 ![](https://cdn.sipeed.com/document/assets/Snipaste_2020-05-19_17-13-02.png)

## 训练模型

### 获取机器码

- 下载 key_gen 固件 [key_gen_v1.2.zip](https://bbs.sipeed.com/uploads/default/original/1X/bca0832bed92a1ada63bd05327688784e2ef14d1.zip)

- 下载 kflash-gui [kflash-gui](https://github.com/Sipeed/kflash_gui/releases)

- 使用 kflash-gui 烧录 key_gen 固件
  ![](https://cdn.sipeed.com/document/assets/step_3_1.png)
  ![](https://cdn.sipeed.com/document/assets/step_3_2.png)

- 打开串口终端， 重启开发板， 可以看到打印出的机器码。

```
Please Send Bellow Data to Sipeed --> support@sipeed.com:

6f80dccbe29**********cc7e9d69f92

Generate key end


```

其中 `6f80dccbe29**********cc7e9d69f92` 就是对应开发板的机器码

**警告**： 由于需要进行模型加密，key_gen.bin 将**永远**关闭 JTAG 端口，并写入一次性 AES KEY，请确认后再进行烧录。

### 提交训练任务

1. 打开[模型训练平台](https://www.maixhub.com/index/mtrain/index.html)![](https://cdn.sipeed.com/document/assets/Snipaste_2020-05-19_17-17-12.png)
2. 在填写邮箱处填写接受模型的邮箱
3. 在填写机器码处填写机器码
4. 点击上传数据集，点击上传文件选择准备好的 zip 数据集 ![](https://cdn.sipeed.com/document/assets/Snipaste_2020-05-19_17-19-04.png)
5. 点击开始训练，即可进入排队等待训练
6. 训练结束后，可收到包含 kmodel 模型的邮件

## 使用模型

模型有两种使用方式， 可以使用 sd 卡或烧录 flash 的方式来运行模型脚本。

### 使用 sd 卡

- 烧录最新 Maixpy 固件

- 将邮件中的 zip 解压
  ![](https://cdn.sipeed.com/document/assets/step_4_1.png)

- 将所有文件放到 sd 卡根目录

- 将 sd 卡插到开发板上， 重启开发板

### 烧录模型到 flash

- 模型内自带 maixpy 固件，不需要单独烧录

- 将邮件中的 zip 解压

- 打开 kflash-gui, 选择解压出的 kfpkg 文件

- 烧录即可
  ![](https://cdn.sipeed.com/document/assets/step_4_2.png)
