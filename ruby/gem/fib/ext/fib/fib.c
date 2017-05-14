#include "fib.h"

VALUE rb_mFib;


VALUE fib(VALUE self, VALUE n)
{
    VALUE n1, n2;
    if (NUM2INT(n) < 2) {
        return n;
    } else {
      n1 = fib(
          self,
          INT2NUM(NUM2INT(n) - 1)
      );
      n2 = fib(
          self,
          INT2NUM(NUM2INT(n) - 2)
      );
      return INT2NUM(NUM2INT(n1) + NUM2INT(n2));
    }
}


void
Init_fib(void)
{
  rb_mFib = rb_define_module("Fib");
  rb_define_singleton_method(rb_mFib, "c", RUBY_METHOD_FUNC(fib), 1);
}
