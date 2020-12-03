SP_BT 的使用
====

<img src="../../../assets/hardware/module_spmod/sp_bt.png"/>

SP_BT 是一款蓝牙串口透传模块， 具备超低功率特性和高可靠性， 使用 AT 指令进行控制， 蓝牙版本为 BLE 5.0(兼容BLE4.0, BLE4.2), 默认串口波特率为9600.

## 使用方法

透传即透明传输, 我们发给该模块的消息会被该模块原封不动的以蓝牙消息的方式发送出去, 使用者只需将其当作串口使用即可.

### 初始化串口

初始化串口(注意串口波特率需要与 SP_BT 的波特率相同), 可以使用 AT 指令更改模块波特率.

### 检查模块

可通过发送 AT 指令查询模块信息来检查是否可以正常控制模块.

程序如下:

```python
# send at order
uart.write("AT+NAME\r\n")
# gee res
read_data = uart.read()
read_str = read_data.decode('utf-8')
count = read_str.count("NAME")
if count != 0:
    print("get name success")
```

主要分为两步:

* 发送 "AT+NAME\r\n".

* 接收应答并判断应答是否有效.

**需要注意的是 AT 指令需加上结束符 '\r\n'**

### 开始蓝牙通信

* 此时模块处于未连接状态(ACT 闪烁, STA 常灭).
  
* 打开蓝牙助手并连接, 模块变为已连接(ACT 常亮, STA 常亮).
  
* 连接后蓝牙调试助手会显示的服务如下图:
  
  <img src="../../../assets/hardware/module_spmod/sp_bt_screenshot.png" alt="bt_server"/>
  
  上图中可以看到有一个 UUID 为 ffe0 的服务有两个特征, 打开透传(ffe1)的 Write, Notify, 便可以开始发送/接收数据.

[示例代码](https://github.com/sipeed/MaixPy_scripts/blob/master/hardware/demo_sp_bt.py)
