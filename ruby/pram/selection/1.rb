list = (0..500).to_a.shuffle

MAX = 40

def find_median(list)
  if MAX < list.size
    splited_chanks = {}
    chank = list.size / MAX
    chank.times do |i|
      start_to_end = i...(i + 1)
      splited_chanks[start_to_end] = find_median(list[start_to_end])
    end
    find_median(splited_chanks.values)
  else
    list.sort[list.size / 2]
  end
end

puts find_median(list)
