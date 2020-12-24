I2C 的使用
=========

关于 I2C 详细介绍请参考[I2C-API 文档](../../api_reference/machine/i2c.md).

## 使用方法

* 从 machine 导入 I2C 模块

```python
from machine import I2C
```

* 创建 I2C 对象

```python
i2c = I2C(I2C.I2C0, freq=100000, scl=28, sda=29) # software i2c
```

* 扫描从机, 返回所有从机地址

```python
devices = i2c.scan()
```

* 对从机读写数据

```python
for device in devices:
    i2c.writeto(device, b'123')
    i2c.readfrom(device, 3)
```

## 示例

读取所有从机地址并分别收发数据

```python
from machine import I2C

i2c = I2C(I2C.I2C0, freq=100000, scl=28, sda=29) # software i2c

devices = i2c.scan()
print(devices)

for device in devices:
    i2c.writeto(device, b'123')
    i2c.readfrom(device, 3)
```
