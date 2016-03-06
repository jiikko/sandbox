def func(n)
  1 * n
end

n = 10000000
c = 5
results = []

c.times do |i|
  t = Thread.new do
    chank = n / c
    n_start = chank * i
    n_end = chank * (i + 1)
    sum = 0
    (n_start...n_end).each do |x|
      sum += func(x)
    end
    results[i] = sum
  end
  t.join
end

puts results.inject(:+)
