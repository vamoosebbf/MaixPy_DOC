# Summary

* [简介](README.md)
  - [MaixPy 能做哪些事](./what_maix_do.md)
  - [如何正确阅读本文档](./how_to_read.md)

----

## 新手必看指南

* 开发板选购指南与开箱验证
  - [开发板&&配件选购指南](./develop_kit_board/get_hardware.md)
  - [MaixAmigo 开箱验证](./develop_kit_board/maix_amigo.md)
  - [MaixCube 开箱验证](./develop_kit_board/maix_cube.md)
  - [MaixDuino 开箱验证](./develop_kit_board/maix_duino.md)
  - [MaixDock 开箱验证](./develop_kit_board/maix_dock.md)
  - [MaixGo 开箱验证](./develop_kit_board/maix_go.md)
  - [MaixNano 开箱验证](./develop_kit_board/maix_nano.md)
  - [MaixBit 开箱验证](./develop_kit_board/maix_bit.md)
* 开发环境准备
  - [安装驱动](./get_started/env_install_driver.md)
  - [使用串口终端工具](./get_started/env_serial_tools.md)
  - [更新 MaixPy 固件](./get_started/upgrade_maixpy_firmware.md)
  - [更新板载 ESP32 固件](./get_started/upgrade_esp32_firmware.md)
  - [更新板载 ESP8285 固件](./get_started/upgrade_esp8285_firmware.md)
  - [MaixPy IDE 使用说明](./get_started/env_maixpyide.md)
* 上手
  - [上电](./get_started/get_started_power_on.md)
  - [第一个程序: 点亮 LED](./get_started/get_started_led_blink.md)
  - [编辑并运行文件](./get_started/get_started_edit_file.md)
  - [上传脚本&模块到开发板](./get_started/get_started_upload_script.md)
  - [开机自动运行脚本](./get_started/get_started_boot.md)
  - [上手视频教程](./get_started/maixpy_get_started_video.md)
* 基础知识
  - [基础知识](./get_started/knowledge_prepare.md)
  - [MicroPython 基础知识](./get_started/knowledge_micropython.md)
  - [MaixPy 图像处理知识](./get_started/knowledge_image.md)
  - [MaixPy 音频处理知识](./get_started/knowledge_audio.md)


## MaixPy 应用上手

----

* MaixPy 基础外设应用
  - [FPIOA](./api_reference/Maix/fpioa.md)
  - [GPIO](./api_reference/Maix/gpio.md)
  - [I2S](./api_reference/Maix/i2s.md)
  - [I2C](./api_reference/machine/i2c.md)
  - [PWM](./api_reference/machine/pwm.md)
  - [SPI](./api_reference/machine/spi.md)
  - [Timer](./api_reference/machine/timer.md)
  - [UART](./api_reference/machine/uart.md)
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
  - [Lcd](./api_reference/machine_vision/lcd.md)
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

-----

## 机器视觉之深度学习

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
* MaixPy 例程解析
  - [MaixPy_script]()
  - [MaixPy 基本例程解析]()
  - [MaixPy 视觉识别例程解析]()

* MaixHub 模型平台
  - [模型下载使用](./maixhub/maixhub_platform.md)
  - [分类模型训练]()
  - [检测模型训练]()
  - [模型分享]()
  - [MaixPy 固件在线编译平台]()

-----

* [MaixPy API 使用手册](./api_reference/README.md)
  * [MaixPy 标准库](./api_reference/standard/README.md)
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

* [进阶开发]()
  * [MaixPy SDK 二次开发](./contribute/compile.md)

* [文档贡献]()
  - [项目结构](./contribute/code_struct.md)
  - [代码规范](./contribute/coding_style.md)
  - [文档找茬悬赏](./contribute/README.md)
  - [文档模板](./contribute/app_doc_template.md)


* 常见问题 FAQ
  - [MaixPy 常见问题 FAQ](./others/maixpy_faq.md)
  - [MaixHub 平台 FAQ](./others/maixhub_faq.md)
