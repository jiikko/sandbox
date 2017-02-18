# mruby Tutorial
* Hello Worldしてみる
  * https://github.com/mruby/mruby/wiki/Hello-World
* mruby 本読む
* mruby 各年のアドベントカレンダーを読む
  * http://qiita.com/advent-calendar/2013/mruby
  * http://qiita.com/advent-calendar/2015/mruby
  * http://qiita.com/advent-calendar/2016/mruby
* mruby-cli でコマンドラインツールを作ってみる
  * Rakefileとbuild_config.rbの中をついでに読んでみる
* cでmrubyを実行してmrubyからhello worldする
* cでハッシュクラス自作記事を写経する
  * http://qiita.com/cubicdaiya/items/fc0620c7b9629bb85d6f
* 公式ドキュメントを読む
  * https://github.com/mruby/mruby/tree/master/doc
* 適当なhttpリクエストを送るmrbgemを読んでみる
* httpリクエストを送るmrbgemを作ってみる
* Stringクラスを読んで見る

## toolcain
* mgemの仕組み的なのを追う
* コンパイルを追う
  * http://qiita.com/masuidrive/items/e516c23b4feab73d139f
  * https://github.com/mruby/mruby/blob/master/doc/guides/compile.md

## あとで調べる
* 同一contextでローカル変数を参照できない
```
#include <stdio.h>
#include <mruby.h>
#include <mruby/compile.h>

int main(void) {
  mrb_state *mrb = mrb_open();
  mrbc_context *cxt = mrbc_context_new(mrb);
  mrb_value v;
  v = mrb_load_string_cxt(mrb, "print '[1]'; name = 'john'; p name; def hoge; 'foo'; end", cxt); // [1]"john"
  v = mrb_load_string_cxt(mrb, "print '[2]'; print name; p hoge", cxt); // [2]"foo"
  mrb_close(mrb);
  return 0;
}
```
