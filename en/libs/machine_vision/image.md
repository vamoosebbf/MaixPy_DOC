Image — machine vision
=====

Ported in `openmv`, same as `openmv`

## Routine

### Routine 1: Find green

```python
import sensor
import image
import lcd
import time
lcd.init()
sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.run(1)
green_threshold   = (0,   80,  -70,   -10,   -0,   30)
while True:
	img=sensor.snapshot()
	blobs = img.find_blobs([green_threshold])
	if blobs:	
		for b in blobs:
			tmp=img.draw_rectangle(b[0:4]) 
			tmp=img.draw_cross(b[5], b[6]) 
			c=img.get_pixel(b[5], b[6])
	lcd.display(img)
```

### Routine 2: Display fps

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
sensor.skip_frames(30)
while True:
    clock.tick()
    img = sensor.snapshot()
    fps =clock.fps()
    img.draw_string(2,2, ("%2.1ffps" %(fps)), color=(0,128,0), scale=2)
    lcd.display(img)
```


### Routine 3: Scan QR code

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
sensor.set_vflip(1)
sensor.run(1)
sensor.skip_frames(30)
while True:
    clock.tick()
    img = sensor.snapshot()
    res = img.find_qrcodes()
    fps =clock.fps()
    if len(res) > 0:
        img.draw_string(2,2, res[0].payload(), color=(0,128,0), scale=2)
        print(res[0].payload())
    lcd.display(img)

```

> If the lens is used, the picture will be distorted and the picture needs to be corrected.
> Use the `lens_corr` function to correct, such as `2.8`mm, `img.lens_corr(1.8)`




## function

The function can also press `Ctrl+F` on the page to search for functions using the browser's search function search `image.`

### image.rgb_to_lab(rgb_tuple)

Returns the tuple (l, a, b) of the LAB format corresponding to the tuple rgb_tuple (r, g, b) in RGB888 format.

> RGB888 refers to 8 bits (0-255) of red, green and blue. In LAB, L has a value range of 0-100, and a/b ranges from -128 to 127.

### image.lab_to_rgb(lab_tuple)

Returns the tuple (r, g, b) of the RGB888 format corresponding to the tuple lab_tuple (l, a, b) in LAB format.

> RGB888 refers to 8 bits (0-255) of red, green and blue. In LAB, L has a value range of 0-100, and a/b ranges from -128 to 127.

### image.rgb_to_grayscale(rgb_tuple)

Returns the gray value corresponding to the tuple rgb_tuple (r, g, b) in RGB888 format.

> RGB888 refers to 8 bits (0-255) of red, green and blue. The gray value is from 0 to 255.

### image.grayscale_to_rgb(g_value)

Returns the tuple (r, g, b) of the RGB888 format corresponding to the gray value g_value.

> RGB888 refers to 8 bits (0-255) of red, green and blue. The gray value is from 0 to 255.

### image.load_decriptor(path)

Load a descriptor object from the disk.

Path is the path where the descriptor file is saved.

### image.save_descriptor(path, descriptor)

Save the descriptor object descriptor to disk.

Path is the path where the descriptor file is saved.

### image.match_descriptor(descritor0, descriptor1[, threshold=70[, filter_outliers=False]])

For the LBP descriptor, this function returns an integer that represents the difference between the two descriptors. This distance measurement is especially necessary. This distance is a measure of similarity. The closer this measure is to 0, the better the LBPF feature points will match.

For the ORB descriptor, this function returns the kptmatch object. See above.

Threshold is used to filter the ambiguous matching service for the ORB keypoint.
A lower threshold value will be tied to the keypoint matching algorithm. The threshold value is at 0-100 (int). The default is 70.

Filter_outliers is used to filter outliers for ORB keypoints. Feature points allow the user to increase the threshold value. The default setting is False.

## HaarCascade Class – Feature Descriptors

The Haar Cascade feature descriptor is used for the `image.find_features()` method. It has no methods for the user to call.

### Constructor

Class image.HaarCascade(path[, stages=Auto])

Load a Haar Cascade from a Haar Cascade binary (a format suitable for OpenMV Cam). If you pass a "frontalface" string instead of a path, this constructor will load a built-in positive face Haar Cascade into memory. In addition, you can also load Haar Cascade into memory via "eye". Finally, this method returns the loaded Haar Cascade object, which is used to use image.find_features() .

The stage default is the number of stages in Haar Cascade. However, you can specify a lower value to speed up the running of the feature detector, which of course leads to a higher false positive rate.

> You can make your own Haar Cascades to work with your OpenMV Cam. First, use Google search "<thing> Haar Cascade" to check if someone has created OpenCV Haar Cascade for the object you want to detect. If not, you need to do it yourself (the amount of work is huge). For information on how to make your own Haar Cascade, see here on how to turn OpenCV Haar Cascades into a mode that your OpenMV Cam can read, see this script

Q: What is Haar Cascade?

A: Haar Cascade is a series of comparison checks used to determine if an object is present in an image. This series of comparison checks is divided into phases, and the operation of the latter phase is premised on the completion of the previous phase. Contrast checks are not complicated, but are like processes that check if the center of the image is slightly more vertical than the edges. A wide range of inspections are carried out first in the early stages, and more small area inspections are carried out later.

Q: How was Haar Cascades made?

A: Haar Cascades trains generator algorithms with positive and negative images. For example, use hundreds of pictures containing cats (marked as containing cats) and hundreds of pictures that do not contain cats (have been marked differently) to train this generation algorithm. This generation algorithm will eventually generate a Haar Cascades for detecting cats.

## Similarity Class – Similarity Object

The similarity object is returned by `image.get_similarity`.

### Constructor

Class image.similarity

Call the image.get_similarity() function to create this object.

### Methods

##### similarity.mean()
Returns the mean of the similarity difference in 8x8 pixel block structure. Range [-1/+1], where -1 is completely different and +1 is identical.

You can also get this value via index [0].

##### similarity.stdev()
Returns the standard deviation of the 8x8 pixel block structure similarity difference.

You can also get this value via index [1].

##### similarity.min()
Returns the minimum value of the 8x8 pixel block structure similarity difference. Where -1 is completely different and +1 is identical.

You can also get this value via index [2].

> By looking at this value, you can quickly determine if any 8x8 pixel blocks between the two images are very different, which is much lower than +1.

##### similarity.max()

Returns the minimum value of the 8x8 pixel block structure similarity difference. Where -1 is completely different and +1 is identical.

You can also get this value via index [3].

> By looking at this value, you can quickly determine if any 8x8 pixel blocks between the two images are the same. That is much larger than -1.

## Histogram Class – Histogram Object

The histogram object is returned by `image.get_histogram`. A grayscale histogram has a channel that contains multiple binaryes. All binaries are normalized to a total of one. RGB565 has three channels with multiple binary. All binaries are normalized to a total of one.

### Constructor

Class image.histogram

Please call the `image.get_histogram()` function to create this object.

### Methods

#### histogram.bins()

Returns a list of floating point numbers for the grayscale histogram. You can also get this value via index [0].

#### histogram.l_bins()

Returns a list of floating point numbers for the L channel of the RGB565 histogram LAB. You can also get this value via index [0].

#### histogram.a_bins()

Returns a list of floating point numbers for the A channel of the RGB565 histogram LAB. You can also get this value via index [1].

#### histogram.b_bins()

Returns a list of floating point numbers for the B channel of the RGB565 histogram LAB. You can also get this value via index [2].

#### histogram.get_percentile(percentile)

Calculates the CDF of the histogram channel, returning a value that passes the histogram in percentile (0.0 - 1.0) (floating point).

Therefore, if you pass in 0.1, this method will tell you which binary will cause the accumulator to cross 0.1 when accumulating the accumulator.

This is effective for determining the minimum (0.1) and max(0.9) of the color distribution when there is no anomalous utility to corrupt your adaptive color tracking results.

#### histogram.get_threhsold()

Use the Otsu’s method to calculate the optimal threshold, dividing each channel of the histogram into two halves. This method returns an image.threshold object. This method is especially useful for determining the best image.binary() threshold.

#### histogram.get_statistics()

Calculates the mean, median, value, standard deviation, minimum, maximum, lower quartile, and upper quartile for each color channel in the histogram and returns a statistics object. You can also use histogram.statistics() and histogram.get_stats() as aliases for this method.





## Percentile Class – Percentage Value Object

The percentage value object is returned by `histogram.get_percentile`. The grayscale value has one channel. Do not use the l_* , a_* , or b_* methods. The RGB565 percentage value has three channels. Use the l_* , a_* , and b_* methods.

### Constructor

Class image.percentile

Call the histogram.get_percentile() function to create this object.

### Methods

#### percentile.value()

Returns the grayscale percentage value (value range 0-255).

You can also get this value via index [0].

#### percentile.l_value()

Returns the percentage value of the L channel of the RGB565 LAB (value range is 0-100).

You can also get this value via index [0].

#### percentile.a_value()

Returns the percentage value of the A channel of the RGB565 LAB (value range -128-127).

You can also get this value via index [1].

#### percentile.b_value()

Returns the percentage value of the B channel of the RGB565 LAB (value range -128-127).

You can also get this value via index [2].

## Threhsold Class – Threshold Object

The threshold object is returned by histogram.get_threshold.

The grayscale image has a channel. There are no l_*, a_*, and b_* methods.

The RGB565 threshold has three channels. Use the l_*, a_*, and b_* methods.

### Constructor

Class image.threshold

Call the histogram.get_threshold() function to create this object.

### Methods

#### threhsold.value()

Returns the threshold of the grayscale image (between 0 and 255).

You can also get this value via index [0].

#### threhsold.l_value()

Returns the L threshold in RGB565 map LAB (between 0 and 100).

You can also get this value via index [0].

#### threhsold.a_value()

Returns the A threshold in the RGB565 graph LAB (between -128 and 127).

You can also get this value via index [1].

#### threhsold.b_value()

Returns the B threshold in RGB565 map LAB (between -128 and 127).

You can also get this value via index [2].

## class Statistics – Statistics Object

The statistics object is returned by histogram.get_statistics or image.get_statistics.

Grayscale statistics have one channel, using non-l_*, a_*, or b_* methods.

The RGB565 percentage value has three channels. Use the l_* , a_* , and b_* methods.

### Constructor

Class image.statistics
Call the histogram.get_statistics() or image.get_statistics() function to create this object.

### Methods

#### statistics.mean()

Returns the grayscale mean (0-255) (int).

You can also get this value via index [0].

#### statistics.median()

Returns the gray value median (0-255) (int).

You can also get this value via index [1].

#### statistics.mode()

Returns the gray level value (0-255) (int).

You can also get this value via index [2].

#### statistics.stdev()

Returns the gray standard deviation (0-255) (int).

You can also get this value via index [3].

#### statistics.min()

Returns the minimum gray level (0-255) (int).

You can also get this value via index [4].

#### statistics.max()

Returns the grayscale maximum (0-255) (int).

You can also get this value via index [5].

#### statistics.lq()

Returns the quarter value (0-255) (int) under gray.

You can also get this value via index [6].

#### statistics.uq()

Returns the grayscale upper quartile (0-255) (int).

You can also get this value via index [7].

