v = %w(
  3 5 2 5 7 9 -4 6 7 -3 1 7 6 8 -1 2
)
v = v.map(&:to_i)

c = 4

t_list = []
middle_list = []
# step1
c.times do |i|
  t_list << Thread.new do
    chank = v.size / c
    t_start = i * chank
    t_end = (i + 1) * chank
    (t_start...t_end).each do |n|
      middle_list[i] = (middle_list[i] || 0) + v[n]
      if n == t_start
        next
      else
        v[n] = v[n] + v[n - 1]
      end
    end
  end
end
t_list.each(&:join)

# step2
exc_middle_list = []
middle_list.size.times do |i|
  exc_middle_list[i] =
    if i == 0
      0
    else
      exc_middle_list[i - 1] + middle_list[i - 1]
    end
end

# step3
c.times do |i|
  t_list << Thread.new do
    chank = v.size / c
    t_start = i * chank
    t_end = (i + 1) * chank
    (t_start...t_end).each do |n|
       v[n] = v[n] + exc_middle_list[i]
    end
  end
end
t_list.each(&:join)
puts v

# 正解
# [3, 8, 10, 15, 22, 31, 27, 33, 40, 37, 38, 45, 51, 59, 58, 60]
