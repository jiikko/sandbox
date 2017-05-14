require 'benchmark'
require 'fib'

Benchmark.bm do |r|
  r.report { Fib.c(20) }
  r.report { Fib.ruby(20) }
end