#### statistics.l_mean()

Returns the mean (0-255) (int) of L in RGB5656 LAB.

You can also get this value via index [0].

#### statistics.l_median()

Returns the median (0-255) (int) of L in RGB5656 LAB.

You can also get this value via index [1].

#### statistics.l_mode()

Returns the value of L (0-255) (int) in RGB5656 LAB.

You can also get this value via index [2].

#### statistics.l_stdev()

Returns the standard deviation value (0-255) (int) of L in RGB5656 LAB.

You can also get this value via index [3].

#### statistics.l_min()

Returns the minimum value (0-255) (int) of L in RGB5656 LAB.

You can also get this value via index [4].

#### statistics.l_max()

Returns the maximum value (0-255) (int) of L in RGB5656 LAB.

You can also get this value via index [5].

#### statistics.l_lq()

Returns the lower quartile (0-255) (int) of L in RGB5656 LAB.

You can also get this value via index [6].

#### statistics.l_uq()

Returns the upper quartile (0-255) (int) of L in RGB5656 LAB.

You can also get this value via index [7].

#### statistics.a_mean()

Returns the mean (0-255) (int) of A in RGB5656 LAB.

You can also get this value via index [8].

#### statistics.a_median()

Returns the median (0-255) (int) of A in RGB5656 LAB.

You can also get this value via index [9].

#### statistics.a_mode()

Returns the value of A (0-255) (int) in RGB5656 LAB.

You can also get this value via index [10].

#### statistics.a_stdev()

Returns the standard deviation value (0-255) (int) of A in RGB5656 LAB.

You can also get this value via index [11].

#### statistics.a_min()

Returns the minimum value (0-255) (int) of A in RGB5656 LAB.

You can also get this value via index [12].

#### statistics.a_max()

Returns the maximum value (0-255) (int) of A in RGB5656 LAB.

You can also get this value via index [13].

#### statistics.a_lq()

Returns the lower quartile (0-255) (int) of A in RGB5656 LAB.

You can also get this value via index [14].

#### statistics.a_uq()

Returns the upper quartile (0-255) (int) of A in RGB5656 LAB.

You can also get this value via index [15].

#### statistics.b_mean()

Returns the mean (0-255) (int) of B in RGB5656 LAB.

You can also get this value via index [16].

#### statistics.b_median()

Returns the median (0-255) (int) of B in RGB5656 LAB.

You can also get this value via index [17].

#### statistics.b_mode()

Returns the value of B (0-255) (int) in RGB5656 LAB.

You can also get this value via index [18].

#### statistics.b_stdev()

Returns the standard deviation (0-255) (int) of B in RGB5656 LAB.

You can also get this value via index [19].

#### statistics.b_min()

Returns the minimum value (0-255) (int) of B in RGB5656 LAB.

You can also get this value via index [20].

#### statistics.b_max()

Returns the maximum value (0-255) (int) of B in RGB5656 LAB.

You can also get this value via index [21].

#### statistics.b_lq()

Returns the lower quartile (0-255) (int) of B in RGB5656 LAB.

You can also get this value via index [22].

#### statistics.b_uq()

Returns the upper quartile (0-255) (int) of B in RGB5656 LAB.

You can also get this value via index [23].

## Blob class – color block object

The patch object is returned by `image.find_blobs`.

### Constructor

Class image.blob

Call the image.find_blobs() function to create this object.

### Methods

#### blob.rect()

Returns a rectangular tuple (x, y, w, h) for other image methods such as image.draw_rectangle of the color block bounding box.

#### blob.x()

Returns the x coordinate (int) of the bounding box of the patch.

You can also get this value via index [0].

#### blob.y()
Returns the y coordinate (int) of the bounding box of the patch.

You can also get this value via index [1].

#### blob.w()

Returns the w coordinate (int) of the bounding box of the patch.

You can also get this value via index [2].

#### blob.h()

Returns the h coordinate (int) of the bounding box of the patch.

You can also get this value via index [3].

#### blob.pixels()

Returns the number of pixels subordinate to a part of the int.

You can also get this value via index [4].

#### blob.cx()

Returns the center x position of the color block (int).

You can also get this value via index [5].

#### blob.cy()

Returns the center x position of the color block (int).

You can also get this value via index [6].

#### blob.rotation()

Returns the rotation of the patch (in radians). If the color block is similar to a pencil or pen, then this value is a unique value between 0-180. If the color block is round, then this value has no effect. If this color block is completely symmetrical, you can only get a 0-360 degree rotation.

You can also get this value via index [7].

#### blob.code()

Returns a 16-bit binary number with one bit set for each color threshold, which is part of the color block. For example, if you look for three color thresholds via image.find_blobs, this color block can be set to 0/1/2 digits. Note: You can only set one bit per color block unless you call image.find_blobs with merge=True . Then multiple color patches with different color thresholds can be merged together. You can also use this method and multiple thresholds to implement color code tracking.

You can also get this value via index [8].

#### blob.count()

Returns the number of multiple patches that are merged into this patch. This number is not 1 only if you call image.find_blobs with merge=True.

You can also get this value via index [9].

#### blob.area()

Returns the border area around the patch (w * h)

#### blob.density()

Returns the density ratio of this patch. This is the number of pixels in the bounding box area of ​​the patch. In general, a lower density ratio means that the object is not locked well.

## Line Class – Straight Line Object

Line objects are returned by `image.find_lines` , `image.find_line_segments` or `image.get_regression`.

### Constructor

Class image.line

Call the image.find_lines(), image.find_line_segments(), or image.get_regression() function to create this object.

### Methods

#### line.line()

Returns a line tuple (x1, y1, x2, y2) for use with other image methods such as image.draw_line .

#### line.x1()

Returns the p1 vertex x coordinate component of the line.

You can also get this value via index [0].

#### line.y1()

Returns the p1 y component of the line.

You can also get this value via index [1].

#### line.x2()

Returns the p2 x component of the line.

You can also get this value via index [2].

#### line.y2()

Returns the p2 y component of the line.

You can also get this value via index [3].

#### line.length()

