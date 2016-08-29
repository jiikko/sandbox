# Shell

## よく使いそう
* du -s /tmp
* df
  * -h
    * humanaze
  * -l
    * ローカルのfsのみ
  * -i
    * inodeが枯渇してないかみたいな感じに見れる
* mktemp
  * 12文字以上推奨
  * -d でディレクトリ作成する
* od -ab
  * print 不可視文字
* 演算
  * ((h = h + 1)
  * : $((h = h + 1)
    * 算術演算
    * 戻り値を返す
  * let "h = h + 1"
* stty
  * 端末デバイスの状態を操作する
  * emacsキーバインドが効かなくなった時にここの値が変わっているかも

## 条件判定
### [[ ]]
* 後の展開やワイルドカード展開をしない。そのため、クォート展開の手間をかなり省く
* 最近のbashやkshで実装されている
* [ はtestと同じ
* testオプション/演算子は共通

```shell
 $ [[ README.m* = README.md ]]; echo $?
1
```
```
 $ [ README.m* = README.md ]; echo $?
0
```

## ブレース展開
* Cシェルから。bash, zshで使える。
* bash
  * `shopt | grep extglob`
* zsh
  * `setopt | grep extendedglob`
* 1部分だけ異なる文字列を複数回入力する際の手間を省ける

```shell
$ touch README.{m,d}d
```
```shell
$ ls | grep README
README.dd
README.md
```
```
$ ls -la README.{m,d}d
-rw-r--r--  1 koji  staff   0  5  7 14:43 README.dd
-rw-r--r--  1 koji  staff  10  3  6 10:32 README.md
```

## プロセス展開
* プロセス展開を使うと、フック数のプログラムの処理結果を１つにまとめて別のプログラムに与えることができます。
* 出力にも使える
* ここでのカッコの構文は一部
* プロセス展開は、オープンされているファイルに/dev/fd/nという形式でアクセスできるUnixシステムでのみ利用可能

```shell
grep -h test <(echo ffff hhhttt test) <(echo test rrere)
```
途中経過をmailしつつファイルに書き出す
```shell
echo 'hhhhhhh gggg' | tee >(sort) >(mail -s 'test' gg) > output
```

## チルダ展開
* \~pi
  * /home/pi を展開する
* \~
  * ログインユーザのホームディレクトリ を展開する
* ksh93, bash, zshのみ
  * \~+
    * pwdと同値
  * \~-
    * 直前のpwdを返す

## ヒアストリング
* ヒアストリングを作成するには、`<<<`に続けて文字列を記述します。
* シェルはこの文字列に対して各種の展開を行い、末尾に改行文字を追加したものをコマンドの標準入力に与えます。

```shell
$ text=$(cat << GG
gkfgok
gkfogf
fkf
GG
)
$ echo $text
gkfgok gkfogf fkf
$ grep g <<< $text
gkfgok
gkfogf
```

### bad
```
$ echo $text | grep g
gkfgok gkfogf fkf
```

## 起動中のシェルがログインシェルか確認する
ログインシェルは、ホームディレクトリでzshrcとかが読み込まれているのでシェルから起動したシェルだと外部ファイルの読み込みかもしれない
```
$ echo $?
-/usr/local/bin/zsh
```
* \- から始まっていればログインシェル
* 親プロセスがexecシステムコールを使ってこのシェルを起動したさいに、ゼロ番目の引数に`-/usr/local/bin/zsh`という文字列が指定されたという意味です。
* 複数のシェルを使いまわしていないなら気にしなくていいかッッッも

## ログイン時に読み込む設定ファイル
* ログインシェルと対話シェル($ bashで起動)では読み込む設定ファイルに違いがあって、カスタマイズしすぎるとめんどそう

## アンチエイリアス
先頭にバックスラッシュをつけるとaliasとして展開されるのを防ぐ
```
$ \ll
zsh: command not found: ll
```

## functionでラップされているコマンドのパスを調べる
* rvm を使っているとgem はrvmのfunctionでラップされていてwhichではgem実行ファイルの大本パスはわからない
  * 内部ではcommand コマンドを使って大本gemコマンドを呼び出している
* gem functionを削除してwhichすればいい
  * unset -f gem
  * which gem

## その他
### zram
https://wiki.debian.org/ZRam

## ユーザー管理
### グループに追加する
sudo usermod -aG docker koji
