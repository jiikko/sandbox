def func(n)
  1 * n
end

n = 10000000
c = 5
results = []

c.times do |i|
  t = Thread.new do
    tno = i + 1
    once = n / c
    n_end = once * tno
    n_start = once * (tno - 1 )
    sum = 0
    (n_start...n_end).each do |x|
      sum += func(x)
    end
    results[tno] = sum
  end
  t.join
end

puts results.compact.inject(:+)
