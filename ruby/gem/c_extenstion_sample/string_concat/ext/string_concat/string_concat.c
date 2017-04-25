#include "string_concat.h"
#include <stdio.h>
#include <string.h>


VALUE rb_mStringConcat;

VALUE bar_func(VALUE self)
{
  puts("hellp!!!!");
  return self;
}


void strcat_by_count(char* string, int count){
  char *hello = "helllo";
  for(int i = 0; i < count; i++) {
    strcat(string, hello);
  }
  return;
}


void
Init_string_concat(void)
{
  rb_mStringConcat = rb_define_module("StringConcat");
  rb_define_method(rb_mStringConcat, "strcat_by_count", RUBY_METHOD_FUNC(bar_func), 0);
  // rb_define_method(rb_mStringConcata, "strcat_by_count", strcat_by_count, 0);
}

