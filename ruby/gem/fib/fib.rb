require 'benchmark'
require 'fib'

Benchmark.bm do |r|
  r.report { Fib.c(40) }
  r.report { Fib.ruby(40) }
end
