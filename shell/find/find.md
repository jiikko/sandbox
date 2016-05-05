## 自分のホームディレクトリいかに他人のファイルが置かれていないか
```
find ~$(whoami)/. ! -user $(whoami)
```
## 異常なフィアル名(null文字の入っている)ファイル名を検索する
bsd版find にはprint0オプションがない
```
ruby -ne 'File.write("./\n\nabc\nabc", nil)'
File.write("../\n\n\nabc", nil)
```
みたいな感じで作成する

### 調べる
```shell
$ ls
???abc    ??abc?abc find.md

$ ls -la
-rw-r--r--   1 koji  staff      0  5  4 17:32 ???abc
-rw-r--r--   1 koji  staff      0  5  4 17:12 ??abc?abc
drwxr-xr-x   6 koji  staff    204  5  4 17:41 .
drwxr-xr-x  23 koji  staff    782  5  4 17:32 ..
-rw-r--r--   1 koji  staff    450  5  4 17:41 find.md
```

* odコマンドで何が表示されているのか確認する

```shell
find * -print0 | od -ab
0000000   nl  nl  nl   a   b   c nul  nl  nl   a   b   c  nl   a   b   c
          012 012 012 141 142 143 000 012 012 141 142 143 012 141 142 143
0000020  nul   f   i   n   d   .   m   d nul
          000 146 151 156 144 056 155 144 000
0000031
```

* odコマンドじゃわかりにくいにでtrで置換する
* print0オプション はnullを表示する

```shell
find * -print0 | tr ' \n\0' 'SN\n'

NNNabc
NNabcNabc
find.md
```


## xargs を使ったコマンドの実行
```
grep $WARD /dev/null $(find ............)
```
* 引数が殻だった場合に標準出力を待ち続けるのでnullだった場合を想定して引数に/dev/nullを指定する
* zsh: argument list too long: grep ってなったらxargsでわける
  * `getconf ARG_MAX`
```
find /usr/include -type -f | xargs grep POSTIX_OPEN_MAX /dev/null
```
