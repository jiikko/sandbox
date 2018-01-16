# 時間あたりにリクエストが何個きたかを集計する
require 'time'
require 'pry'

time_map = {}
per_time = 60

current_time = nil
File.open(ARGV[0]).each_line do |line|
  time = line.split(" ").first rescue next
  if /(^2018-..-..T\d\d:\d\d:\d\d)/ =~ time
  else
    # 2018-01-13T1 app[web.10]: なのがある
    next
  end
  time = Time.parse($1)
  current_time ||= time
  time_map[current_time] ||= {}
  time_map[current_time][:http] ||= 0
  time_map[current_time][:mongo] ||= 0

  if (current_time..(current_time + per_time)).include?(time)
    if /Started/ =~ line 
      time_map[current_time][:http] += 1
    else
      time_map[current_time][:mongo] += 1
    end
  else
    current_time = current_time + per_time
    time_map[current_time] ||= {}
    time_map[current_time][:http] ||= 0
    time_map[current_time][:mongo] ||= 0
    if /Started/ =~ line 
      time_map[current_time][:http] += 1
    else
      time_map[current_time][:mongo] += 1
    end
  end
end

row = []
row << [:time, :http, :mongo].join(",")
time_map.each do |time, hash|
  row << "#{time}, #{hash[:http]}, #{hash[:mongo]}"
end
puts row.join("\n")
