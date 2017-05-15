# Fib
```
rake compile && cat fib.rb && bundle exec ruby fib.rb
```

```shell
$ cat fib.rb
require 'benchmark'

Benchmark.bm do |r|
  r.report { Fib.c(40) }
  r.report { Fib.ruby(40) }
end
```

```shell
$ bundle exec ruby fib.rb
       user     system      total        real
   0.520000   0.000000   0.520000 (  0.523696)
  11.520000   0.020000  11.540000 ( 11.555269)
```
