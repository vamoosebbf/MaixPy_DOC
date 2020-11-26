Cpufreq
========

Cpu frequency module, support program to modify cpu and kpu frequency

## method

### Get the current frequency

Get the current cpu and kpu frequency, this method has 2 return values

```python
import cpufreq
cpu_freq,kpu_freq = cpufreq.get_current_frequencies()

```

#### Parameters

no

#### return value

* `cpu_freq`: the current cpu frequency, the unit is M
* `kpu_freq`: the current kpu frequency, the unit is M

### Get the frequency of kpu support

Since kpu is the rate obtained by dividing by pll1 and the current pll1 frequency is fixed at 400M, it is currently unable to support any frequency. Cpu theoretically supports arbitrary frequencies, but it will be biased according to the actual hardware.

```python
import cpufreq
kpu_freqlist = cpufreq.get_kpu_supported_frequencies()

```

### Parameters

no

### return value

* kpu_freqlist: kpu support frequency list

### Setting frequency

Set the cpu or kpu frequency, please note that some peripherals may change performance after the frequency setting is completed.

```python
import cpufreq
kpu_freqlist = cpufreq.set_frequency(cpu = cpu_freq, kpu = kpu_freq)

```

#### Parameters

Parameters can be entered in 1 or 2 of cpu or kpu

* `cpu_freq`: cpu frequency to be set, range [26,400]

* `kpu_freq`: The kpu frequency you want to set, please see the `kpu support frequency list.

#### return value

After using this interface, if the frequency does not change, it returns null. If the frequency changes, the machine will be restarted. Please confirm whether the current situation can be restarted before using this interface.
