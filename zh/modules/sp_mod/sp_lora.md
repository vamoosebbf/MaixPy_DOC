SP_LORA 的使用
====

<img src="../../../assets/hardware/module_spmod/sp_lora.png"/>

SP_LoRa 模块使用 M-XL8 模组, 其内置 LoRaTM 调制解调器和可调功率放大器的 LoRa 模块, 具有高性能和高可靠性.

## 参数

* 工作频段: 370MHz~1200Mhz
* 发射功率: 20dBm(最大)
* 通信接口: SPI
* 天线: 外置天线,IPEX 或焊接
* 接收灵敏度: -148dbm
* RSSI 动态范围: 127dB
* 工作电压: 1.8V~6.3V
* 工作温度: -40°C~80°C

## 使用方法

MaixPy 程序如下:

```python
# init
lora = SX127x(spi=spi1, pin_ss=cs)

# lora reset
rst.value(0)
time.sleep_ms(10)
rst.value(1)
time.sleep_ms(100)
lora.init()

####### receiver ###########
receive(lora)

######## sender ###########
# send(lora)
```

主要步骤为:

* 创建 LoRa 对象(参数为: SPI 对象, 片选脚)

* 复位(将复位引脚拉低有拉高), 初始化.
  
* 开始发送或接收.

[示例代码](https://github.com/sipeed/MaixPy_scripts/blob/master/hardware/demo_sp_lora.py)
