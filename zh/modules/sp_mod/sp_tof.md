SP_TOF 的使用
=====

<img src="../../../assets/hardware/module_spmod/sp_tof.png"/>

SP_TOF 所采用的 VL53L0X 是新一代飞行时间(ToF)激光测距模块, 无论目标反射率如何, 都能提供精确的距离测量, 搭配的红色激光瞄头辅助观察测距点.

## 参数

* 测量距离: 最大 2000mm(较暗环境), 1000mm(明亮环境)
* 工作刷新率: 50Hz
* 测量角度: 27°(正面)
* 通信接口: I2C
* 工作电压: 2.6V~3.5V
* 工作温度: -40°C~80°C

## 使用方法

程序如下:

连接模块, 取出文末的示例代码, 修改代码中 config 包围的配置为自己的, 即可运行查看效果.

```python
# create obj and read distance
tof = VL53L0X(i2c)
while True:
    mm = tof.read()
    utime.sleep_ms(100)
    print(mm)

'''output
>>> [41]
536mm
538mm
533mm
535mm
529mm
532mm
'''
```

主要步骤为:

* 创建 TOF 对象(参数为: I2C 对象).

* 读取距离, 若读取距离为 8190, 则说明已经超出量程.

[示例代码](https://github.com/sipeed/MaixPy_scripts/tree/master/modules/spmod/sp_tof)