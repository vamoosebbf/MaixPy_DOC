# Summary

* [简介](README.md)
* [MaixPy 能做哪些事](./what_maix_do.md)
* [MaixPy 发展历程]
* [致谢]()


## 入门必看指南

* [如何正确阅读本文档(重要！！！)](./how_to_read.md)
* [我提的问题为什么没人回答???]()
* 开发板和配件选购指南
  - [开发板选购指南(对比)](./develop_kit_board/get_hardware.md)
  - 开发板介绍
    - [Maix Dock](./develop_kit_board/maix_dock.md)
    - [Maix Bit](./develop_kit_board/maix_bit.md)
    - [Maix Amigo](./develop_kit_board/maix_amigo.md)
    - [Maix Duino](./develop_kit_board/maix_duino.md)
    - [Maix Cube](./develop_kit_board/maix_cube.md)
    - [Maix Go](./develop_kit_board/maix_go.md)
    - [Maix Nano](./develop_kit_board/maix_nano.md)
  - 外设模组（配件）
    - [SP-MOD]
    - [Grove]
    - [其它]
* 基础知识
  - [MaixPy 语法基础知识](./get_started/knowledge_micropython.md)
  - [git 和 github]
  - [MaixPy 图像基础知识](./get_started/knowledge_image.md)
  - [MaixPy 音频基础知识](./get_started/knowledge_audio.md)
  - 深度神经网络基础知识
* 开发环境准备
  - [安装驱动](./get_started/env_install_driver.md)
    - [Maix Dock]
    - [Maix Bit]
    - [Maix Amigo]
    - [Maix Cube]
    - [Maix Go]
    - [Maix Nano]
  - [更新 MaixPy 固件](./get_started/upgrade_maixpy_firmware.md)
  - [使用串口终端工具](./get_started/env_serial_tools.md)
  - [MaixPy IDE 使用说明](./get_started/env_maixpyide.md)
  - [更新 WIFI 模块固件]
    - [更新板载 ESP32 固件](./get_started/upgrade_esp32_firmware.md)
    - [更新板载 ESP8285 固件](./get_started/upgrade_esp8285_firmware.md)
* 上手
  - [上电](/get_started/get_started_power_on.md)
  - [第一个程序: 使用屏幕和摄像头]
  - [第二个程序: 点亮 LED](./get_started/get_started_led_blink.md)
  - [文件系统介绍]
  - [编辑并运行脚本](./get_started/get_started_edit_file.md)
  - [上传脚本到开发板](./get_started/get_started_upload_script.md)
  - [开机自动运行脚本](./get_started/get_started_boot.md)
  - [开发板配置文件]()
  - [上手视频教程](./get_started/maixpy_get_started_video.md)
* 固件定制
  - [为什么需要定制固件]()
  - [在线编译]()
  - [源码编译]()


## MaixPy 手把手教程

* 教程说明
* 基本图像处理
  * 图像获取和显示
    * 图像获取
    * 图像显示
  * 基本画图、写字
  * 图像变换
  * 硬件加速的图像处理
* MaixPy AI
  * 深度神经网络基础知识
  * MaixPy AI 硬件加速基础知识
  * 图像处理
    * 人脸检测
    * 物体分类
    * [mnist 手写数字识别](./deep_learning/mnist.md)
    * 人脸识别
    * 自学习分类
  * 音频处理
    * 语音识别
* 模型训练
  * 训练自己的分类和检测模型
    * MaixHub 云端训练
    * 本地训练
  * 自定义新的模型
* 传统算法
  * 图像处理
    - [寻找色块]()
    - [二维码识别](./application/image/qrcode.md)
  * 音频处理
    - [FFT频谱图]
    - [声场成像]
    - [关键词识别](speech_recognizer)
* [外设]
  * [片上外设]
  * SP-MOD
    - [Weather 天气模块]
    - [TOF 镜头]
    - [SSD1306 OLED]
  * Grove
    - [超声波]
    - [RGB LED 链]
    - [ws2812 灯条]
  * 其它外设
    - [Sipeed 麦克风阵列](./develop_kit_board/module_microphone.md)
    - [双摄模块]
    - [MLX90640 串口红外镜头模块]
    - [HTPA 红外镜头]
    - [舵机]
    - [ESP32 ADC]()
