SP_LORA 的使用
====

<img src="../../../assets/hardware/module_spmod/sp_lora.png"/>

SP_LoRa 模块使用 M-XL8 模组, 其内置 LoRaTM 调制解调器和可调功率放大器的 LoRa 模块, 具有高性能和高可靠性, 工作频段 370MHz-1200MHz, 最大 20dBm(100mW)持续发射功率.

## 使用说明

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
