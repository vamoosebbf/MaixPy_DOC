Sensor
=========
Sensor module for camera configuration and image capture, etc., used to control the development board camera to complete the camera task

## method

### Reset function

Reset and initialize the camera. This will automatically scan and get the camera address
```python
sensor.reset([, freq=24000000[, set_regs=True[, dual_buff=False]]])
```



#### Parameters

* `freq`: Set the clock frequency of sensor. The higher the frequency, the higher the frame rate, but the picture quality may be worse. The default is `24MHz`. If the camera has colored spots (ov7740), you can lower it appropriately, such as` 20MHz`
* `set_regs`: Allows the program to write camera registers. The default is` True`. If you need a custom reset sequence, you can set it to False, and then use the `sensor.__ write_reg(addr, value)` function to customize the write register sequence
* `dual_buff`: The default is` False`.Allowing double buffering will increase the frame rate, but the memory footprint will also increase (about 384KiB)

#### return value

no

### Start function

Start or stop the camera

```
sensor.run(enbale)
```

#### Parameters

* enbale: 1 means open, 0 means stop

#### return value

* return: returns 1

### Setting the frame size

It is used to set the camera output frame size. The k210 supports VGA format at most. If it is larger than VGA, it will not be able to acquire images.
The screen of the MaixPy development board is 320*240 resolution, and the recommended setting is QVGA format.

```
sensor.set_framesize(framesize[, set_regs=True])
```

#### Parameters

* `framesize`: frame size
* `set_regs`: Allows the program to write camera registers. The default is` True`. If you need a custom sequence, you can set it to False, and then use the `sensor.__ write_reg(addr, value)` function to customize the write register sequence

#### return value

* `True` : set successfully
* `False`: setting error

### Setting the frame format

Used to set the camera output format, k210 supports rgb565 and yuv422 formats. The screen of the MaixPy development board configuration is set using rgb565, and the recommended setting is RGB565 format.

```
sensor.set_pixformat(format[, set_regs=True])
```
#### Parameters

* `format`: frame format
* `set_regs`: Allows the program to write camera registers. The default is` True`. If you need a custom sequence, you can set it to False, and then use the `sensor.__ write_reg(addr, value)` function to customize the write register sequence

#### return value

* `True` : set successfully
* `False`: setting error

### Starting image capture

Turn on image capture

```
sensor.run(enable)
```
#### Parameters

* `enable`: 1 means start grabbing image 0 means stop grabbing image

#### return value

* `True` : set successfully
* `False`: setting error


### Getting images

Control camera capture image

```
img = sensor.snapshot()
```
#### Parameters

no

#### return value

* `img`: returned image object

### Close the camera

Turn off the camera

```
sensor.shutdown(enable)
```
#### Parameters

* `enable`: 1 means to turn on the camera 0 means to turn off the camera

#### return value

no

### Frame skipping

Skip the specified number of frames or skip the image for the specified time

```
sensor.skip_frames(n, [, time])
```

#### Parameters

* `n`: skip n frame image

* `time`: Skip the specified time in ms


#### return value

no

### Resolution width

Get camera resolution width

```
sensor.width()
```
#### Parameters

no

#### return value

* camera resolution width of `int` type



### Resolution Height

```
sensor.height()
```
#### Parameters

no

#### return value

* `int` type camera resolution height

### Get frame buffer

Get the current frame buffer

```
sensor.get_fb()
```
#### Parameters

no

#### return value

* Object of type `image`

### Get ID

Get the current camera ID

```
sensor.get_id()
```
#### Parameters

no

#### return value

* `int` type ID

### Setting color bar mode

Set the camera to color bar mode

```
sensor.set_colorbar(enable)
```

#### Parameters

* `enable`: 1 means to turn on the color bar mode 0 means to turn off the color bar mode

#### return value

no

### Setting the contrast

Set camera contrast

```
sensor.set_contrast(contrast)
```
#### Parameters

* `constrast`: camera contrast, range [-2, +2]

#### return value

* `True` : set successfully
* `False`: setting error

### Setting brightness

Set camera brightness

```
sensor.set_brightness(brightness)
```
#### Parameters

* `constrast`: camera brightness, range [-2, +2]

####  return value

* `True` : set successfully
* `False`: setting error

### Setting the saturation

Set camera saturation

```
sensor.set_saturation(saturation)
```
#### Parameters

* `constrast`: camera saturation, range [-2, +2]

#### return value

* `True` : set successfully
* `False`: setting error

### Setting automatic gain

Set the camera automatic gain mode

```
sensor.set_auto_gain(enable,gain_db)
```

#### Parameters

* `enable`: 1 means to turn on automatic gain 0 means to turn off automatic gain
* `gain_db`: Set the camera fixed gain value when the auto gain is turned off, the unit is db


#### return value

no

### Get the gain value

Get camera gain value

```
sensor.get_gain_db()
```

#### Parameters

no

#### return value

* Gain value of `float` type

### Setting up horizontal mirroring

Set the camera horizontal mirror

```
sensor.set_hmirror(enable)
```

#### Parameters

* `enable`: 1 means to turn on horizontal mirroring 0 to turn off horizontal mirroring

#### return value

no

### Write register

Write the specified value to the camera register

```
sensor.__write_reg(address, value)
```

#### Parameters

* `address`: register address
* `value` : write value

#### return value

no

### Read register

Read camera register value

```
sensor.__read_reg(address)
```

#### Parameters

* `address`: register address

#### return value

* Register value of type `int`

## Routine


### Routine 1

```python
import sensor
import lcd
lcd.init()
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.run(1)
while 1:
    img = sensor.snapshot()
    lcd.display(img)
```
