开机自启动脚本
=======

系统会在 `/flash` 或者 `/sd`(优先) 目录创建 `boot.py` 文件和`main.py`， 开机会自动先执行`boot.py`，然后执行`main.py`（如果检测到SD卡则执行SD卡里的）， 编辑这两个脚本的内容即可实现开机自启，尽量不要在`boot.py`里面写死循环程序

另外，也可以在 Micro SD 卡中放 `cover.boot.py` 或者 `cover.main.py` 来覆盖 `/flash/boot.py` 或 `/flash/main.py`，在开机的时候系统会自动检测并复制，复制完成后会自动重启并运行新的启动文件

注意:
    * Micro SD 卡应该被格式化为 FAT(FAT32) 文件系统
    * FAT 格式的储存卡会被挂载到 `/sd`, 内部 Flash 中的 SPIFFS 会被挂载到`/flash`

