# 予約領域を0にする
```shell
pi@ras2:~ $ sudo tune2fs -l /dev/sda15 | grep Reserved
Reserved block count:     12209519
Reserved GDT blocks:      965
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
```
```shell
pi@ras2:~ $ sudo tune2fs -m 0 /dev/sda15
tune2fs 1.42.12 (29-Aug-2014)
Setting reserved blocks percentage to 0% (0 blocks)
```
```shell
pi@ras2:~ $ sudo tune2fs -l /dev/sda15 | grep Reserved
Reserved block count:     0
Reserved GDT blocks:      965
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
```