* 其它功能
  * [编辑器 pye]
  * 系统
    - [内存控制]()
    - [主频、复位等]()
  * GUI
    - [Maix GUI](./api_reference/application/maixui.md)
    - [Lvgl](./api_reference/application/lvgl.md)
  * 网络(ESP8266/ESP32)
    - [socket]()
    - [http/https]()
  * 多媒体
    - [Audio](./api_reference/Maix/audio.md)
    - [video](./api_reference/machine_vision/video.md)
  * 游戏
    - [NES 游戏模拟器](./api_reference/application/nes.md)



## API手册

* [标准库](./api_reference/standard/README.md)
  - [cmath](./api_reference/standard/cmath.md)
  - [gc](./api_reference/standard/gc.md)
  - [math](./api_reference/standard/math.md)
  - [sys](./api_reference/standard/sys.md)
  - [ubinascii](./api_reference/standard/ubinascii.md)
  - [ucollections](./api_reference/standard/ucollections.md)
  - [uctypes](./api_reference/standard/uctypes.md)
  - [uerrno](./api_reference/standard/uerrno.md)
  - [uhashlib](./api_reference/standard/uhashlib.md)
  - [uheapq](./api_reference/standard/uheapq.md)
  - [ujson](./api_reference/standard/ujson.md)
  - [uos](./api_reference/standard/uos.md)
  - [ure](./api_reference/standard/ure.md)
  - [uselect](./api_reference/standard/uselect.md)
  - [usocket](./api_reference/standard/usocket.md)
  - [ustruct](./api_reference/standard/ustruct.md)
  - [utime](./api_reference/standard/utime.md)
  - [uzlib](./api_reference/standard/uzlib.md)
* [machine](./api_reference/machine/README.md)
  - [I2C](./api_reference/machine/i2c.md)
  - [PWM](./api_reference/machine/pwm.md)
  - [SPI](./api_reference/machine/spi.md)
  - [Timer](./api_reference/machine/timer.md)
  - [UART](./api_reference/machine/uart.md)
  - [network](./api_reference/machine/network.md)
* [Maix](./api_reference/Maix/README.md)
  - [FPIOA](./api_reference/Maix/fpioa.md)
  - [GPIO](./api_reference/Maix/gpio.md)
  - [KPU](./api_reference/Maix/kpu.md)
  - [FFT](./api_reference/Maix/fft.md)
  - [I2S](./api_reference/Maix/i2s.md)
  - [Audio](./api_reference/Maix/audio.md)
  - [freq](./api_reference/Maix/freq.md)
  - [utils](./api_reference/Maix/utils.md)
* [内置类](./api_reference/builtin_py/README.md)
  - [fpioa_manager](./api_reference/builtin_py/fm.md)
  - [board_info](./api_reference/builtin_py/board_info.md)
* [机器视觉](./api_reference/machine_vision/README.md)
  - [lcd](./api_reference/machine_vision/lcd.md)
  - [sensor](./api_reference/machine_vision/sensor.md)
  - [image](./api_reference/machine_vision/image.md)
  - [video](./api_reference/machine_vision/video.md)
* [MaixPy 附加外设模块](./api_reference/peripheral_modules/README.md)
  - [touchscreen](./api_reference/peripheral_modules/touchscreen.md)
  - [modules.ultrasonic](./api_reference/peripheral_modules/ultrasonic.md)
  - [modules.ws2812](./api_reference/peripheral_modules/ws2812.md)
  - [modules.htpa](./api_reference/peripheral_modules/htpa.md)
  - [Grove RGB LED](./api_reference/peripheral_modules/grove_chainable_rgb_led.md)
* [内置应用](./api_reference/application/README.md)
  - [Micropython Editor](./api_reference/application/pye.md)
  - [nes](./api_reference/application/nes.md)
  - [lvgl](./api_reference/application/lvgl.md)


## 常见问题 FAQ

* [MaixPy 常见问题 FAQ](./others/maixpy_faq.md)
* [MaixHub 平台 FAQ](./others/maixhub_faq.md)


## 进阶

* 进阶开发
  * [如何添加一个 C 模块]()

* 参与贡献
  - [参与文档编写（规范）](./contribute/README.md)
  - [源码目录结构]()
  - [代码编写规范](./contribute/coding_style.md)
  - [共享例程或]()


## 社区 & 分享

- [精选教程分享]()
- [开源项目]()

