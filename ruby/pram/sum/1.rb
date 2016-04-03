def func(n)
  1 * n
end

n = 10000000

sum = 0
n.times do |j|
  sum += func(j)
end
puts sum
