# Summary

* [简介](README.md)
  - [MaixPy 能做哪些事](./what_maix_do.md)

----

## 入门必看指南

* [如何正确阅读本文档(重要！！！)](./how_to_read.md)
* 开发板选购指南与开箱验证
  - [开发板&&配件选购指南](./develop_kit_board/get_hardware.md)
  - [MaixAmigo 开箱验证](./develop_kit_board/maix_amigo.md)
  - [MaixCube 开箱验证](./develop_kit_board/maix_cube.md)
  - [MaixDuino 开箱验证](./develop_kit_board/maix_duino.md)
  - [MaixDock 开箱验证](./develop_kit_board/maix_dock.md)
  - [MaixGo 开箱验证](./develop_kit_board/maix_go.md)
  - [MaixNano 开箱验证](./develop_kit_board/maix_nano.md)
  - [MaixBit 开箱验证](./develop_kit_board/maix_bit.md)
* 基础知识
  - [如何提问]()
  - [MicroPython 基础知识](./get_started/knowledge_micropython.md)
  - [MaixPy 图像基础知识](./get_started/knowledge_image.md)
  - [MaixPy 音频基础知识](./get_started/knowledge_audio.md)
  - 深度神经网络基础知识
* 开发环境准备
  - [安装驱动](./get_started/env_install_driver.md)
  - [更新 MaixPy 固件](./get_started/upgrade_maixpy_firmware.md)
  - [使用串口终端工具](./get_started/env_serial_tools.md)
  - [MaixPy IDE 使用说明](./get_started/env_maixpyide.md)
  - [更新板载 ESP32 固件](./get_started/upgrade_esp32_firmware.md)
  - [更新板载 ESP8285 固件](./get_started/upgrade_esp8285_firmware.md)
* 上手
  - [上电](./get_started/get_started_power_on.md)
  - [第一个程序: 使用屏幕和摄像头]()
  - [第二个程序: 点亮 LED](./get_started/get_started_led_blink.md)
  - [编辑并运行脚本](./get_started/get_started_edit_file.md)
  - [开机自动运行脚本](./get_started/get_started_boot.md)
  - [上传脚本到开发板](./get_started/get_started_upload_script.md)
  - [开发板配置文件]()
  - [上手视频教程](./get_started/maixpy_get_started_video.md)
* 固件定制
  - [为什么需要定制固件]()
  - [在线编译]()
  - [源码编译]()

----

## MaixPy 手把手教程

* 基本图像处理
  * 基本画图、写字
  * 图像变换
  * 硬件加速的图像处理
* MaixPy AI
  * 深度神经网络基础知识
  * MaixPy AI 硬件加速基础知识
  * 图像处理
    * 人脸检测
    * 物体分类
    * 人脸识别
    * 自学习分类
  * 音频处理
    * 语音识别
* 模型训练
  * 训练自己的分类和检测模型
    * MaixHub 云端训练
    * 本地训练
  * 自定义新的模型

* 外设
  * MaixPy 基础外设应用
    - [FPIOA](./api_reference/Maix/fpioa.md)
    - [GPIO](./api_reference/Maix/gpio.md)
    - [I2S](./api_reference/Maix/i2s.md)
    - [I2C](./api_reference/machine/i2c.md)
    - [PWM](./api_reference/machine/pwm.md)
    - [SPI](./api_reference/machine/spi.md)
    - [Timer](./api_reference/machine/timer.md)
    - [UART](./api_reference/machine/uart.md)
  * MaixPy 外设配件使用
    - [Sipeed 麦克风阵列](./develop_kit_board/module_microphone.md)
* MaixPy GUI
  - [Lvgl](./api_reference/application/lvgl.md)
  - [Maix GUI](./api_reference/application/maixui.md)
* 网络功能(ESP8266/ESP32)
  - [usocket](./api_reference/standard/usocket.md)
  - [Http/https](./api_reference/machine/network.md)
  - [ESP32 ADC](./api_reference/machine/network.md)
* 系统配置&&功能
  - [freq](./api_reference/Maix/freq.md)
  - [gc 内存回收](./api_reference/standard/gc.md)
* MaixPy 多媒体功能
  - [LCD](./api_reference/machine_vision/lcd.md)
  - [Sensor](./api_reference/machine_vision/sensor.md)
  - [Audio](./api_reference/Maix/audio.md)
  - [video](./api_reference/machine_vision/video.md)
  - [NES 游戏模拟器](./api_reference/application/nes.md)
* MaixPy 图形处理应用(传统算法)
  - [sensor](./application/image/sensor.md)
  - [qrcode](./application/image/qrcode.md)
  - [basic_operation](./application/image/basic_operation.md)
  - [Adaptive_Histogram_Equalization]()
* MaixPy 音频处理应用(传统算法)
  - [Audio]()
  - [Speech Recognizer](./machine_learning/speech_recognizer.md)


* MaixPy 音频处理
  - [频谱显示]()
  - [声谱图]()
  - [传统关键词识别]()
  - [声场成像]()
* 机器视觉
  - [深度学习及 KPU 基础知识](./deep_learning/README.md)
  - [mnist 手写数字识别](./deep_learning/mnist.md)
  - [基于 KPU 加速的图像处理(模糊/锐化/边缘检测)]()
  - [Iris 花卉分类](./deep_learning/iris_classification.md)
  - [HAR 人体运动识别]()
  - [cifar10 基础图像分类]()
  - [mobilenet 1000 物体分类]()
  - [基于 mbnet 的自学习物体分类]()
  - [基于 yolo 的人脸检测]()
  - [基于 yolo 的 20 类物体检测]()
* 机器听觉
  - [深度学习关键词识别]()

* MaixHub 模型平台
  - [模型下载使用](./maixhub/maixhub_platform.md)
  - [分类模型训练]()
  - [检测模型训练]()
  - [模型分享]()
  - [MaixPy 固件在线编译平台]()

-----

## API手册

* [MaixPy API 使用手册](./api_reference/README.md)
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

-----

## 常见问题 FAQ

* [MaixPy 常见问题 FAQ](./others/maixpy_faq.md)
* [MaixHub 平台 FAQ](./others/maixhub_faq.md)

-----

## 进阶

* 进阶开发
  * [如何添加一个 C 模块]()

* 参与贡献
  - [参与文档编写（规范）](./contribute/README.md)
  - [源码目录结构]()
  - [代码编写规范](./contribute/coding_style.md)
  - [共享例程或]()

* 其它
  - [教程分享]()
  - [开源项目]()

