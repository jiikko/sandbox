ラズベリーパイをファイルサーバとして使う
# fsをmountするまで

## デバイスをUSBとかに刺す
認識されているのを確認んする
* dmesg
  * カーネルのログみれる
* lsusb
  * usbに繋がっているデバイスを見れる
```
pi@ras2:~ $ lsusb
Bus 001 Device 005: ID 1bcf:0c31 Sunplus Innovation Technology Inc. SPIF30x Serial-ATA bridge
Bus 001 Device 004: ID 0411:01a2 BUFFALO INC. (formerly MelCo., Inc.) WLI-UC-GNM Wireless LAN Adapter [Ralink RT8070]
Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp. SMSC9512/9514 Fast Ethernet Adapter
Bus 001 Device 002: ID 0424:9514 Standard Microsystems Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```
* lsblk
```shell
pi@ras2:~ $ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    0 931.5G  0 disk
└─sda15       8:15   0 931.5G  0 part /mnt/hdd
mmcblk0     179:0    0  28.8G  0 disk
├─mmcblk0p1 179:1    0 125.7M  0 part
├─mmcblk0p2 179:2    0     1K  0 part
├─mmcblk0p5 179:5    0    32M  0 part /media/pi/SETTINGS
├─mmcblk0p6 179:6    0    63M  0 part /boot
└─mmcblk0p7 179:7    0  28.6G  0 part /
```

## update partion
既存パーティションを削除するとかする. 対話的に進める. mとか押していたらいい
```
sudo fdisk /dev/sda
```
* 利用可能なfs一覧
  * `cat /proc/filesystems`

## create fs
上記で作成したパーティションにファイルシステムを作成する
```
sudo mkfs -t ext4 /dev/sda15
```

作成したfsを確認できるコマンド
* tune2fs -l /dev/sda15

### mountする前にすること
* 予約領域を0にする
  * ファイルサーバにするだけでbootする予定がないので
  * http://ubuntu.hatenablog.jp/entry/20110325/1301058554
  * ./shell/fs/tune2fs/reserve_block.md
* boot時にfsckが走らないようにする
  * たまに起動するとbootに時間かかって嫌に気持ちになるので
  * ./shell/fs/tune2fs/reserve_block.md

## mount
```shell
sudo mount /dev/sda15 /mnt/hdd
```
mountされているかは、df -h とかで確認する

## boot時にmountする
### UUIDを調べる
tune2fsコマンドで調べれる
```shell
pi@ras2:~ $ sudo tune2fs -l /dev/sda15 | grep UUID
Filesystem UUID:          27842e09-229f-46a5-b9ff-ba11b3f956b8
```
fstabを以下のようにする
```
pi@ras2:~ $ cat /etc/fstab
# /dev/sda15
UUID=27842e09-229f-46a5-b9ff-ba11b3f956b8 /mnt/hdd ext4 defaults 0 0
```

再起動した時にdf とかでmaountされていればOK.

## その他
* mountしている一覧
  * mount
* アンマウントする
  * umount device_file mount_point
