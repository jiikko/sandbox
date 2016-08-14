# UNIX V6

### なぜ今更Unix?

linuxカーネルは現在100万行と言われています。

それに対してunix v6は1万行程度。

にも関わらず、現在のlinuxに引き継がれている様々なシステムがunix v6で実装されています。

* ファイルシステム
* ソケット
* プロセス
* シグナルハンドリング
* etc...

つまり、linuxの概要を理解する足がかりとしては参考になるソースコードとなります。

### これを読んでどんな知見が得られるのか?

* OSがより身近に感じられる
  * 現在実装しているプログラムのシステムコールの中身を垣間みれる
  * PCが不調なとき、どうやって調べれば良くて、どうして悪いのか、という判断材料になる
* Cが学べる(古いのであまりおすすめはできないけど...)

source https://github.com/myoan/unix-study

### その他
#### シーケンス図の作り方

* https://stackedit.io/editor
* http://qiita.com/ka215/items/a709665cb34c505ccf1f
* https://www.websequencediagrams.com/

```sequence
Frontend->Backend:get or post
Backend->Redis:get
Redis->Redis:get model
Redis-->MySQL:get model (When data is not found on Redis)
Redis-->Backend:mohdel
Backend-->Frontend:json
Frontend->Frontend:build DOM
```

```
// https://www.websequencediagrams.com/
親プロセス->*子プロセス: fork
子プロセス->子プロセス: exec
子プロセス->親プロセス: exit
destroy 子プロセス
```
