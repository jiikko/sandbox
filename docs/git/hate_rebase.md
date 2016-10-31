# Hate rebase command
## 背景
* 別ブランチで作業していて、コミットが8個とか溜まってきている状況でそろそろマージするかって時にコミットを1つにまとめたい気持ちになる。
* 8コミット分をrebaseすることになるのだけど中間にマージコミットも含まれておりなんだかめんどくださそう。2つの連続したコミットだったらrebaseで十分。

## こうする
* トピックブランチのdiffファイルを作成して、マージ先からcheckoutしたてのブランチにdiffファイルをpatchコマンドで取り込む
  * 画像ファイルはdiffファイルでは表現できないので別途cherry-pickが必要

```
git diff --no-prefix d/17796-upgrade-rails4.2 > 4.2_deliver_now.patch
patch -p0 < 4.2_deliver_now.patch
```
