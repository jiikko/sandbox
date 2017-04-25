#include "string_concat.h"
#include <stdio.h>
#include <string.h>


VALUE rb_mStringConcat;


VALUE strcat_by_count(VALUE self, VALUE string, VALUE count){
  char* word = StringValuePtr(string);
  char base[100000] = "";
  int c = NUM2INT(count);
  for(int i = 0; i < c; i++) {
    strcat(base, word);
  }
  return rb_str_new2(base);
}


void
Init_string_concat(void)
{
  rb_mStringConcat = rb_define_module("StringConcat");
  rb_define_singleton_method(rb_mStringConcat, "concat", RUBY_METHOD_FUNC(strcat_by_count), 2);
}

// String.new('gg').extend(StringConcat).strcat_by_count
//
// require 'benchmark'; Benchmark.benchmark { |b| b.report { 100.times { 'ggg' * 10000 } }}
// require 'benchmark'; Benchmark.benchmark { |b| b.report { 100.times { StringConcat.concat('ggg', 10000) } } }
