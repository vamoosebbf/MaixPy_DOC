HTPA 热红外测温模组
======

![](../../../assets/hardware/other/htpat_scale_240x240.png)

## 使用方法

MaixPy 已经在 modules 中实现了 htpa

* 导入并创建 htpa

```python
from machine import I2C
from modules import htpa
dev = htpa(i2c=I2C.I2C0, scl_pin=7, sda_pin=6, i2c_freq=1000000)
```

* 获取检测范围内所有点的温度

```python
temperature = dev.temperature()
```

## 例程

获取所有点的温度并显示在 LCD

[htpa demo](https://github.com/sipeed/MaixPy_scripts/blob/79a5485ec983e67bb8861305a52418b29e0dc205/modules/others/heimann_HTPA_32x32/HTPA_32x32_demo.py)

## 更多

htpa 详细教程: [热红外 heimann (海曼) HTPA 32x32d](https://neucrack.com/p/199)