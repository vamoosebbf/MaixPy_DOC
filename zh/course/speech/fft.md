FFT 信号处理
=========

FFT 即快速傅里叶变换（Fast Fourier Transform），将时域信号转化为频域信号，应用范围非常广，例如用于音频图像消除噪声。

## 使用方法

k210 带有硬件 FFT 快速傅里叶变换模块，因此 FFT 运算可以非常快。

* 导入 FFT 模块

```python
import FFT
```

* 输入时域数据并进行傅里叶变换

```python
res = FFT.run(data, points, shift)
```

相关 API 解释请参考[FFT-API](../../api_reference/Maix/fft.md)
## 例程

采集声音并进行FFT运算，将运算后的数据在屏幕上显示为柱状图

例示代码： https://github.com/sipeed/MaixPy_scripts/blob/master/hardware/demo_fft_spectrum.py
