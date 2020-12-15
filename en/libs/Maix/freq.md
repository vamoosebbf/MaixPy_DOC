Maix.freq
=========

Frequency module, support program to modify cpu and kpu frequency

## Method



### freq.set (cpu, pll1, kpu_div)

Set cpu or kpu frequency, it will restart automatically after setting

Please note that after the frequency setting is completed, some peripheral performance may be changed.

```python
from Maix import freq
freq.set (cpu = 400, pll1=400, kpu_div=1) #kpu frequency is pll1/kpu_div
```

The configuration file will be saved in the `/flash/freq.conf` file of the file system. Do not modify this file. If the file does not exist, it will be automatically created

#### parameters

Parameters not set will retain their previous values

**Note**: If the `cpu` frequency setting is less than` 60MHz`, the default `REPL` serial baud rate will be set to` 9600`

* `cpu`: The cpu frequency you want to set, the range is [26,600] (The chip has a maximum` 800` but has voltage requirements. The series supported by `MaixPy` do not support up to` 800`, the default `400`, different boards May behave differently, not recommended for stability

* `pll1`: Frequency of` pll1` output, value range [26,1200] (chip maximum 1800, MaixPy limited to 1200), default `400`

* `kpu_div`:` kpu` clock frequency divider. The value range is [1,16]. `kpu` frequency =` pll1` / `kpu_div`. For example, if you want to set the` kpu` frequency to `400`, you only need to set` pll1` to `400` and` kpu_div` to `1`. Note the `kpu` frequency range: [26,600]

#### return value

If the frequency does not change, it returns null.
If the frequency changes, the machine will restart automatically. Please confirm whether the current situation can restart before using this interface


### freq.get ()

Get the currently set frequency parameters

#### return value

`cpu` frequency and`kpu` frequency, returned as a tuple, such as `(400,400)`

### freq.get_cpu ()

Get the current `cpu` frequency

#### return value

`cpu` frequency


### freq.get_kpu ()

Get the currently set kpu frequency

#### return value

Current `kpu` frequency

