内置类
===========

`内置类` 库是对MaixPy底层的类进行封装的用户层接口，方便用户使用MaixPy，它包括以下：

* [fpioa_manager](fm.md)
* [board_info](board_info.md)


需要注意的是， 这些类在开机启动的时候在 `_boot.py` 里面已经被导入了， 所以在串口终端可以直接使用， 但是， **如果是执行文件， 则需要手动写代码导入， 否则找不到类**

```python
from board import board_info
from fpioa_manager import fm
```

或者

只导入
```python
from fpioa_manager import fm, board_info
```
