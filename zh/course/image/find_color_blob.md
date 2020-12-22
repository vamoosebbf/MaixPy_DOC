MaixPy 查找色块
=======

## 使用方法

* 相关方法位于 image 模块中, 导入 image

```python
import image
```

* 从摄像头获取图片

```python
img=sensor.snapshot()
```

* 从图片中获取所有色块对象(image.blob), 传入的颜色阈值参数按照 LAB 格式(l_lo，l_hi，a_lo，a_hi，b_lo，b_hi)

```python
green_threshold   = (0,   80,  -70,   -10,   -0,   30)
blobs = img.find_blobs([green_threshold])
```

* 操作色块对象
  
根据自己的需求操作色块对象, 例如将色块对象在图像中用矩形框标识出来

```python
tmp=img.draw_rectangle(b[0:4])
```

## 示例:

获取示例和详细 API 介绍请查看[API-Image](../../api_reference/machine_vision/image/image.md).
