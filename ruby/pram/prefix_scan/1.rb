# 包含的プレフィックスすｋ端
v = %w(
  3 5 2 5 7 9 -4 6 7 -3 1 7 6 8 -1 2
)
v = v.map(&:to_i)

v.size.times.each { |i|
  i = i + 1
  break if v[i].nil? # skip first
  v[i] = v[i - 1] + v[i]
}
puts v
