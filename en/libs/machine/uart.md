machine.UART
==============

The uart module is mainly used to drive the asynchronous serial port on the development board, and uart can be freely configured. The k210 has a total of 3 uarts, and each uart can perform free pin mapping.

## Construction

### Pin mapping

Before using uart, we need to use fm to map and manage the chip pins. As shown below, set PIN10 as the sending pin of uart2 and PIN11 as the receiving pin of uart2
```
fm.register (board_info.PIN10, fm.fpioa.UART2_TX)
fm.register (board_info.PIN11, fm.fpioa.UART2_RX)
```

### Constructor

```
uart = machine.UART (uart, baudrate, bits, parity, stop, timeout, read_buf_len)
```

Create a new UART object with the specified parameters

#### parameters

* `uart` UART number, use the specified UART, you can complete it by pressing the machine key with` machine.UART.`
* `baudrate`: UART baud rate
* `bits`: UART data width, support` 5/6/7 / 8` (the default serial port used by REPL (UARTHS) only supports 8-bit mode), default `8`
* `parity`: parity bit, supports` None`, `machine.UART.PARITY_ODD`,` machine.UART.PARITY_EVEN` (the default serial port used by REPL (UARTHS) only supports None), default `None`
* `stop`: stop bit, supports` 1`, `1.5`,` 2`, default `1`
* `timeout`: serial port receive timeout
* `read_buf_len`: Serial port receive buffer. The serial port receives data through interrupt. If the buffer is full, it will automatically stop receiving data.

#### return value

* UART object

## Method

### init

Used to initialize uart, usually already initialized when constructing the object, here is used to re-initialize uart
```
uart.init (baudrate, bits, parity, stop, timeout, read_buf_len)
```
#### parameters

Same constructor but does not require the first UART number

#### return value

no

### read

Used to read data from serial buffer

```
uart.read (num)
```
#### parameters

* `num`: the number of bytes read, generally fill the buffer size, if the number of data in the buffer is not as large as` num`, then only the remaining data in the buffer will be returned

#### return value

* `bytes` data

### readline

Yihang for reading serial buffered data

```
uart.readline (num)
```
* `num`: number of rows read

#### return value

* `bytes` data


### write

Used to send data using the serial port

```
uart.write (buf)
```
#### parameters

* `buf`: need to send data

#### return value

* Amount of data written

### deinit

Unregister UART hardware and free up resources

```
UART.deinit ()
```

#### parameters

no

#### return value

no

### repl_uart ()

Get serial object for REPL

#### return value

Serial object for REPL, default initialization bit `115200 8 N 1`


## Examples


### Routine 1

Before running mileage, please make sure `PIN15` is connected to` PIN10` and `PIN17` is connected to` PIN9`

After running the program, you can see the print information of `baudrate: 115200 bits: 8 parity: 0 stop: 0 --- check Successfully` in the terminal

```python
from fpioa_manager import fm
from machine import UART
fm.register (board_info.PIN15, fm.fpioa.UART1_TX)
fm.register (board_info.PIN17, fm.fpioa.UART1_RX)
fm.register (board_info.PIN9, fm.fpioa.UART2_TX)
fm.register (board_info.PIN10, fm.fpioa.UART2_RX)
uart_A = UART (UART.UART1, 115200, 8, None, 1, timeout = 1000, read_buf_len = 4096)
uart_B = UART (UART.UART2, 115200, 8, None, 1, timeout = 1000, read_buf_len = 4096)
write_str = 'hello world'
for i in range(20):
    uart_A.write(write_str)
    if uart_A.any():
        read_data = uart_B.read()
        if read_data:
            read_str = read_data.decode('utf-8')
            print("string = ", read_str)
            if read_str == write_str:
                print("baudrate:115200 bits:8 parity:0 stop:0 ---check Successfully")
uart_A.deinit ()
uart_B.deinit ()
del uart_A
del uart_B
```

### Routine 2

AT module serial port

```python
fm.register (board_info.WIFI_RX, fm.fpioa.UART2_TX)
fm.register (board_info.WIFI_TX, fm.fpioa.UART2_RX)
uart = machine.UART (machine.UART.UART2, 115200, timeout = 1000, read_buf_len = 4096)
```
### Routine 3

Modify the baud rate of the REPL serial port

```python
from machine import UART
repl = UART.repl_uart ()
repl.init (1500000, 8, None, 1, read_buf_len = 2048)
```

### Routine 3

Modify the REPL serial port

```python
from machine import UART

fm.register (board_info.PIN15, fm.fpioa.UART1_TX)
fm.register (board_info.PIN17, fm.fpioa.UART1_RX)
uart = machine.UART (UART.UART1, 115200)
UART.set_repl_uart (uart)
```
