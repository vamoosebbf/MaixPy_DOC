SP_TOF 的使用
=====

<img src="../../../assets/hardware/module_spmod/sp_tof.png"/>

SP_TOF 所采用的 VL53L0X 是新一代飞行时间(ToF)激光测距模块, 无论目标反射率如何, 都能提供精确的距离测量, 可以测量 2m 的绝对距离, 最高50hz的刷新率. 搭配的红色激光瞄头方便使用者知道当前测距点.

## 使用说明

程序如下:

```python
    # create obj and read distance
    tof = VL53L0X(i2c)
    while True:
        mm = tof.read()
        utime.sleep_ms(100)
        print(mm)
```

主要步骤为:

* 创建 TOF 对象(参数为: I2C 对象).

* 读取距离, 若读取距离为 8190, 则说明已经超出量程.

[示例代码](https://github.com/sipeed/MaixPy_scripts/blob/master/hardware/demo_sp_tof.py)