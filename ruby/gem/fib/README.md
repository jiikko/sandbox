# Fib

```shell
$ cat fib.rb
require 'benchmark'
Benchmark.bm do |r|
  r.report { Fib.c(20) }
  r.report { Fib.ruby(20) }
end
```

```shell
$ bundle exec ruby fib.rb
       user     system      total        real
   0.000000   0.000000   0.000000 (  0.000487)
   0.000000   0.000000   0.000000 (  0.001844)
```
