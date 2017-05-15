#include "fib.h"

VALUE rb_mFib;

int fib_internal(int n)
{
    if (n < 2) {
        return n;
    } else {
      return fib_internal(n-1)+fib_internal(n-2);
    }
}

VALUE fib(VALUE self, VALUE n)
{
    return INT2NUM(fib_internal(NUM2INT(n)));
}

void
Init_fib(void)
{
  rb_mFib = rb_define_module("Fib");
  rb_define_singleton_method(rb_mFib, "c", RUBY_METHOD_FUNC(fib), 1);
}
