# 時間帯ごとにmongoへの送信がどのくらい遅延しているのかを調べる
# - 入力はソートしていなくていい

require 'time'
require 'pry'

time_map = {}
per_time = 60

current_time = nil
time_list = []

File.open(ARGV[0]).each_line do |line|
  time = line.split(" ").first rescue next
  if /(^2018-..-..T\d\d:\d\d:\d\d)/ =~ time
    time_list << { time: Time.parse($1), log: line }
  else
    # 2018-01-13T1 app[web.10]: なのがある
    next
  end
end

sorted_list = time_list.sort_by { |x| x[:time] }
older = sorted_list.first
newer = sorted_list.last
interval = 600
time_map = {}
current_time = older[:time]

# 新しいのと古い時間までinterval毎にHashを作る
loop do
  time_map[current_time] = []
  # 最後から1分前に入っている場合
  if ((newer[:time] - interval)..newer[:time]).include?(current_time)
    break
  end
  current_time = current_time + interval
end

sorted_list

