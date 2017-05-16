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
  r.report { Fib.ruby2(40) } # http://qiita.com/akaneko3/items/b909d51826597b9ec604
end
```

```shell
$ bundle exec ruby fib.rb
       user     system      total        real
   0.820000   0.010000   0.830000 (  0.844408)
  15.810000   0.060000  15.870000 ( 16.100335)
   0.000000   0.000000   0.000000 (  0.000042)
```
