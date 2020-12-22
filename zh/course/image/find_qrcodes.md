MaixPy 查找二维码
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

* 从图片中获取所有二维码对象(image.qrcode)

```python
res = img.find_qrcodes()
```

* 操作二维码对象

例如打印信息

```python
print(res[0].payload())
```

## 示例

获取示例和详细 API 介绍请查看[API-Image](../../api_reference/machine_vision/image/image.md).
