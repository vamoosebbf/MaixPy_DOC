系统控制
==========

## 复位

```python
import machine

machine.reset()
```


## 主频

可以设置 CPU 和 KPU 的主频， 具体参考[Maix.greq](/api_reference/Maix/freq.md)模块

```python
from Maix import freq
freq.set(cpu = 400, kpu = 400)
```
