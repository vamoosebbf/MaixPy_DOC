SP_WEATHER 的使用
====

<img src="../../../assets/hardware/module_spmod/sp_weather.png"/>

SP_Weather 拥有两颗传感器, 磁性传感器 QMC7983, 这是一个内置灵敏度补偿与 NTC 的三轴磁性传感器, 具有出色的动态范围和精度以及超低的功耗. 温湿度气压传感器 BME280, 能够同时测量温湿度以及气压.

## 参数

### 磁性传感器 QMC7983

* 磁感应量程: ±30 高斯
* 精度: 每 LSB 1mG
* RMS 噪声: 2mG
* 对外接口: I2C, 默认地址 0x2C,可通过选择电阻调节
* 工作电压: 2.6V~3.6V
* 工作温度: -30°C ~ 85°C

### 温湿度气压传感器 BME280

* 湿度传感器的关键参数
  * 响应时间(τ63%): 1 s
  * 精度公差: ±3% 相对湿度
  * 磁滞: ±1% 相对湿度
* 压力传感器的关键参数
  * RMS 噪声: 0.2Pa(相当于 1.7cm)
  * 偏移温度系数: ±1.5 Pa/K(相当于 1℃ 温度变化时为 ±12.6cm)
* 对外接口: I2C,默认地址 0x76,可通过选择电阻调节
* 工作电压: 1.71V~3.6V
* 工作温度: -30°C ~ 85°C

## 使用方法

程序如下:

```python
weather=SPWEATHER(i2c=i2c_bus) # create sp_weather
while 1:
    time.sleep_ms(500)
    print(weather.qmc_read_xyz) # QMC7983 read data
    print(weather.bme_values) # BME280 read data
```

主要步骤为:

* 创建 SPWEATHE(参数为: I2C 对象).

* 读取磁力传感器数据和温湿度数据.

[示例代码](https://github.com/sipeed/MaixPy_scripts/blob/master/hardware/demo_sp_weather.py)
