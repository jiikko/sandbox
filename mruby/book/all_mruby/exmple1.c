// まつもとゆきひろ直伝　組込Ruby「mruby」のすべて 総集編
// 例題1
// gcc exmple1.c -g -I /Users/koji/sandbox/mruby/mruby/include -L /Users/koji/sandbox/mruby/mruby/build/host/lib -lmruby -o exmple.out && ./exmple.out <<< 'puts 4 * 5'

#include <stdlib.h>
#include "mruby.h"
#include "mruby/compile.h"

int main() {
  mrb_state *mrb = mrb_open();
  int n = EXIT_SUCCESS;

  mrb_load_file(mrb, stdin);
  if(mrb->exc) {
    n = EXIT_FAILURE;
  }
  mrb_close(mrb);
  return n;
}