Returns the length of the line ie sqrt(((x2-x1)^2) + ((y2-y1)^2).

You can also get this value via index [4].

#### line.magnitude()

Returns the length of the line after the Hough transform.

You can also get this value via index [5].

#### line.theta()

Returns the angle of the line after the Hough transform (0-179 degrees).

You can also get this value via index [7].

#### line.rho()

Returns the p value of the line after the Hough transform.

You can also get this value via index [8].

## CircleClass - Round Object

The circular object is returned by `image.find_circles`.

### Constructor

Class image.circle

Call the image.find_circles() function to create this object.

### Methods

#### circle.x()

Returns the x position of the circle.

You can also get this value via index [0].

#### circle.y()

Returns the y position of the circle.

You can also get this value via index [1].

#### circle.r()

Returns the radius of the circle.

You can also get this value via index [2].

#### circle.magnitude()

Returns the size of the circle.

You can also get this value via index [3].

## Rect class – rectangular object

The rectangle object is returned by `image.find_rects`.

### Constructor

Class image.rect

Call the image.find_rects() function to create this object.

### Methods

#### rect.corners()

Returns a list of four tuples (x, y) consisting of the four corners of a rectangular object. The four corners are usually returned in a clockwise order starting from the upper left corner.

#### rect.rect()

Returns a rectangular tuple (x, y, w, h) for other image methods such as image.draw_rectangle of the bounding box of the rectangle.

#### rect.x()

Returns the x position of the top left corner of the rectangle.

You can also get this value via index [0].

#### rect.y()

Returns the y position of the top left corner of the rectangle.

You can also get this value via index [1].

#### rect.w()

Returns the width of the rectangle.

You can also get this value via index [2].

#### rect.h()

Returns the height of the rectangle.

You can also get this value via index [3].

#### rect.magnitude()

Returns the size of the rectangle.

You can also get this value via index [4].

## QRCode Class – QR Code Object

The QR code object is returned by `image.find_qrcodes`.

### Constructor

Class image.qrcode

Call the image.find_qrcodes() function to create this object.

### Methods

#### qrcode.corners()

Returns a list of four tuples (x, y) consisting of the four corners of the object. The four corners are usually returned in a clockwise order starting from the upper left corner.

#### qrcode.rect()

Returns a rectangular tuple (x, y, w, h) for other image methods such as image.draw_rectangle of the bounding box of the QR code.

#### qrcode.x()

Returns the x coordinate (int) of the bounding box of the QR code.

You can also get this value via index [0].

#### qrcode.y()

Returns the y coordinate (int) of the bounding box of the QR code.

You can also get this value via index [1].

#### qrcode.w()

Returns the w coordinate (int) of the bounding box of the QR code.

You can also get this value via index [2].

#### qrcode.h()

Returns the h coordinate (int) of the bounding box of the QR code.

You can also get this value via index [3].

#### qrcode.payload()

Returns a string of the QR code payload, such as a URL.

You can also get this value via index [4].

#### qrcode.version()

Returns the version number (int) of the QR code.

You can also get this value via index [5].

#### qrcode.ecc_level()

Returns the ECC level (int) of the QR code.

You can also get this value via index [6].

#### qrcode.mask()

Returns the mask (int) of the QR code.

You can also get this value via index [7].

#### qrcode.data_type()

Returns the data type of the QR code.

You can also get this value via index [8].

#### qrcode.eci()

Returns the ECI of the QR code. The ECI stores the code for storing the data bytes in the QR code. If you want to process a QR code that contains more than standard ASCII text, you need to look at this value.

You can also get this value via index [9].

#### qrcode.is_numeric()

Returns True if the data type of the QR code is numeric.

#### qrcode.is_alphanumeric()

Returns True if the data type of the QR code is alphanumeric.

#### qrcode.is_binary()

Returns True if the data type of the QR code is binary. If you are dealing with all types of text carefully, you need to check if eci is True to determine the text encoding of the data. Usually it's just standard ASCII, but it could also be UTF8 with two byte characters.

#### qrcode.is_kanji()

Returns True if the data type of the QR code is Japanese Kanji. When set to True, you need to decode the string yourself, because the Japanese character is 10 digits per character, and MicroPython does not support parsing such text.

## AprilTag Class – AprilTag object

The AprilTag object is returned by `image.find_apriltags`.

### Constructor

Class image.apriltag

Call the image.find_apriltags() function to create this object.

### Methods

#### apriltag.corners()

Returns a list of four tuples (x, y) consisting of the four corners of the object. The four corners are usually returned in a clockwise order starting from the upper left corner.

#### apriltag.rect()


Returns a rectangular tuple (x, y, w, h) for other image methods such as image.draw_rectangle of the AprilTag bounding box.

#### apriltag.x()

Returns the x coordinate (int) of the AprilTag bounding box.

You can also get this value via index [0].

#### apriltag.y()

Returns the y coordinate (int) of the AprilTag bounding box.

You can also get this value via index [1].

#### apriltag.w()

Returns the w coordinate (int) of the AprilTag bounding box.

You can also get this value via index [2].

#### apriltag.h()

Returns the h coordinate (int) of the AprilTag bounding box.

You can also get this value via index [3].

#### apriltag.id()

Returns the numeric ID of the AprilTag.

TAG16H5 -> 0 to 29
TAG25H7 -> 0 to 241
TAG25H9 -> 0 to 34
TAG36H10 -> 0 to 2319
TAG36H11 -> 0 to 586
ARTOOLKIT -> 0 to 511
You can also get this value via index [4].

#### apriltag.family()

Return to the digital family of AprilTag.

image.TAG16H5
image.TAG25H7
image.TAG25H9
image.TAG36H10
image.TAG36H11
image.ARTOOLKIT
You can also get this value via index [5].

#### apriltag.cx()

Returns the center x position (int) of the AprilTag.

You can also get this value via index [6].

#### apriltag.cy()

Returns the center y position (int) of the AprilTag.

You can also get this value via index [7].

#### apriltag.rotation()

Returns the curl (int) of the AprilTag in radians.

You can also get this value via index [8].

#### apriltag.decision_margin()

Returns the color saturation of the AprilTag match (values ​​0.0 - 1.0), where 1.0 is optimal.

You can also get this value via index [9].

#### apriltag.hamming()

Returns the acceptable digit error value for the AprilTag.

TAG16H5 -> accepts up to 0 bit errors
TAG25H7 -> accepts up to 1 bit error
TAG25H9 -> accepts up to 3 bit errors
TAG36H10 -> accepts up to 3 bit errors
TAG36H11 -> accepts up to 4 errors
ARTOOLKIT -> accepts up to 0 bit errors
You can also get this value via index [10].

#### apriltag.goodness()

Returns the color saturation of the AprilTag image (value 0.0 - 1.0), where 1.0 is optimal.

> Currently this value is usually 0.0. In the future, we can enable a feature called "tag refinement" to achieve detection of smaller AprilTag. However, this feature now reduces the frame rate below 1 FPS.

You can also get this value via index [11].

#### apriltag.x_translation()

Returns the transformation from the x direction of the camera. The unit of distance is unknown.

This method is useful for determining the position of the AprilTag away from the camera. However, the size of the AprilTag and the factors you use will affect the determination of the X unit ownership. For ease of use, we recommend that you use a lookup table to convert the output of this method into information that is useful to your application.

Note: The direction here is from left to right.

You can also get this value via index [12].

#### apriltag.y_translation()

Returns the transformation from the y direction of the camera, the unit of distance is unknown.

This method is useful for determining the position of the AprilTag away from the camera. However, the size of the AprilTag and the factors you use will affect the determination of the Y unit ownership. For ease of use, we recommend that you use a lookup table to convert the output of this method into information that is useful to your application.

Note: The direction here is from top to bottom.

You can also get this value via index [13].

#### apriltag.z_translation()

Returns the transformation from the camera's z direction, the unit of distance is unknown.

This method is useful for determining the position of the AprilTag away from the camera. However, factors such as the size of the AprilTag and the lens you are using will affect the determination of the Z-unit attribution. For ease of use, we recommend that you use a lookup table to convert the output of this method into information that is useful to your application.

Note: The direction here is from front to back.

You can also get this value via index [14].

#### apriltag.x_rotation()

Returns the curl of the AprilTag in radians on the X plane. Example: Visually see the AprilTag and move the camera from left to right.

You can also get this value via index [15].

#### apriltag.y_rotation()

Returns the curl of the AprilTag in radians on the Y plane. Example: Visualize the AprilTag and move the camera from top to bottom.

You can also get this value via index [16].

#### apriltag.z_rotation()

Returns the curl of the AprilTag in radians on the Z plane. Example: Visualize the AprilTag and rotate the camera.

Note: This is just a renamed version of apriltag.rotation().

You can also get this value via index [17].

## DataMatrix Class – Data Matrix Object

The data matrix object is returned by `image.find_datamatrices`.

## Constructor

Class image.datamatrix

Call the image.find_datamatrices() function to create this object.

### Methods

#### datamatrix.corners()

Returns a list of four tuples (x, y) consisting of the four corners of the object. The four corners are usually returned in a clockwise order starting from the upper left corner.

#### datamatrix.rect()

Returns a rectangular tuple (x, y, w, h) for other image methods such as image.draw_rectangle of the bounding box of the data matrix.

#### datamatrix.x()

Returns the x coordinate (int) of the bounding box of the data matrix.

You can also get this value via index [0].

#### datamatrix.y()

Returns the y coordinate (int) of the bounding box of the data matrix.

You can also get this value via index [1].

#### datamatrix.w()

Returns the w width of the bounding box of the data matrix.

You can also get this value via index [2].

#### datamatrix.h()

Returns the h height of the bounding box of the data matrix.

You can also get this value via index [3].

#### datamatrix.payload()

Returns a string of payloads for the data matrix. Example: String.

You can also get this value via index [4].

#### datamatrix.rotation()

Returns the curl (float) of the data matrix in radians.

You can also get this value via index [5].

#### datamatrix.rows()

Returns the number of rows (int) of the data matrix.

You can also get this value via index [6].

#### datamatrix.columns()

Returns the number of columns (int) of the data matrix.

You can also get this value via index [7].

#### datamatrix.capacity()

Returns the number of characters this data matrix can hold.

You can also get this value via index [8].

#### datamatrix.padding()

Returns the number of unused characters in this data matrix.

You can also get this value via index [9].

## BarCode Class – Barcode Object

The barcode object is returned by image.find_barcodes.

## Constructor

Class image.barcode

Call the image.find_barcodes() function to create this object.

### Methods

#### barcode.corners()

Returns a list of four tuples (x, y) consisting of the four corners of the object. The four corners are usually returned in a clockwise order starting from the upper left corner.

#### barcode.rect()

Returns a rectangular tuple (x, y, w, h) for other image methods such as image.draw_rectangle of the bounding box of the data matrix.

#### barcode.x()

Returns the x coordinate (int) of the bounding box of the barcode.

You can also get this value via index [0].

#### barcode.y()

Returns the y coordinate (int) of the bounding box of the barcode.

You can also get this value via index [1].

#### barcode.w()

Returns the w width (int) of the bounding box of the barcode.

You can also get this value via index [2].

#### barcode.h()

Returns the h height (int) of the bounding box of the barcode.

You can also get this value via index [3].

#### barcode.payload()

Returns a string of the payload of the barcode. Example: Quantity.

You can also get this value via index [4].

#### barcode.type()

Returns the enumerated type (int) of the barcode.

You can also get this value via index [5].

image.EAN2
image.EAN5
image.EAN8
image.UPCE
image.ISBN10
image.UPCA
image.EAN13
image.ISBN13
image.I25
image.DATABAR
image.DATABAR_EXP
image.CODABAR
image.CODE39
image.PDF417 - Enable in the future (e.g. is not working properly now).
image.CODE93
image.CODE128

#### barcode.rotation()

Returns the curl (floating point) of the barcode in radians.

You can also get this value via index [6].

#### barcode.quality()

Returns the number of times the barcode was detected in the image (int).

When scanning a barcode, each new scan line can decode the same barcode. Each time this process is performed, the value of the barcode will increase.

You can also get this value via index [7].

## Displacement class – displacement object

The displacement object is returned by image.find_displacement.

### Constructor

Class image.displacement

Call the image.find_displacement() function to create this object.

### Methods

#### displacement.x_translation()

Returns an x ​​translation pixel between two images. This is a precise subpixel, so it is a floating point number.

You can also get this value via index [0].

#### displacement.y_translation()

Returns the y translation pixel between the two images. This is a precise subpixel, so it is a floating point number.

You can also get this value via index [1].

#### displacement.rotation()

Returns the z translation pixel between the two images. This is a precise subpixel, so it is a floating point number.

You can also get this value via index [2].

#### displacement.scale()

Returns the arc of rotation between two images.

You can also get this value via index [3].

#### displacement.response()

Returns the quality of the displacement match between the two images. Range 0-1. A displacement object with a response of less than 0.1 may be noise.

You can also get this value via index [4].

## Kptmatch class – feature point object

The feature point object is returned by `image.match_descriptor`.

### Constructor

Class image.kptmatch

Please call the image.match_descriptor() function to create this object.

### Methods

#### kptmatch.rect()

Returns a rectangular tuple (x, y, w, h) for other image methods such as image.draw_rectangle of the bounding box of the feature point.

#### kptmatch.cx()

Returns the center x position (int) of the feature point.

You can also get this value via index [0].

#### kptmatch.cy()

Returns the center y position (int) of the feature point.

You can also get this value via index [1].

#### kptmatch.x()

Returns the x coordinate (int) of the bounding box of the feature point.

You can also get this value via index [2].

#### kptmatch.y()

Returns the y coordinate (int) of the bounding box of the feature point.

You can also get this value via index [3].

#### kptmatch.w()

Returns the w width (int) of the feature point bounding box.

You can also get this value via index [4].

#### kptmatch.h()

Returns the h height (int) of the feature point bounding box.

You can also get this value via index [5].

#### kptmatch.count()

Returns the number of matching feature points (int).

You can also get this value via index [6].

#### kptmatch.theta()

Returns the curl of the estimated feature point (int).

You can also get this value via index [7].

#### kptmatch.match()

Returns a list of (x,y) tuples that match the key.

You can also get this value via index [8].

## ImageWriterClass – ImageWriter Object

The ImageWriter object allows you to quickly write uncompressed images to disk.

### Constructor

Class image.ImageWriter(path)

Create an ImageWriter object and you can write uncompressed images to disk in a simple file format for OpenMV Cams. The uncompressed image can then be re-read using ImageReader.

### Methods

#### imagewriter.size()

Returns the size of the file being written.

#### imagewriter.add_frame(img)

Write an image to disk. Because the image is not compressed, it performs quickly but takes up a lot of disk space.

#### imagewriter.close()

Close the image stream file. You must close the file or the file will be corrupted.

## ImageReader Class – ImageReader Object

The ImageReader object allows you to quickly read uncompressed images from disk.

### Constructor

Class image.ImageReader(path)

Create an ImageReader object to play back the image data written by the ImageWriter object. Frames played back by the ImageWriter object are played back under the same FPS as when writing to disk.

### Methods

#### imagereader.size()

Returns the size of the file being read.

Imagereader.next_frame([copy_to_fb=True, loop=True])
Returns an image object from a file written by ImageWriter. If copy_to_fb is True, the image object will be loaded directly into the frame buffer. Otherwise the image object will be placed in the heap. Note: Unless the image is small, the heap may not have enough space to store the image object. If loop is True, playback will resume after the last image of the stream has been read. Otherwise, this method will return None after all frames have been read.

Note: imagereader.next_frame attempts to limit the playback speed by pausing playback after reading the frame to match the speed of the frame recording. Otherwise, this method will play all images at a speed of 200+FPS.

#### imagereader.close()

Close the file being read. You need to do this to prevent the imagereader object from being damaged. However, since it is a read-only file, the file will not be damaged when it is not closed.

## ImageClass - Image Object

Image objects are the basic objects of machine vision operations.

### Constructor

Class image.Image(path[, copy_to_fb=False])

Create a new image object from the file in path.

Support image files in bmp/pgm/ppm/jpg/jpeg format.

If copy_to_fb is True, the image will be loaded directly into the framebuffer and you can load large images. If False, the image will be loaded into the MicroPython heap, which is much smaller than the frame buffer.

In OpenMV Cam M4, if copy_to_fb is False, you should try to keep the image size below 8KB. If True, the image can be up to 160KB.
In OpenMV Cam M7, if copy_to_fb is False, you should try to keep the image size below 16KB. If True, the image can be up to 320KB.
The image supports the "[]" notation. Let image[index] = 8/16-bit value to assign image pixels or image[index] and get an image pixel. If it is a grayscale image of 16-bit RGB565 value for RGB image, this pixel is 8 Bit.

For JPEG images, "[]" gives you access to JPEG image patches in the form of compressed section arrays. Since JPEG images are in the form of compressed byte streams, reading and writing of data sets is opaque.

The image also supports read buffer operations. You can use the image as a section array object and enter the image into all types of MicroPython functions. If you want to transfer an image, you can pass it to the UART / SPI / I2C write function for automatic transfer.

### Methods

#### image.width()

Returns the width of the image in pixels.

#### image.height()

Returns the height of the image in pixels.

#### image.format()

Returns sensor.GRAYSCALE for grayscale images, sensor.RGB565 for RGB images, and sensor.JPEG for JPEG images.

#### image.size()

Returns the image size in bytes.

#### image.get_pixel(x, y[, rgbtuple])

Grayscale: Returns the grayscale pixel value at the (x, y) position.

RGB565l: Returns the RGB888 pixel tuple (r, g, b) at the (x, y) position.

Bayer image: Returns the pixel value at the (x, y) position.

Compressed images are not supported.

> image.get_pixel() and `image.set_pixel()` are the only ways you can manipulate Bayer mode images. The Bayer pattern image is a text image. For even rows, where the pixels in the image are R/G/R/G/ and so on. For odd lines, where the pixels in the image are G/B/G/B/etc. Each pixel is 8 bits.

#### image.set_pixel(x, y, pixel)
Grayscale: Set the pixel at the (x, y) position to the grayscale value pixel .

RGB image: Set the pixel at the (x, y) position to RGB888 tuple (r, g, b) pixel .

Compressed images are not supported.

> image.get_pixel() and `image.set_pixel()` are the only ways you can manipulate Bayer mode images. The Bayer pattern image is a text image. For even rows, where the pixels in the image are R/G/R/G/ and so on. For odd lines, where the pixels in the image are G/B/G/B/etc. Each pixel is 8 bits.

#### image.mean_pool(x_div, y_div)

Find the average of the x_div * y_div squares in the image and return a modified image consisting of the average of each square.

This method allows you to quickly reduce the image on the original image.

Compressed images and bayer images are not supported.

#### image.mean_pooled(x_div, y_div)

Find the average of the x_div * y_div squares in the image and return a new image consisting of the average of each square.

This method allows you to create a reduced copy of the image.

Compressed images and bayer images are not supported.

#### image.midpoint_pool(x_div, y_div[, bias=0.5])

Finds the midpoint value of the x_div * y_div square in the image and returns a modified image consisting of the midpoint values ​​of each square.

Bias is 0.0 to return the minimum value for each region, and ``bias`` is 1.0 to return the maximum value for each region.

This method allows you to quickly reduce the image on the original image.

Compressed images and bayer images are not supported.

#### image.midpoint_pooled(x_div, y_div[, bias=0.5])

Finds the midpoint value of the x_div * y_div square in the image and returns a new image consisting of the midpoint values ​​of each square.

Bias is 0.0 to return the minimum value for each region, and ``bias`` is 1.0 to return the maximum value for each region.

This method allows you to create a reduced copy of the image.

Compressed images and bayer images are not supported.

#### image.to_grayscale([copy=False])

Convert the image to a grayscale image. This method also modifies the base image pixels and changes the image size in bytes, so it can only be done on grayscale images or RGB565 images. Otherwise copy must be True to create a new modified image on the heap.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.to_rgb565([copy=False])

Convert an image to a color image. This method also modifies the base image pixels and changes the image size in bytes, so it can only be done on RGB565 images. Otherwise copy must be True to create a new modified image on the heap.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.to_rainbow([copy=False])

Convert an image to a rainbow image. This method also modifies the base image pixels and changes the image size in bytes, so it can only be done on RGB565 images. Otherwise copy must be True to create a new modified image on the heap.

A rainbow image is a color image that has a unique color value for each 8-bit mask grayscale illumination value in the image. For example, it provides a heat map color for a thermal image.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.compress([quality=50])

JPEG properly compresses the image. Using this method to use a higher quality compression ratio is at the expense of destroying the original image compared to the compressed save heap space.

Quality is the compression quality (0-100) (int).

#### image.compress_for_ide([quality=50])

JPEG properly compresses the image. Using this method to use a higher quality compression ratio is at the expense of destroying the original image compared to the compressed save heap space.

This method compresses the image and then formats the JPEG data by encoding each 6 bits into a byte between 128 and 191 and converts it to OpenMV IDE for display. This step is done to prevent JPEG data from being mistaken for other text data in the byte stream.

You need to use this method to format the image data for display in the terminal window created by Open Terminal in OpenMV IDE.

Quality is the compression quality (0-100) (int).

#### image.compressed([quality=50])

Returns a JPEG compressed image - the original image is unprocessed. However, this method requires a large allocation of heap space, so image compression quality and image resolution must be low.

Quality is the compression quality (0-100) (int).

#### image.compressed_for_ide([quality=50])

Returns a JPEG compressed image - the original image is unprocessed. However, this method requires a large allocation of heap space, so image compression quality and image resolution must be low.

This method compresses the image and then formats the JPEG data by encoding each 6 bits into a byte between 128 and 191 and converts it to OpenMV IDE for display. This step is done to prevent JPEG data from being mistaken for other text data in the byte stream.

You need to use this method to format the image data for display in the terminal window created by Open Terminal in OpenMV IDE.

Quality is the compression quality (0-100) (int).

#### image.copy([roi[, copy_to_fb=False]])

Create a copy of the image object.

Roi is a region of interest (x, y, w, h) of a rectangle to be copied. If not specified, the ROI copies the image rectangle of the entire image. But this does not apply to JPEG images.

Remember that the image copy is stored in the MicroPython heap instead of the frame buffer. Again, you need to keep the image copy size below 8KB (OpenMV) or below 16KB (OpenMV Cam M7). If you want to use a copy operation to use all the heap space, this function will get an exception. An oversized image can easily trigger an exception.

If copy_to_fb is True, this method replaces the framebuffer with an image. The frame buffer has much larger space than the heap and can accommodate large images.

#### image.save(path[, roi[, quality=50]])

Save a copy of the image to the file system in path.

Support image files in bmp/pgm/ppm/jpg/jpeg format. Note: You cannot save a compressed image in jpeg format to an uncompressed format.

Roi is a region of interest (x, y, w, h) of a rectangle to be copied. If not specified, the ROI copies the image rectangle of the entire image. But this does not apply to JPEG images.

Quality refers to the JPEG compression quality that saves the image to JPEG format when the image has not been compressed.

#### image.clear()

Set all pixels in the image to zero (very fast).

Returns an image object so that you can use the . notation to call another method.

Compressed images are not supported.

#### image.draw_line(x0, y0, x1, y1[, color[, thickness=1]])

Draw a line from (x0, y0) to (x1, y1) on the image. You can pass x0, y0, x1, y1 individually or to a tuple (x0, y0, x1, y1).

Color is the RGB888 tuple for grayscale or RGB565 images. The default is white. However, you can also pass the base pixel value of the grayscale image (0-255) or the byte of the RGB565 image to invert the RGB565 value.

Thickness The thickness of the control line.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.draw_rectangle(x, y, w, h[, color[, thickness=1[, fill=False]]])

Draw a rectangle on the image. You can pass x, y, w, h alone or as a tuple (x, y, w, h).

Color is the RGB888 tuple for grayscale or RGB565 images. The default is white. However, you can also pass the base pixel value of the grayscale image (0-255) or the byte of the RGB565 image to invert the RGB565 value.

Thickness The thickness of the control line.

Set fill to True to fill the rectangle.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.draw_circle(x, y, radius[, color[, thickness=1[, fill=False]]])

Draw a circle on the image. You can pass x, y, radius alone or as a tuple (x, y, radius).

Color is the RGB888 tuple for grayscale or RGB565 images. The default is white. However, you can also pass the base pixel value of the grayscale image (0-255) or the byte of the RGB565 image to invert the RGB565 value.

Thickness The thickness of the control line.

Set fill to True to fill the circle.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.draw_string(x, y, text[, color[, scale=1[, x_spacing=0[, y_spacing=0[, mono_space=True]]]])

Draw 8x10 text from the (x, y) position in the image. You can pass x, y alone or as a tuple (x, y).

Text is a string that is written to the image. The \n, \r, and \r\n terminators move the cursor to the next line.

Color is the RGB888 tuple for grayscale or RGB565 images. The default is white. However, you can also pass the base pixel value of the grayscale image (0-255) or the byte of the RGB565 image to invert the RGB565 value.

You can increase the scale to increase the size of the text on the image.

   Only integer values ​​(for example, 1/2/3 / etc).

X_spacing allows you to add (if positive) or subtract (if negative) x pixels between characters to set the character spacing.

Y_spacing allows you to add (if positive) or subtract (if negative) y pixels between characters to set the line spacing.

Mono_space defaults to True, which forces the text spacing to be fixed. For big text, this looks bad. Setting False to get a non-fixed width of character spacing looks much better.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.draw_cross(x, y[, color[, size=5[, thickness=1]]])

Draw a cross on the image. You can pass x, y alone or as a tuple (x, y).

Color is the RGB888 tuple for grayscale or RGB565 images. The default is white. However, you can also pass the base pixel value of the grayscale image (0-255) or the byte of the RGB565 image to invert the RGB565 value.

Size Controls the extension of the crosshair.

Thickness Controls the pixel thickness of the edge.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.draw_arrow(x0, y0, x1, y1[, color[, thickness=1]])

Draw an arrow from (x0, y0) to (x1, y1) on the image. You can pass x0, y0, x1, y1 individually or to a tuple (x0, y0, x1, y1).

Color is the RGB888 tuple for grayscale or RGB565 images. The default is white. However, you can also pass the base pixel value of the grayscale image (0-255) or the byte of the RGB565 image to invert the RGB565 value.

Thickness The thickness of the control line.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.draw_image(image, x, y[, x_scale=1.0[, y_scale=1.0[, mask=None]]])

Draw an image whose top left corner starts at position x, y. You can pass x, y alone or pass it to a tuple (x, y).

X_scale Controls the extent to which the image is scaled in the x direction (floating point).

Y_scale Controls the extent to which the image is scaled in the y direction (floating point).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. You can use the mask mask to draw.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.draw_keypoints(keypoints[, color[, size=10[, thickness=1[, fill=False]]]])

Draw a point of a feature point object on the image.

Color is the RGB888 tuple for grayscale or RGB565 images. The default is white. However, you can also pass the base pixel value of the grayscale image (0-255) or the byte of the RGB565 image to invert the RGB565 value.

Size Controls the size of feature points.

Thickness The thickness of the control line.

Set fill to True to fill the feature points.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.flood_fill(x, y[, seed_threshold=0.05[, floating_threshold=0.05[, color[, invert=False[, clear_background=False[, mask=None]]]]])

The area where the image is filled starting from position x, y. You can pass x, y alone or pass it to a tuple (x, y).

Seed_threshold Controls the difference between the pixels in the fill area and the original start pixel.

Floating_threshold Controls the difference between pixels in the fill area and any adjacent pixels.

Color is the RGB888 tuple for grayscale or RGB565 images. The default is white. However, you can also pass the base pixel value of the grayscale image (0-255) or the byte of the RGB565 image to invert the RGB565 value.

Pass invert to True to repopulate everything outside the flood_fill connection area.

Pass clear_background as True and zero the remaining flood_fill pixels that are not recolored.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask will be evaluated at flood_fill.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.binary(thresholds[, invert=False[, zero=False[, mask=None]]])

Sets all pixels in the image to black or white depending on whether the pixel is within the threshold in the threshold list thresholds.

The thresholds must be a list of tuples. [(lo, hi), (lo, hi), ..., (lo, hi)] Define the range of colors you want to track. For grayscale images, each tuple needs to contain two values ​​- the minimum gray value and the maximum gray value. Only pixel regions that fall between these thresholds are considered. For RGB565 images, each tuple needs to have six values ​​(l_lo, l_hi, a_lo, a_hi, b_lo, b_hi) - the minimum and maximum values ​​for the LAB L, A and B channels, respectively. For ease of use, this feature will automatically fix the minimum and maximum values ​​of the exchange. Also, if the tuple is greater than six values, the remaining values ​​are ignored. Conversely, if the tuple is too short, the remaining thresholds are assumed to be in the maximum range.

annotation

To get the threshold of the tracked object, simply select (click and drag) the tracking object in the IDE framebuffer. The histogram will be updated accordingly to the area. Then just write down the color distribution in the starting and falling positions in each histogram channel. These will be the low and high values ​​of thresholds. Since the difference between the upper and lower quartiles is small, the threshold is manually determined.

You can also determine the color threshold by going to Tools -> Machine Vision -> Threshold Editor in the OpenMV IDE and dragging the slider from the GUI window.

Invert Reverses the threshold operation, where pixels are matched outside of the known color range, not within the known color range.

Set zero to True to make the threshold pixel zero and leave the pixels that are not in the threshold list unchanged.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.invert()

Change binary image 0 (black) to 1 (white) and 1 (white) to 0 (black) to flip all pixel values ​​in the binary image very quickly.

Returns an image object so that you can use the . notation to call another method.

Compressed images and Bayer images are not supported.

#### image.b_and(image[, mask=None])

Use another image to perform a logical AND operation with this image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.b_nand(image[, mask=None])

Use another image to perform a logical AND operation with this image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.b_or(image[, mask=None])

Use another image to perform a logical OR operation with this image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.b_nor(image[, mask=None])

Use another image to perform a logical OR operation with this image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.b_xor(image[, mask=None])

Use another image to perform an exclusive OR operation with this image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.b_xnor(image[, mask=None])

Use another image to logically AND the same image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.erode(size[, threshold[, mask=None]])

Remove pixels from the edges of the split area.

This method is implemented by convolving the kernel of ((size*2)+1)x((size*2)+1) pixels on the convolution image. If the sum of the adjacent pixel sets is smaller than threshold, then the center pixel of the kernel is performed. Return to zero.

If the threshold is not set, this method functions as the standard corrosion method. If the threshold is set, you can specify a specific pixel to be etched. For example, set a threshold of 2 around pixels that are less than 2 pixels.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.dilate(size[, threshold[, mask=None]])

Add pixels to the edges of the split area.

This method is implemented by convolving the kernel of ((size*2)+1)x((size*2)+1) pixels on the convolution image. If the sum of the adjacent pixel sets is greater than threshold, the central pixel of the kernel is performed. Settings.

If the threshold is not set, this method functions as the standard corrosion method. If the threshold is set, you can specify a specific pixel to be etched. For example, set a threshold of 2 around pixels that are less than 2 pixels.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.open(size[, threshold[, mask=None]])

The image is subjected to corrosion and expansion in sequence. See image.erode() and image.dilate() for more information.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.close(size[, threshold[, mask=None]])

The image is expanded and etched in sequence. See image.erode() and image.dilate() for more information.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.top_hat(size[, threshold[, mask=None]])

Returns the difference between the original image and the image after executing the image.open() function.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Compressed images and bayer images are not supported.

#### image.black_hat(size[, threshold[, mask=None]])

Returns the difference between the original image and the image after executing the image.close() function.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Compressed images and bayer images are not supported.

#### image.negate()

Flip (number invert) all pixel values ​​in the image very quickly. The value of the pixel value of each color channel is converted. Example: (255 - pixel).

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.replace(image[, hmirror=False[, vflip=False[, mask=None]]])

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Set hmirror to True to replace the image with a horizontal mirror.

Set vflip to True to replace the image with a vertical flip.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.add(image[, mask=None])

Add two images to each other in pixels.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.sub(image[, reverse=False[, mask=None]])

The two images are subtracted from each other by pixel.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Set reverse to True to reverse the subtraction from this_image-image to image-this_image .

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.mul(image[, invert=False[, mask=None]])

Multiply two images by pixel by pixel.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Setting invert to True changes the multiplication operation from a*b to 1/((1/a)*(1/b)). In particular, this brightens the image rather than darkening the image (eg, multiply and burn operations).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.div(image[, invert=False[, mask=None]])

Divide this image by another image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Set invert to True to change the division direction from a/b to b/a.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.min(image[, mask=None])

At the pixel level, replace the pixels in this image with the smallest pixel value between this image and another image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV4.

#### image.max(image[, mask=None])

Replace pixels in this image at the pixel level with the maximum pixel value between this image and another image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.difference(image[, mask=None])

The two images are taken to each other in absolute values. Example: For each color channel, replace each pixel with ABS (this.pixel-image.pixel).

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Mask is another image used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.blend(image[, alpha=128[, mask=None]])

Combine another image image with this image.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Alpha controls how much other images are to be blended into this image. alpha should be an integer value between 0 and 256. A value close to zero will mix more images into this image, and close to 256 is the opposite.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.histeq([adaptive=False[, clip_limit=-1[, mask=None]]])

Run a histogram equalization algorithm on the image. Histogram equalization normalizes contrast and brightness in the image.

If adaptive passes to True, the adaptive histogram equalization method will be run on the image, which is usually better than the non-adaptive histogram qualification, but runs longer.

Clip_limit provides a way to limit the contrast of adaptive histogram equalization. A good histogram equalization contrast limited image can be generated using a small value (eg 10).

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.mean(size, [threshold=False, [offset=0, [invert=False, [mask=None]]]]])

Standard mean blur filtering using a box filter.

Size is the size of the kernel. Take 1 (3x3 core), 2 (5x5 core) or higher.

If you want to adaptively set the threshold on the output of the filter, you can pass the threshold=True parameter to initiate adaptive threshold processing of the image, which is based on the brightness of the ambient pixel (the brightness of the pixels around the kernel function). Set to 1 or 0. A negative offset value sets more pixels to 1, while a positive value only sets the strongest contrast to 1. Set invert to invert the result output of the binary image.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

Median(size, percentile=0.5, threshold=False, offset=0, invert=False, mask])
Run median filtering on the image. Median filtering is the best filtering to smooth the surface, but at very slow speeds, while preserving the edges.

Size is the size of the kernel. Take 1 (3x3 core), 2 (5x5 core) or higher.

Percentile Controls the percentile of the values ​​used in the kernel. By default, each pixel is replaced with an adjacent fiftyth percentile (center). You can set this value to 0 when using minimum filtering, to 0.25 for lower quartile filtering, to 0.75 for upper quartile filtering, and to 1 for maximum filtering.

If you want to adaptively set the threshold on the output of the filter, you can pass the threshold=True parameter to initiate adaptive threshold processing of the image, which is based on the brightness of the ambient pixel (the brightness of the pixels around the kernel function). Set to 1 or 0. A negative offset value sets more pixels to 1, while a positive value only sets the strongest contrast to 1. Set invert to invert the result output of the binary image.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.mode(size[, threshold=False, offset=0, invert=False, mask])

Run a majority filter on the image, replacing each pixel with the pattern of adjacent pixels. This method works well on grayscale images. However, due to the non-linear nature of this operation, many artifacts are produced on the edges of the RGB image.

Size is the size of the kernel. Take 1 (3x3 core), 2 (5x5 core).

If you want to adaptively set the threshold on the output of the filter, you can pass the threshold=True parameter to initiate adaptive threshold processing of the image, which is based on the brightness of the ambient pixel (the brightness of the pixels around the kernel function). Set to 1 or 0. A negative offset value sets more pixels to 1, while a positive value only sets the strongest contrast to 1. Set invert to invert the result output of the binary image.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.midpoint(size[, bias=0.5, threshold=False, offset=0, invert=False, mask])

Run midpoint filtering on the image. This filter finds the midpoint of the neighborhood of each pixel in the image ((max-min)/2).

Size is the size of the kernel. Take 1 (3x3 core), 2 (5x5 core) or higher.

Bias Controls the minimum/maximum degree of image blending. 0 is only for minimum filtering and 1 is for maximum filtering only. You can minimize/maximize filtering of images with bias.

If you want to adaptively set the threshold on the output of the filter, you can pass the threshold=True parameter to initiate adaptive threshold processing of the image, which is based on the brightness of the ambient pixel (the brightness of the pixels around the kernel function). Set to 1 or 0. A negative offset value sets more pixels to 1, while a positive value only sets the strongest contrast to 1. Set invert to invert the result output of the binary image.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.morph(size, kernel, mul=Auto, add=0)

The image is convolved through the filter kernel. This allows you to perform a general convolution on the image.

Size Controls the size of the kernel to ((size*2)+1)x((size*2)+1) pixels.

Kernel The kernel used to convolve the image, either as a tuple or as a list of values ​​[-128:127].

Mul is the number used to multiply the result of the convolutional pixel. If not set, it defaults to a value that will prevent scaling in the convolution output.

Add is the number used to add the convolution result to each pixel.

Mul can be used for global contrast adjustment, and add can be used for global brightness adjustment.

If you want to adaptively set the threshold on the output of the filter, you can pass the threshold=True parameter to initiate adaptive threshold processing of the image, which is based on the brightness of the ambient pixel (the brightness of the pixels around the kernel function). Set to 1 or 0. A negative offset value sets more pixels to 1, while a positive value only sets the strongest contrast to 1. Set invert to invert the result output of the binary image.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### image.gaussian(size[, unsharp=False[, mul[, add=0[, threshold=False[, offset=0[, invert=False[, mask=None]]]]]])

The image is convolved by a smooth Gaussian kernel.

Size is the size of the kernel. Take 1 (3x3 core), 2 (5x5 core) or higher.

If unsharp is set to True, this method does not perform Gaussian filtering only, but performs an unsharp masking operation to improve the image sharpness of the edges.

Mul is the number used to multiply the result of the convolutional pixel. If not set, it defaults to a value that will prevent scaling in the convolution output.

Add is the number used to add the convolution result to each pixel.

Mul can be used for global contrast adjustment, and add can be used for global brightness adjustment.

If you want to adaptively set the threshold on the output of the filter, you can pass the threshold=True parameter to initiate adaptive threshold processing of the image, which is based on the brightness of the ambient pixel (the brightness of the pixels around the kernel function). Set to 1 or 0. A negative offset value sets more pixels to 1, while a positive value only sets the strongest contrast to 1. Set invert to invert the result output of the binary image.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.laplacian(size[, sharpen=False[, mul[, add=0[, threshold=False[, offset=0[, invert=False[, mask=None]]]]]])

The image is convolved by edge detection of the Laplacian kernel.

Size is the size of the kernel. Take 1 (3x3 core), 2 (5x5 core) or higher.

If sharpen is set to True, this method will instead sharpen the image instead of just outputting edge-detected images that have not been thresholded. Increase the kernel size and increase the image clarity.

Mul is the number used to multiply the result of the convolutional pixel. If not set, it defaults to a value that will prevent scaling in the convolution output.

Add is the number used to add the convolution result to each pixel.

Mul can be used for global contrast adjustment, and add can be used for global brightness adjustment.

If you want to adaptively set the threshold on the output of the filter, you can pass the threshold=True parameter to initiate adaptive threshold processing of the image, which is based on the brightness of the ambient pixel (the brightness of the pixels around the kernel function). Set to 1 or 0. A negative offset value sets more pixels to 1, while a positive value only sets the strongest contrast to 1. Set invert to invert the result output of the binary image.

Mask is another image used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.bilateral(size[, color_sigma=0.1[, space_sigma=1[, threshold=False[, offset=0[, invert=False[, mask=None]]]]])

The image is convolved by a bilateral filter. A bilateral filter smoothes the image while maintaining the edges in the image.

Size is the size of the kernel. Take 1 (3x3 core), 2 (5x5 core) or higher.

The color_sigma control uses a bilateral filter to match the proximity of the color. Increasing this value increases the color blur.

Space_sigma controls the degree to which pixels are blurred in space. Increasing this value increases pixel blur.

If you want to adaptively set the threshold on the output of the filter, you can pass the threshold=True parameter to initiate adaptive threshold processing of the image, which is based on the brightness of the ambient pixel (the brightness of the pixels around the kernel function). Set to 1 or 0. A negative offset value sets more pixels to 1, while a positive value only sets the strongest contrast to 1. Set invert to invert the result output of the binary image.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.cartoon(size[, seed_threshold=0.05[, floating_threshold=0.05[, mask=None]]])

Roam the image and fill all the pixel areas in the image using the flood-fills algorithm. This effectively removes texture from the image by flattening the colors in all areas of the image. For best results, the image should have a lot of contrast so that the areas don't penetrate too easily.

Seed_threshold Controls the difference between the pixels in the fill area and the original start pixel.

Floating_threshold Controls the difference between pixels in the fill area and any adjacent pixels.

Mask is another image that is used as a pixel-level mask for drawing operations. The mask should be an image with only black or white pixels and should be the same size as the image you are drawing. Only the pixels set in the mask are modified.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.remove_shadows([image])

Remove the shadow from the image.

If the current image does not have a "shadowless" version, this method will attempt to remove the shadow from the image, but there is no true unshaded image basis. This algorithm is suitable for removing shadows in a flat, uniform background. Note that this method takes many seconds to run and is only suitable for removing shadows in real time, dynamically generating an unshadowed version of the image. Future versions of the algorithm will work for more environments, but equally slow.

If the current image has a "shadowless" version, this method will remove all shadows in the image using the "true source" background unshadowed image to filter out the shadows. Non-shaded pixels are not filtered out, so you can add new objects that didn't exist before to the scene, and any non-shaded pixels in those objects will be displayed.

Returns an image object so that you can use the . notation to call another method.

Only RGB565 images are supported.

This method is not available on OpenMV Cam M4.

#### image.chrominvar()

Remove the lighting effect from the image, leaving only the color gradient. Faster than image.illuminvar() but affected by shadows.

Returns an image object so that you can use the . notation to call another method.

Only RGB565 images are supported.

This method is not available on OpenMV Cam M4.

#### image.illuminvar()

Remove the lighting effect from the image, leaving only the color gradient. Slower than image.chrominvar() but not affected by shadows.

Returns an image object so that you can use the . notation to call another method.

Only RGB565 images are supported.

This method is not available on OpenMV Cam M4.

#### image.linpolar([reverse=False])

The image is re-projected from Cartesian coordinates to linear polar coordinates.

Set reverse = True to re-project in the opposite direction.

Linear polar re-projection converts image rotation to x translation.

Compressed images are not supported.

This method is not available on OpenMV Cam M4.

#### image.logpolar([reverse=False])

The image is re-projected from Cartesian coordinates to log polar coordinates.

Set reverse = True to re-project in the opposite direction.

Log-polar polar re-projection converts the rotation of the image to x translation and zoom to y translation.

Compressed images are not supported.

This method is not available on OpenMV Cam M4.

#### image.lens_corr([strength=1.8[, zoom=1.0]])

Perform lens distortion correction to remove the fisheye effect caused by the lens.

Strength is a floating point number that determines how much the fisheye effect is applied to the image. By default, try the value of 1.8 first, then adjust this value to make the image show the best results.

Zoom is the value at which the image is scaled. The default is 1.0.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

#### img.rotation_corr([x_rotation=0.0[, y_rotation=0.0[, z_rotation=0.0[, x_translation=0.0[, y_translation=0.0[, zoom=1.0]]]]])

The perspective problem in the image is corrected by performing a 3D rotation of the frame buffer.

X_rotation is the degree to which the image is rotated in the frame buffer around the x-axis (this causes the image to rotate up and down).

Y_rotation is the degree of rotation of the image around the y-axis in the frame buffer (ie, the image is rotated left and right).

Z_rotation is the degree by which the image is rotated in the frame buffer around the z-axis (ie, the image is rotated to the appropriate position).

X_translation is the number of units that move the image to the left or right after rotation. Because this transformation is applied in 3D space, the unit is not a pixel...

Y_translation is the number of units that move the image up or down after rotation. Because this transformation is applied in 3D space, the unit is not a pixel...

Zoom is the amount that is scaled by the image. By default 1.0.

Returns an image object so that you can use the . notation to call another method.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.get_similarity(image)

Returns a "similarity" object describing the two images using the SSIM algorithm to compare the similarities of 8x8 pixel patches between the two images.

Image can be an image object, the path to an uncompressed image file (bmp/pgm/ppm), or a scalar value. If a scalar value, the value can be an RGB888 tuple or a base pixel value (eg, an 8-bit grayscale of a grayscale image or a byte-inverted RGB565 value of an RGB image).

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.get_histogram([thresholds[, invert=False[, roi[, bins[, l_bins[, a_bins[, b_bins]]]]]])

Normalize histogram operations on all color channels of roi and return histogram objects. Please refer to the histogram object for more information. You can also call this method using image.get_hist or image.histogram . If you pass the thresholds list, the histogram information will only be calculated from the pixels in the threshold list.

The thresholds must be a list of tuples. [(lo, hi), (lo, hi), ..., (lo, hi)] Define the range of colors you want to track. For grayscale images, each tuple needs to contain two values ​​- the minimum gray value and the maximum gray value. Only pixel regions that fall between these thresholds are considered. For RGB565 images, each tuple needs to have six values ​​(l_lo, l_hi, a_lo, a_hi, b_lo, b_hi) - the minimum and maximum values ​​for the LAB L, A and B channels, respectively. For ease of use, this feature will automatically fix the minimum and maximum values ​​of the exchange. Also, if the tuple is greater than six values, the remaining values ​​are ignored. Conversely, if the tuple is too short, the remaining thresholds are assumed to be in the maximum range.

annotation

To get the threshold of the tracked object, simply select (click and drag) the tracking object in the IDE framebuffer. The histogram will be updated accordingly to the area. Then just write down the color distribution in the starting and falling positions in each histogram channel. These will be the low and high values ​​of thresholds. Since the difference between the upper and lower quartiles is small, the threshold is manually determined.

You can also determine the color threshold by going to Tools -> Machine Vision -> Threshold Editor in the OpenMV IDE and dragging the slider from the GUI window.

Invert Reverses the threshold operation, where pixels are matched outside of the known color range, not within the known color range.

Unless you need to use color statistics for advanced operations, simply use the `image.get_statistics()` method instead of this method to see the pixel areas in the image.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Bins and other bins are the number of bins used for the histogram channel. For grayscale images, use bins, for RGB565 images, use each of the other channels. The bin count for each channel must be greater than 2. In addition, it makes no sense to set the bin count to a number greater than the unique pixel value of each channel. By default, the histogram will have the maximum number of bins per channel.

Compressed images and bayer images are not supported.

#### image.get_statistics([thresholds[, invert=False[, roi[, bins[, l_bins[, a_bins[, b_bins]]]]]])

Calculates the average, median, value, standard deviation, minimum, maximum, lower quartile, and upper quartile for each color channel in roi and returns a data object. See the statistics object for more information. You can also call this method using image.get_stats or image.statistics . If you pass the thresholds list, the histogram information will only be calculated from the pixels in the threshold list.

The thresholds must be a list of tuples. [(lo, hi), (lo, hi), ..., (lo, hi)] Define the range of colors you want to track. For grayscale images, each tuple needs to contain two values ​​- the minimum gray value and the maximum gray value. Only pixel regions that fall between these thresholds are considered. For RGB565 images, each tuple needs to have six values ​​(l_lo, l_hi, a_lo, a_hi, b_lo, b_hi) - the minimum and maximum values ​​for the LAB L, A and B channels, respectively. For ease of use, this feature will automatically fix the minimum and maximum values ​​of the exchange. Also, if the tuple is greater than six values, the remaining values ​​are ignored. Conversely, if the tuple is too short, the remaining thresholds are assumed to be in the maximum range.

annotation

To get the threshold of the tracked object, simply select (click and drag) the tracking object in the IDE framebuffer. The histogram will be updated accordingly to the area. Then just write down the color distribution in the starting and falling positions in each histogram channel. These will be the low and high values ​​of thresholds. Since the difference between the upper and lower quartiles is small, the threshold is manually determined.

You can also determine the color threshold by going to Tools -> Machine Vision -> Threshold Editor in the OpenMV IDE and dragging the slider from the GUI window.

Invert Reverses the threshold operation, where pixels are matched outside of the known color range, not within the known color range.

You can use this method when you need to get a pixel area information in an image. For example, if you want to use the frame difference method to detect motion, you need to use this method to determine the change in the color channel of the image, which triggers the motion detection threshold.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Bins and other bins are the number of bins used for the histogram channel. For grayscale images, use bins, for RGB565 images, use each of the other channels. The bin count for each channel must be greater than 2. In addition, it makes no sense to set the bin count to a number greater than the unique pixel value of each channel. By default, the histogram will have the maximum number of bins per channel.

Compressed images and bayer images are not supported.

#### image.get_regression(thresholds[, invert=False[, roi[, x_stride=2[, y_stride=1[, area_threshold=10[, pixels_threshold=10[, robust=False]]]]]])

Perform linear regression calculations on all threshold pixels of the image. This calculation is done by least squares, which is usually faster, but does not handle any outliers. If robust is True, the Theil index will be used. The Theil index calculates the median of all slopes between all threshold pixels in the image. If you set too many pixels after the threshold transition, even on an 80x60 image, this N^2 operation may lower your FPS below 5. However, as long as the number of pixels to be set after the threshold conversion is small, linear regression is effective even when the threshold pixel exceeding 30% is an abnormal value.

This method returns an image.line object. How to easily use straight line objects, see the following blog post: https://openmv.io/blogs/news/linear-regression-line-following

The thresholds must be a list of tuples. [(lo, hi), (lo, hi), ..., (lo, hi)] Define the range of colors you want to track. For grayscale images, each tuple needs to contain two values ​​- the minimum gray value and the maximum gray value. Only pixel regions that fall between these thresholds are considered. For RGB565 images, each tuple needs to have six values ​​(l_lo, l_hi, a_lo, a_hi, b_lo, b_hi) - the minimum and maximum values ​​for the LAB L, A and B channels, respectively. For ease of use, this feature will automatically fix the minimum and maximum values ​​of the exchange. Also, if the tuple is greater than six values, the remaining values ​​are ignored. Conversely, if the tuple is too short, the remaining thresholds are assumed to be in the maximum range.

> To get the threshold of the tracked object, simply select (click and drag) the tracked object in the IDE framebuffer. The histogram will be updated accordingly to the area. Then just write down the color distribution in the starting and falling positions in each histogram channel. These will be the low and high values ​​of thresholds. Since the difference between the upper and lower quartiles is small, the threshold is manually determined.

You can also determine the color threshold by going to Tools -> Machine Vision -> Threshold Editor in the OpenMV IDE and dragging the slider from the GUI window.

Invert Reverses the threshold operation, where pixels are matched outside of the known color range, not within the known color range.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

X_stride is the number of x pixels to skip when calling a function.

Y_stride is the number of y pixels to skip when calling a function.

Returns None if the bounding box area after the regression is smaller than area_threshold .

Returns None if the number of pixels after regression is less than pixel_threshold .

Compressed images and bayer images are not supported.

#### image.find_blobs(thresholds[, invert=False[, roi[, x_stride=2[, y_stride=1[, area_threshold=10[, pixels_threshold=10[, merge=False[, margin=0[, threshold_cb =None[, merge_cb=None]]]]]]]]]]])

Finds all the patches in the image and returns a list of patch objects that include each patch. Please observe the image.blob object for more information.

The thresholds must be a list of tuples. [(lo, hi), (lo, hi), ..., (lo, hi)] Define the range of colors you want to track. For grayscale images, each tuple needs to contain two values ​​- the minimum gray value and the maximum gray value. Only pixel regions that fall between these thresholds are considered. For RGB565 images, each tuple needs to have six values ​​(l_lo, l_hi, a_lo, a_hi, b_lo, b_hi) - the minimum and maximum values ​​for the LAB L, A and B channels, respectively. For ease of use, this feature will automatically fix the minimum and maximum values ​​of the exchange. Also, if the tuple is greater than six values, the remaining values ​​are ignored. Conversely, if the tuple is too short, the remaining thresholds are assumed to be in the maximum range.

annotation

To get the threshold of the tracked object, simply select (click and drag) the tracking object in the IDE framebuffer. The histogram will be updated accordingly to the area. Then just write down the color distribution in the starting and falling positions in each histogram channel. These will be the low and high values ​​of thresholds. Since the difference between the upper and lower quartiles is small, the threshold is manually determined.

You can also determine the color threshold by going to Tools -> Machine Vision -> Threshold Editor in the OpenMV IDE and dragging the slider from the GUI window.

Invert Reverses the threshold operation, where pixels are matched outside of the known color range, not within the known color range.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

X_stride is the number of x pixels that need to be skipped when looking for a patch. Once the color block is found, the line fill algorithm will be precise pixels. If the color block is known to be large, increase x_stride to increase the speed at which the color block is found.

Y_stride is the number of y pixels that need to be skipped when looking for a patch. Once the color block is found, the line fill algorithm will be precise pixels. If the color block is known to be large, increase y_stride to increase the speed at which the patch is found.

If the bounding box area of ​​a patch is smaller than area_threshold, it will be filtered out.

If the number of pixels in a patch is smaller than pixel_threshold, it will be filtered out.

Merge If True, merges all the patches that have not been filtered. The border rectangles of these patches overlap each other. Margin can be used in the intersection test to increase or decrease the size of the patch boundary rectangle. For example, patches with edges of 1 and border rectangles of 1 will be merged.

Merging patches allows color code tracking to be achieved. Each patch object has a code value code , which is a bit vector. For example, if you enter two color thresholds in image.find_blobs, the first threshold code is 1 and the second code is 2 (the third code is 4, the fourth code is 8, and so on). Merged patches use logical OR operations on all code so you know the color that produced them. This allows you to track two colors, and if you get a patch object in two colors, it might be a color code.

If you use a strict color range and cannot fully track all the pixels of the target object, you may need to merge the patches.

Finally, if you want to merge the patches, but don't want the two different threshold colors to be merged, just call image.find_blobs twice, and the different threshold patches will not be merged.

The threshold_cb can be set to a function that calls each color block after threshold filtering to filter it out of the list of patches to be merged. The callback function will receive a parameter: the patch object to be filtered. The callback function then returns True to preserve the color block or return False to filter the color block.

Merge_cb can be set to function to call two patches to be merged to disable or permit the merge. The callback function will receive two arguments - two patch objects that will be merged. The callback function must return True to merge the color blocks, or return False to prevent color block merging.

Compressed images and bayer images are not supported.

#### image.find_lines([roi[, x_stride=2[, y_stride=1[, threshold=1000[, theta_margin=25[, rho_margin=25]]]]])

Use the Hough transform to find all the lines in the image. Returns a list of image.line objects.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

X_stride is the number of x pixels that need to be skipped during the Hough transform. If the line is known to be large, increase x_stride.

Y_stride is the number of y pixels that need to be skipped during the Hough transform. If the line is known to be large, increase y_stride.

Threshold Controls the line that is detected from the Hough transform. Only return lines that are greater than or equal to threshold. The correct threshold value for the application depends on the image. Note: The magnitude of a line is the sum of the size of all Sobel filter pixels that make up the line.

Theta_margin controls the merging of the lines being monitored. The part of the line angle of theta_margin is merged with the part of the line p value of rho_margin.

Rho_margin controls the merging of the lines being monitored. The part of the line angle of theta_margin is merged with the part of the line p value of rho_margin.

The method performs a Hough transform by running a Sobel filter on the image and using the amplitude and gradient response of the filter. No pre-processing of the image is required. However, cleaning up the image filter results in more stable results.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.find_line_segments([roi[, merge_distance=0[, max_theta_difference=15]]])

Use Hough transform to find line segments in the image. Returns a list of image.line objects.

Roi is a region of interest (x, y, w, h) of a rectangle to be copied. If not specified, the ROI is the image rectangle. The operating range is limited to pixels in the roi area.

Merge_distance specifies the maximum number of pixels between two segments that can be separated from each other without being merged.

Max_theta_difference is the maximum angle difference between the two line segments that merge_distancede will merge above.

This method uses the LSD library (also used by OpenCV) to find line segments in the image. This is a bit slow, but very accurate, the line segments won't jump.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.find_circles([roi[, x_stride=2[, y_stride=1[, threshold=2000[, x_margin=10[, y_margin=10[, r_margin=10]]]]]])

Use the Hough transform to find a circle in the image. Returns a list of image.circle objects (see above).

Roi is a region of interest (x, y, w, h) of a rectangle to be copied. If not specified, the ROI is the image rectangle. The operating range is limited to pixels in the roi area.

X_stride is the number of x pixels that need to be skipped during the Hough transform. If the circle is known to be large, increase x_stride.

Y_stride is the number of y pixels that need to be skipped during the Hough transform. If the circle is known to be large, increase y_stride.

Threshold Controls the circle detected from the Hough transform. Only returns a circle greater than or equal to threshold. The correct threshold value for the application depends on the image. Note: The magnitude of a circle is the sum of the size of all Sobel filter pixels that make up the circle.

X_margin controls the merge of the detected circles. The round pixels are partially merged for x_margin , y_margin , and r_margin .

Y_margin controls the merge of the detected circles. The round pixels are partially merged for x_margin , y_margin , and r_margin .

R_margin Controls the merge of the detected circles. The round pixels are partially merged for x_margin , y_margin , and r_margin .

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.find_rects([roi=Auto, threshold=10000])

Use the same quad detection algorithm used to find AprilTAg to find rectangles in the image. Ideal for rectangles that contrast sharply with the background. AprilTag's quad detection can handle arbitrary scaling/rotating/cutting rectangles. Returns a list of image.rect objects.

Roi is a region of interest (x, y, w, h) of a rectangle to be copied. If not specified, the ROI is the image rectangle. The operating range is limited to pixels in the roi area.

The border size (by sliding the Sobel operator over all pixels on the edge of the rectangle and adding the value) is smaller than the rectangle of the threshold and is filtered from the return list. The correct value for threshold depends on your application/scenario.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.find_qrcodes([roi])

Find all the QR codes in roi and return a list of image.qrcode objects. Please refer to the image.qrcode object for more information.

In order for this method to work successfully, the QR code on the image needs to be flat. By using the sensor.set_windowing function to zoom in at the center of the lens, the image.lens_corr function to dissipate the barrel distortion of the lens, or by replacing a lens with a narrow field of view, you get a flatter QR code that is unaffected by lens distortion. Some machine vision lenses do not cause barrel distortion, but they are much more expensive than the standard lenses offered by OpenMV, which is an undistorted lens.

Roi is a region of interest (x, y, w, h) of a rectangle to be copied. If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

Image.find_apriltags([roi[, families=image.TAG36H11[, fx[, fy[, cx[, cy]]]]])
Find all AprilTags in roi and return a list of image.apriltag objects. Please refer to the image.apriltag object for more information.

Compared to QR codes, AprilTags can be detected in longer distances, poorer light, and more distorted image environments. AprilTags can handle all kinds of image distortion problems, and the QR code does not. That is, AprilTags can only encode the digital ID as its payload.

AprilTags can also be used for localization. Each image.apriltag object returns its three-dimensional position information and rotation angle from the camera. The position information is determined by fx, fy, cx, and cy, which are the focal length and center point of the image in the X and Y directions, respectively.

> Create AprilTags using the Tag Generator tool built into OpenMV IDE. The tag generator creates a printable 8.5"x11" AprilTags.

Roi is a region of interest (x, y, w, h) of a rectangle to be copied. If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

The family is the bit mask of the tag family to be decoded. Is a logical or:

image.TAG16H5
image.TAG25H7
image.TAG25H9
image.TAG36H10
image.TAG36H11
image.ARTOOLKIT
The default setting is the best image.TAG36H11 tag family. Note: every time a tag family is enabled, the speed of find_apriltags will be slightly slower.

Fx is the focal length of the camera's x-direction in pixels. The value of the standard OpenMV Cam is (2.8 / 3.984) * 656, which is obtained by dividing the focal length value of the millimeter by the length of the photosensitive element in the X direction and multiplying by the number of pixels of the photosensitive element in the X direction (for the OV7725 photosensitive element) In terms of).

Fy is the focal length of the camera in the y direction in pixels. The value of the standard OpenMV Cam is (2.8 / 2.952) * 488, which is obtained by dividing the focal length value of the millimeter meter by the length of the photosensitive element in the Y direction, and multiplying by the number of pixels of the photosensitive element in the Y direction (for the OV7725 photosensitive element) In terms of).

Cx is the center of the image, image.width()/2 , not roi.w()/2 .

Cy is the center of the image, image.height()/2, not roi.h()/2 .

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

Image.find_datamatrices([roi[, effort=200]])
Finds all the data matrices in roi and returns a list of image.datamatrix objects. Please refer to the image.datamatrix object for more information.

In order for this method to work successfully, the rectangular code on the image needs to be flat. By using the sensor.set_windowing function to zoom in on the center of the lens, the image.lens_corr function to dissipate the barrel distortion of the lens, or by replacing a lens with a narrow field of view, you get a flatter rectangular code that is unaffected by lens distortion. Some machine vision lenses do not cause barrel distortion, but they are much more expensive than the standard lenses offered by OpenMV, which is an undistorted lens.

Roi is a region of interest (x, y, w, h) of a rectangle to be copied. If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

The effort controls the time used to find the rectangular code match. The default value of 200 should apply to all use cases. However, you may also increase the detection at the expense of the frame rate or increase the frame rate at the expense of detection. Note: If the effort is set below about 160, you will not be able to perform any tests; instead, you can set it to any high value you want, but if the setting is higher than 240, the detection rate will not continue to increase.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

#### image.find_barcodes([roi])

Find all the 1D barcodes in roi and return a list of image.barcode objects. Please refer to the image.barcode object for more information.

For best results, use a long 640, wide 40/80/160 window. The lower the degree of verticality, the faster the speed. Since the barcode is a linear one-dimensional image, it is only necessary to have a higher resolution in one direction and a lower resolution in the other direction. Note: This function performs horizontal and vertical scanning, so you can use a window with a width of 40/80/160 and a length of 480. Finally, be sure to adjust the lens so that the bar code is positioned where the focal length produces the sharpest image. Fuzzy barcodes cannot be decoded.

This function supports all 1D barcodes:

image.EAN2
image.EAN5
image.EAN8
image.UPCE
image.ISBN10
image.UPCA
image.EAN13
image.ISBN13
image.I25
image.DATABAR (RSS-14)
image.DATABAR_EXP (RSS-Expanded)
image.CODABAR
image.CODE39
image.PDF417
image.CODE93
image.CODE128
Roi is a region of interest (x, y, w, h) of a rectangle to be copied. If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Compressed images and bayer images are not supported.

This method is not available on OpenMV Cam M4.

Image.find_displacement(template[, roi[, template_roi[, logpolar=False]]])
Find the transform offset for this image from the template. This method can be used to make light flow. This method returns an image.displacement object containing the results of the displacement calculation using phase correlation.

Roi is a rectangular area (x, y, w, h) that needs to be processed. If not specified, it is equal to the image rectangle.

Template_roi is the rectangular area (x, y, w, h) that needs to be processed. If not specified, it is equal to the image rectangle.

Roi and template roi must have the same w/h, but x/y can be anywhere in the image. You can slide a smaller rois on a larger image to get a smoother image of the light flow.

Image.find_displacement usually calculates the x/y translation between two images. However, if you set logpolar = True , it will find a change in rotation and scaling between the two images. The same image.displacement object results in two possible feedbacks.

Compressed images and bayer images are not supported.

annotation

Use this method on images with a uniform length and width (for example, ``sensor.B64X64``).

This method is not available on OpenMV Cam M4.

#### image.find_number(roi)

A LENET-6 CNN (Convolutional Neural Network) trained on the MINST data set is run to detect numbers in the 28x28 ROI located anywhere on the image. Returns a tuple containing integers and floating point numbers representing the detected number (0-9) and the confidence of the detection (0-1).

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Only grayscale images are supported.

annotation

This method is experimental. This method may be removed if you run any CNN that Caffe trains on your PC in the future. This function has been removed by the latest 3.0.0 firmware.

This method is not available on OpenMV Cam M4.

#### image.classify_object(roi)

Run CIFAR-10 CNN on the ROI of the image to detect aircraft, cars, birds, cats, deer, dogs, frogs, horses, boats and trucks. This method automatically scales the image internally to 32x32 to feed to the CNN.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Only RGB565 images are supported.

annotation

This method is experimental. This method may be removed if you run any CNN that Caffe trains on your PC in the future.

This method is not available on OpenMV Cam M4.

Image.find_template(template, threshold[, roi[, step=2[, search=image.SEARCH_EX]]])
Try to find the location of the first template match in the image using the Normalized Cross Correlation (NCC) algorithm. Returns the bounding box tuple (x, y, w, h) of the matching position, otherwise returns None.

Template is a small image object that matches this image object. Note: Both images must be grayscale.

Threshold is a floating point number (0.0-1.0), where a smaller value increases the detection rate while increasing the false positive rate. Conversely, a higher value reduces the detection rate while reducing the false positive rate.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Step is the number of pixels that need to be skipped when looking up the template. Skip pixels can greatly increase the speed at which the algorithm runs. This method is only applicable to the algorithm in SERACH_EX mode.

Search can be used for image.SEARCH_DS or image.SEARCH_EX. image.SEARCH_DS The algorithm used for searching templates is faster than image.SEARCH_EX, but if the template is around the edges of the image, it may not be searched successfully. image.SEARCH_EX performs a more detailed search of the image, but it runs much faster than image.SEARCH_DS .

Only grayscale images are supported.

#### image.find_features(cascade[, threshold=0.5[, scale=1.5[, roi]]])

This method searches for images of all regions that match Haar Cascade and returns a list of bounding box rectangle tuples (x, y, w, h) for these features. If no features are found, a blank list is returned.

Cascade is a Haar Cascade object. See image.HaarCascade() for more information.

Threshold is a floating point number (0.0-1.0), where a smaller value increases the detection rate while increasing the false positive rate. Conversely, a higher value reduces the detection rate while reducing the false positive rate.

Scale is a floating point number that must be greater than 1.0. A higher scale factor runs faster, but its image matching is poorer. The ideal value is between 1.35 and 1.5.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Only grayscale images are supported.

#### image.find_eye(roi)

Find the pupil in the region of interest (x, y, w, h) around the eye. Returns a tuple containing the position of the pupil (x, y) in the image. If no pupil is found, it returns (0,0).

Before using this function, you first need to search for someone's face using image.find_features() and Haar operator frontalface. Then use image.find_features and Haar operator find_eye to search for the eye on the face. Finally, this method is called on each eye ROI returned after calling the image.find_features function to get the coordinates of the pupil.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Only grayscale images are supported.

#### image.find_lbp(roi)

The LBP (local binary mode) key points are extracted from the ROI tuple (x, y, w, h). You can use the image.match_descriptor function to compare two sets of key points to get the matching distance.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Only grayscale images are supported.

#### image.find_keypoints([roi[, threshold=20[, normalized=False[, scale_factor=1.5[, max_keypoints=100[, corner_detector=image.CORNER_AGAST]]]]])

The ORB key points are extracted from the ROI tuple (x, y, w, h). You can use the image.match_descriptor function to compare two sets of key points to get the matching area. If no key is found, return None.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Threshold is a number that controls the number of extractions (values ​​0-255). For the default AGAST corner detector, this value should be around 20. For the FAST corner detector, this value is approximately 60-80. The lower the threshold, the more corner points you extract.

Normalized is a boolean value. If True, close the extraction keypoint at multiple resolutions. If you don't care about handling extensions and want the algorithm to run faster, set it to True.

Scale_factor is a floating point number that must be greater than 1.0. A higher scale factor runs faster, but its image matching is poorer. The ideal value is between 1.35 and 1.5.

Max_keypoints is the maximum number of key points a keypoint object can hold. If the key point object is too large and causes memory problems, lower the value.

Corner_detector is the corner detector algorithm used to extract key points from an image. Can be image.CORNER_FAST or image.CORNER_AGAST . The FAST corner detector runs faster, but with less accuracy.

Only grayscale images are supported.

#### image.find_edges(edge_type[, threshold])

Turn the image into black and white and leave only the edges as white pixels.

image.EDGE_SIMPLE - Simple threshold high-pass filtering algorithm
image.EDGE_CANNY - Canny edge detection algorithm
Threshold is a binary tuple containing a low threshold and a high threshold. You can control the edge quality by adjusting this value.

The default is (100, 200).

Only grayscale images are supported.

Find_hog([roi[, size=8]])
The pixels in the ROI are replaced with HOG (Directed Gradient Histogram) lines.

Roi is a rectangular tuple of interest regions (x, y, w, h). If not specified, the ROI is the image rectangle of the entire image. The operating range is limited to pixels in the roi area.

Only grayscale images are supported.

This method is not available on OpenMV Cam M4.

## Constant

### image.SEARCH_EX

Detailed template matching search.

### image.SEARCH_DS

Faster template matching search.

### image.EDGE_CANNY

Edge detection is performed on the image using the Canny edge detection algorithm.

### image.EDGE_SIMPLE

Edge detection is performed on the image using a threshold high-pass filtering algorithm.

### image.CORNER_FAST

High-speed low-accuracy corner detection algorithm for ORB key points

### image.CORNER_AGAST

Low speed high accuracy algorithm for ORB key points.

### image.TAG16H5

Bitmask enumeration for the TAG1H5 tag group. Used in AprilTags.

### image.TAG25H7

Bitmask enumeration for the TAG25H7 tag group. Used in AprilTags.

### image.TAG25H9

Bitmask enumeration for the TAG25H9 tag group. Used in AprilTags.

### image.TAG36H10

Bitmask enumeration for the TAG36H10 tag group. Used in AprilTags.

### image.TAG36H11

Bitmask enumeration for the TAG36H11 tag group. Used in AprilTags.

### image.ARTOOLKIT

The bit mask enumeration of the ARTOOLKIT tag group. Used in AprilTags.

### image.EAN2

EAN2 barcode type enumeration.

### image.EAN5

EAN5 barcode type enumeration.

### image.EAN8

EAN8 barcode type enumeration.

### image.UPCE

UPCE barcode type enumeration.

### image.ISBN10

ISBN10 barcode type enumeration.

### image.UPCA

UPCA barcode type enumeration.

### image.EAN13

EAN13 barcode type enumeration.

### image.ISBN13

ISBN13 barcode type enumeration.

### image.I25

I25 barcode type enumeration.

### image.DATABAR

DATABAR barcode type enumeration.

### image.DATABAR_EXP

DATABAR_EXP barcode type enumeration.

### image.CODABAR

CODABAR barcode type enumeration.

### image.CODE39

CODE39 barcode type enumeration.

### image.PDF417

PDF417 barcode type enumeration (currently not working).

### image.CODE93

CODE93 barcode type enumeration.

### image.CODE128

CODE128 barcode type enumeration.












