Clock
========
Clock module that calculates the time spent during shooting

## Module Method

### Get timestamp

Get the timestamp from boot to now, in ms. Similar to the ticks_ms method of the time module

```
import clock
clock.ticks()
```

#### Parameters

no

#### return value

* Timestamp from boot to current, in ms

### Sleep

Let the machine sleep for a while, in ms, similar to the sleep_ms method of the time module

```
Clock.sleep(ms)
```

#### Parameters

* `ms`: time of sleep

#### return value

no

## clock类

The clock module can create the clock class, and the clock class can calculate the frame rate.

### Initialization

```
clk = clock.clock()

```

#### Parameters

no

#### return value

* objects of type `clock`

### Get timestamp

Get the current timestamp

#### Parameters

no

#### return value

no

### Calculating frame rate

#### Parameters

no

#### return value

* Frame rate value of `int` type

## Routine

```python
import sensor
import image
import lcd
import clock
clock = clock.clock()
lcd.init()
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.run(1)
while True:
	clock.tick()
	img = sensor.snapshot()
	print("fps = ",clock.fps())
```



























