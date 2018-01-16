require 'time'
require 'pry'

def get_time_diff(line)
  if /:timestamp=>(2018-\d\d-\d\d \d\d:\d\d:\d\d) / =~ line
    timestamp_from_mongo = Time.parse($1)
    if /(^2018-..-..T\d\d:\d\d:\d\d)/ =~ line
      timestamp_from_log = Time.parse($1)
      r = timestamp_from_log - timestamp_from_mongo
      # ログが崩れていて別の行が混ざっている時があり、マイナスになることがある
      if r.negative?
        return  0
      else
        return r
      end
    else
      puts "found bad line. failing get timestamp of log!!(#{line})"
    end
  else
    puts "found bad line. failing get timestamp of mongo!!(#{line})"
    0
  end
end

time_map = {}
per_time = 60

current_time = nil
File.open(ARGV[0]).each_line do |line|
  time = line.split(" ").first rescue next
  if /(^2018-..-..T\d\d:\d\d:\d\d)/ =~ time
    time = Time.parse($1)
  else
    # 2018-01-13T1 app[web.10]: なのがある
    next
  end

  current_time ||= time
  time_map[current_time] ||= 0

  if (current_time..(current_time + per_time)).include?(time)
    time_map[current_time] += get_time_diff(line)
  else
    current_time = current_time + per_time
    time_map[current_time] ||= 0
    time_map[current_time] += get_time_diff(line)
  end
end

row = []
row << [:time, :latency].join(",")
time_map.each do |time, latency|
  row << "#{time}, #{l}"
end
puts row.join("\n")

exit 0
