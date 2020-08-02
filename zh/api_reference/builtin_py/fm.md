fpioa_manager
===============

fpioa_manager：简称`fm`，该模块用于注册芯片内部功能和引脚，帮助用户管理内部功能和引脚

fm 实际上是使用 `Fpioa_Manager` 类定义的一个对象， 使用 `Micropython` 编写并集成带固件中， 源码看 [fpioa_manager.py](https://github.com/sipeed/MaixPy/blob/master/ports/k210-freertos/mpy_support/builtin-py/fpioa_manager.py)

## 方法

### 注册函数

注册引脚和功能

```
fm.register(pin,function，[force=True])
```
#### 参数

该方法必须传入至少2个参数，不然将返回空值

* `pin`: 功能映射引脚
* `function` : 芯片功能
* `force`: 强制分配，如果为`True`，则可以多次对同一个引脚注册;`False`则不允许同一引脚多次注册。默认为`True`是为了方便`IDE`多次运行程序使用

#### 返回值

该方法具有2个返回值，
* 设置成功返回  1
* 设置失败返回  `reg_pin,reg_func`，表示的是已经被注册的引脚和功能

### 注销函数

注销引脚和功能

```
fm.unregister(pin,function)
```
#### 参数

该方法可以传入1或2个参数，当传入1个参数时，需要添加参数关键字。如果为1个参数，其引脚和功能都将被注销

* `pin`: 功能映射引脚
* `function` : 芯片功能

#### 返回值

* 设置成功返回 `pin,function`，表示被注销的引脚和功能
* 设置失败返回 0

## 例程 

```python
from fpioa_manager import fm, board_info

fm.register(board_info.WIFI_RX,fm.fpioa.UART2_TX)
fm.register(board_info.WIFI_RX,fm.fpioa.UART2_TX)#再注册一次
fm.register(board_info.WIFI_RX,fm.fpioa.SPI0_SS0, force=False)#注册同个引脚
fm.register(board_info.WIFI_RX,fm.fpioa.SPI0_SS0, force=False)#注册同个功能
fm.unregister(board_info.WIFI_RX,fm.fpioa.UART2_TX)#注销功能和引脚
fm.register(board_info.WIFI_RX,fm.fpioa.UART2_TX)
fm.unregister(function = fm.fpioa.UART2_TX)#注销功能
fm.register(board_info.WIFI_RX,fm.fpioa.UART2_TX)
fm.unregister(pin = board_info.WIFI_RX)#注销引脚
```

## 附录

以下引脚已经在 MaxiPy 开机启动时注册，请注意

### SD卡
* `功能`：SPI1_SCLK/SPI1_D0/SPI1_D1/GPIOHS29/SPI0_SS1
* `引脚`：PIN25/PIN26/PIN27/PIN28/PIN29

### LCD
* `功能`：SPI0_SS3/SPI0_SCLK/GPIOHS30/GPIOHS31
* `引脚`：PIN36/PIN37/PIN38/PIN39

### sensor
* `功能`：SCCB_SDA/SCCB_SCLK/CMOS_RST/CMOS_VSYNC/CMOS_PWDN/CMOS_HREF/CMOS_XCLK/CMOS_PCLK
* `引脚`：PIN40/PIN41/PIN42/PIN43/PIN44/PIN45/PIN46/PIN47

### REPL
* `功能`：UARTHS_RX/UARTHS_TX
* `引脚`：PIN4/PIN5


