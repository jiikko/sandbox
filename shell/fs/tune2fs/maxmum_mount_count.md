# boot時にfsckが走らないようにする
* Linuxの起動シーケンスには、ファイルシステムの整合性チェックするフェーズがある
  * 整合性チェックには、簡易版と完全版があってもちろん完全版を実行するととても時間がかかる
  * デフォルトの設定だと、「一定回数マウントした後」「一定期間経過したら」のあとに完全版FS整合性チェックが走る
* マウントしているデバイスが完全版を実行するかの確認方法は、下記コマンドで確認できる
```shell
$ tune2fs -l /dev/sda1
koji@debian:~% sudo /sbin/tune2fs -l /dev/sda1
tune2fs 1.42.12 (29-Aug-2014)
Filesystem volume name:   <none>
Last mounted on:          /
Filesystem UUID:          18181e88-678a-408c-8aa8-85fdd954fdfe
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery extent flex_bg sparse_super large_file huge_file uninit_bg dir_nlink extra_isize
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              6717440
Block count:              26859008
Reserved block count:     1342950
Free blocks:              25196738
Free inodes:              6566942
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      1017
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:       Mon Jan 19 23:51:32 2015
Last mount time:          Tue Mar 29 22:58:39 2016
Last write time:          Tue Mar 29 22:58:38 2016
Mount count:              27
Maximum mount count:      -1
Last checked:             Mon Jan 19 23:51:32 2015
Check interval:           0 (<none>)
Lifetime writes:          36 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      59033a0e-6069-435f-af2b-f947a40ecd91
Journal backup:           inode blocks
```
```
Maximum mount count:      -1
Check interval:           0 (<none>)
```
* で確認できる
  * -1と0はdisableの意
  * ちなみにintavalの単位は日でした。

ということがsoftware designの2014年6月に書いてました。
