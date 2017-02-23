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
