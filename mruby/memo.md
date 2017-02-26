# memo
## あとで調べる
### 同一contextでローカル変数を参照できない
* 1.0.0 だと参照できなかったけどmaster だと参照できた

```
// gcc -Iinclude context.c build/host/lib/libmruby.a -lm -o hello.out && ./hello.out
#include <stdio.h>
#include <mruby.h>
#include <mruby/compile.h>

int main(void) {
  mrb_state *mrb = mrb_open();
  mrbc_context *cxt = mrbc_context_new(mrb);
  mrb_value v;
  mrb_load_string_cxt(mrb, "hash = {}", cxt);
  v = mrb_load_string_cxt(mrb, "hash", cxt);
  v = mrb_funcall(mrb, v, "size", 0, 0);
  mrb_p(mrb, v);
  mrb_close(mrb);
  return 0;
}
```

## ビルドログを読むために必要なこと
c compiler は(1)オブジェクトファイルにコンパイル、(2)リンクして実行ファイルを作成する、という二段階になってる

```
$ rake
CC    tools/mrbc/mrbc.c -> build/host/tools/mrbc/mrbc.o
[...]
CC    src/variable.c -> build/host/src/variable.o
CC    src/vm.c -> build/host/src/vm.o
YACC  src/parse.y -> build/host/src/y.tab.c
CC    build/host/src/y.tab.c -> build/host/src/y.tab.o
AR    build/host/lib/libmruby_core.a
ar: creating archive /Users/koji/mruby/build/host/lib/libmruby_core.a
```

* CC
  * c compair
  * リンクせずコンパイルをしてオブジェクトファイルを生成している
  * gcc -c source.c などするとオブジェクトファイルを生成する
* YACC
  * http://kmaebashi.com/programmer/devlang/yacclex.html
* AR
  * archive
  * オブジェクトファイルをまとめている

### arを使って実行ファイルを作成してみる
```
// cat.c
#include <stdio.h>

int nyan() {
  printf("にゃーん\n");
  return 1;
}
```
```
// dog.c
#include <stdio.h>

int baw() {
  printf("ワン！");
  return 1;
}
```
```shell
gcc -c dog.c cat.c
$ ls -l dog.o cat.o
-rw-r--r--  1 koji  staff  768  2 26 18:41 cat.o
-rw-r--r--  1 koji  staff  760  2 26 18:41 dog.o

$ ar -r animals.a dog.o cat.o
ar: creating archive animals.a

$ nm dog.o cat.o
dog.o:
0000000000000000 T _baw
                 U _printf

cat.o:
0000000000000000 T _nyan
                 U _printf

$ nm animals.a

animals.a(dog.o):
0000000000000000 T _baw
                 U _printf

animals.a(cat.o):
0000000000000000 T _nyan
                 U _printf

$ gcc -o javari_park javari_park.c animals.a

./javari_park
ワン！にゃーん
```
