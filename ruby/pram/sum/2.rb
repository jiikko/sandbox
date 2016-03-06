def func(n)
  1 * n
end

n = 10000000
c = 5
results = []

c.times do |i|
  t = Thread.new do
    once = n / c
    n_start = once * i
    n_end = once * (i + 1)
    sum = 0
    (n_start...n_end).each do |x|
      sum += func(x)
    end
    results[i] = sum
  end
  t.join
end

puts results.inject(:+)
