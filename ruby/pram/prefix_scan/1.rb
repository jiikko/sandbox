# 包含的プレフィックスすｋ端
v = [
  3,
  5,
  2,
  5,
  7,
  9,
  4,
  6,
]

v.size.times.each { |i|
  i = i + 1
  break if v[i].nil?
  v[i] = v[i - 1] + v[i]
}
puts v
