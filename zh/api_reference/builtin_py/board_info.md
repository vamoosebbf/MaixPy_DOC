Board
=======

> **本文档在 MaixPy 0.5.1-128 版本测试通过。**

这是一个 MaixPy 板级配置模块，它可以在用户层统一 Python 代码，从而屏蔽许多硬件的引脚差异。

效果如下：

```python
from Maix import GPIO
from fpioa_manager import fm
from board import board_info
print(board_info.LED_R)
fm.register(board_info.LED_R, fm.fpioa.GPIO0, force=True)
led_r = GPIO(GPIO.GPIO0, GPIO.OUT)
led_r.value(0)
```

而这份代码同时支持 MaixPy 所有硬件运行，并且打印的 board_info.LED_R 都不尽相同，通过它保证示例代码的一致性。

### board 的配置方法

调用『指定硬件』的配置代码，完成对『指定硬件』配置项（config.json）的导入，它会在 flash 上存储该配置文件。

### Maix Bit

[config_maix_bit.py](https://github.com/sipeed/MaixPy_scripts/tree/master/board/config_maix_bit.py)

### Maix Dock

[config_maix_dock.py](https://github.com/sipeed/MaixPy_scripts/tree/master/board/config_maix_dock.py)

### Maix Go

[config_maix_go.py](https://github.com/sipeed/MaixPy_scripts/tree/master/board/config_maix_go.py)

### Maix Duino

[config_maix_duino.py](https://github.com/sipeed/MaixPy_scripts/tree/master/board/config_maix_duino.py)

### Maix Cube

[config_maix_cube.py](https://github.com/sipeed/MaixPy_scripts/tree/master/board/config_maix_cube.py)

### Maix Amigo

[config_maix_amigo.py](https://github.com/sipeed/MaixPy_scripts/tree/master/board/config_maix_amigo.py)

### Maix Nano

> 这个没有硬件外设.....所以不要问为什么没有它的配置代码了。

### 创建你的专属硬件

你可以借助该接口代码适配你的硬件，配置方法参考 [MaixPy_scripts/board](https://github.com/sipeed/MaixPy_scripts/tree/master/board) 里面有供你参考的配置文件。

### board 的使用方法

导入配置：

```python
from board import board_info
board_info.load({
    'PIN10': 10,
    'BOOT_KEY': 16,
    'WIFI_TX': 6,
    'WIFI_RX': 7,
    'WIFI_EN': 8,
})
print('PIN10:', board_info.PIN10)
print('BOOT_KEY:', board_info.BOOT_KEY)
print('WIFI_TX:', board_info.WIFI_TX)
print('WIFI_RX:', board_info.WIFI_RX)
print('WIFI_EN:', board_info.WIFI_EN)
```

调用结果：

```shell
PIN10: 10
BOOT_KEY: 16
WIFI_TX: 6
WIFI_RX: 7
WIFI_EN: 8
```

> 就这样。