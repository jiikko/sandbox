# Array
* ksh, bash, zshで使える
* 多次元配列不可
## 初期化
### 方法1
```shell
 # zshだと0を設定できず
names[0]=yamada
names[1]=hai
$ echo ${names[0]}
yamada
$ echo ${names[1]}
hai
```
### 方法2
```
$ aaaa=(yamada hai0)
$ echo ${names[0]}
yamada
$ echo ${names[1]}
hai
```

## すべての要素を出力
```
echo ${aaaa[*]}
yamada hai0
 $ echo ${aaaa[@]}
yamada hai0
```

### 空白を含む文字列を要素に格納している場合はダブルクォートで囲む
(引数処理するときに`"$*"`と書くのと同じです)
```
aaaa=(yamada hai0)
aaaa[99]=' '
```
```
$ echo ${#aaaa[@]}
3
```
```
$ for x in ${aaaa[@]}; do echo i; done
i
i
$ for x in "${aaaa[@]}"; do echo i; done
i
i
i
```

## 要素数を出力
```
echo ${#aaaa[@]}
```
