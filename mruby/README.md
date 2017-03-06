# mruby
## コンパイラメモ
* プリプロセッサの出力を確認する
  * オプションE
  * `gcc -Iinclude src/print.c -E`

## あとで役に立ちそう
* 非公式実装ドキュメント
  * https://github.com/syucream/mrubook
  * https://syucream.github.io/mrubook/index.html
* 整数などその他の型は mruby/include/value.h をみるとよいでしょう
  * http://qiita.com/cubicdaiya/items/fc0620c7b9629bb85d6f#hoge%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%82%92%E5%AE%9A%E7%BE%A9%E3%81%99%E3%82%8B

## ビルドの流れ
* http://www.oki-osk.jp/esc/mruby-oa/02.html
