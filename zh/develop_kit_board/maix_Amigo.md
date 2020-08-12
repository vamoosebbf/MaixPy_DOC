# 1MaixAmigo

## 概述

  SIPEED **MaixAmigo** 可开发编程学习套件, MaixAmigo 在硬件上集成前后各 30W 像素摄像头、可扩展 TF 卡槽、用户按键、3.5‘TFT 寸显示屏、520mAh 锂电池、扬声器,麦克风、SPMOD,GROVE 扩展接口等。
  软件上 MaixAmigo 默认搭载 MaixPy, 用户可以非常轻松的使用 MicroPython 语法快速上手 AI IoT 开发，开发人脸识别，物体识别等 AI 应用，同时还预留开发调试接口，也能将其作为一款功能强大的 AI 学习开发板。

## MaixAmigo 外观及功能介绍

### 外观一览

![MaixAmigo](../../assets/hardware/maxi_amigo/maix_amigo_0.png)

<!-- ![maix_amigo_0](maix_amigo.assets/maix_amigo_0.png) -->

### 板载硬件功能介绍

- 3.5 寸 **TFT** 屏幕: 分辨率 **320x480***
- 3.5 寸 电容触摸屏： FT6X36
- 芯片复位按键
- 电源按键: 短按开机, 长按 *8S* 关机
- 三个功能按键
- Grove 接口: 板载 3 个 **Grove** 数字接口, 传感器,控制器扩展无限可能~
- SP-MOD 接口: 板载 3 个更加强大,更高扩展性的 **SP-MOD** 数字接口, I2C,SPI(标准,双线,四线模式)等接口均可以使用
  - 后续支持乐高手柄功能
- TF 卡槽: 多媒体资源扩展,支持大容量储存 
- 摄像头: 搭载 **OV7740** **30W** 像素 与 **GC0328 30W 像素** **Sensor**
- Type-C 接口: USB-TypeC 电源、调试接口,正反盲插
- 电源管理控制单元: AXP173
  - 板载 520mAh 锂电池,支持用户充放电控制
- 音频驱动 IC: ES8374
  - 支持音频录制,播放
- 三轴加速度传感器: MSA301

| 项目 | 说明 |
| ---- | ---- |
|CPU: |双核 64bit RISC-V / 400MHz* (双精度FPU集成)|
|内存: |8MiB 64bit 片上 SRAM|
|存储: |16MiB Flash, 支持 micro SDXC 拓展存储 (最大128GB**)|
|屏幕: |3.5寸 TFT, 电容触摸屏幕分辨率: 320\*480 |
|摄像头: |OV7740 (后摄)与GC0328(前摄) |
|电池: |板载可充电锂聚合物电池 (容量520mAh ) |
|板载扬声器与麦克风| 集成单音频控制器 ES8374 (可播放可录制)                       |
|板载接口: |USB-C \*2 (K210 调试供电接口+兼容 STM32 核心板 USB 接口)  Grove \*3 & SPMOD\*3 (可拓展模块)|
|三轴加速度传感器:| MSA301|

### 板载扩展接口

MaixAmigo 对用户开放了两个高度扩展的接口: SP-MOD 与 Grove 接口,
用户可以很方便的进行 DIY

#### SP-MOD 接口

SP-MOD 即为 sipeed module, simplify PMOD, super module

| 接口 | 接口描述 |
|---|---|
|SP-MODE 接口描述|![SP-MODE 接口描述](../../assets/hardware/module_spmod/spmod_interface_1.png)|
|硬件接口|![硬件接口](../../assets/hardware/module_spmod/spmod_interface_2.png)|

#### Grove 接口

- Grove 模块接口

Grove 接口的线缆有 4 种颜色，用户可以根据颜色快速区别
![](../../assets/hardware/module_grove/grove_interface.jpg)

| --- | 颜色 | 描述 |
| --- | --- | --- |
| pin 1 | 黄色 | (例如, I2C Grove Connectors上的SCL) |
| pin 2 | 白色 | (例如, I2C Grove Connectors上的SDA) |
| pin 3 | 红色 |   VCC (所有的Grove接口红色都是VCC) |
| pin 4 | 黑色 |   GND (所有的Grove接口红色都是GND) |

Grove模块主要有 4 种接口:

1. Grove Digital 数字接口:<br/>
    Grove 数字接口由 Grove 插头的四条标准线组成.<br/>
    两条信号线通常称为 D0 和 D1 .<br/>
    大多数模块只使用 D0, 但有些(像LED Bar Grove显示屏)使用两者.通常核心板会将板卡上的第一个Grove连接头称为 D0, 第二个称为 D1.第一个接头会连接到主控芯片的 DO/D1 管脚, 第二个连接头会连接到主控芯片的D1/D2引脚, 后面的连接头以此类推.

|pin  |Function | Note |
| ---|---|---|
|pin1 | Dn 第一个数字输入 |
|pin2 | Dn+1 第二个数字输入 |
|pin3 | VCC 供电引脚 5V/3.3V |
|pin4 | GND 地 |


1. Grove UART :<br/>
    The Grove UART 是特殊的一种数字输入输出接口.<br/>
    它使用引脚 1 和引脚 2 进行串行输入和发送. <br/>
    引脚1是 RX 线(用于接收数据, 因此是输入), 
    其中引脚 2 是 TX 线(用于向 Grove 模块传输数据).

|pin  |Function|Note|
| ---|---|---|
|pin1 |RX|串行接收|
|pin2 |TX|串行发送|
|pin3 |VCC|供电引脚 5V/3.3V|
|pin4 |GND |地|

1. Grove I2C:<br/>
    有许多类型的 I2C Grove 传感器可用.<br/>MaixAmigo 上的 Grove 只支持 3.3V 传感器

  Grove I2C 连接器具有标准布局.引脚 1 是SCL信号, 引脚 2 是SDA信号

|pin  | Function | Note |
| ---|---|---|
|pin1 | SCL |I2C 时钟 |
|pin2 | SDA |I2C 数据 |
|pin3 | VCC |供电引脚, 5V/3.3V |
|pin4 | GND |地 |

### 板载 I2C 设备

MaixAmigo 板载 I2C 传感器/IC

| IC | 设备 id | I2C 地址(7位地址) |配置：SCL: IO_24, SDA: IO_27|
| --- | --- | --- | --- |
|---|I2C Address| <<1|MaixPy 读取地址|
|ES8374|0x08|0x10|D(16)|
|MSA301|0x13|0x26|D(38)|
|AXP173|0x68|0x34|D(52)|
