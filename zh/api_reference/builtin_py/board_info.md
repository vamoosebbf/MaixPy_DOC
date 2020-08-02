board_info
===============
board_info：主要用于方便用户使用开发板引脚配置，其中内置了对人友好的命名及接口，可以使用户减少对电器连接原理图的依赖。

board_info 是内部定义的一个 Board_Info 全局变量， 使用 `MicroPython` 语法编写， 源码见 [board.py](https://github.com/sipeed/MaixPy/blob/master/ports/k210-freertos/mpy_support/builtin-py/board.py)


## 成员

board_info拥有许多个引脚索引和一个列表

### pin_name列表

列表主要是用于类内部使用，用户不对其进行操作

### 引脚索引
引脚索引主要是将数字转换为人类友好的字符串，让用户方便编程

输入以下，请注意不要忽略 `.` 号，然后按下 `tab键` 进行补全，可以看到板级相关的引脚功能

```
board_info.
```

比如输入以下代码，将返回数字 `8`，代表的是开发板的第8号引脚，其电器连接是wifi模块的使能引脚

```
board_info.WIFI_EN
```

## 方法

### 查找方法

当用户不清楚引脚电器连接时，可以使用该方法查找

```
board_info.pin_map(pin_num)
```
#### 参数

该方法不传入参数或者传入一个参数

* `pin_num`: 引脚编号，范围[6,47]

当不传入参数时，将打印所有引脚的板级电气连接信息

传入参数时，仅打印指定引脚的板级电气连接信息

#### 返回值

* 参数错误返回 `False`
* 未知错误返回 `False`
* 查找成功返回 信息

## 例程

### 例程 1

```python

from board import board_info

wifi_en_pin = board_info.WIFI_EN
print(wifi_en_pin)#输出为8
board_info.pin_map()#打印所有
board_info.pin_map(8)#只打印8号引脚的信息
```
