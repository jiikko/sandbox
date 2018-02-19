# 2018-01-13T09:49:17.009301+00:00 app[web.10]: Processing by Api3Controller#index_menu_items as HTML
# のようなフォーマットでログを時系列に並び替えて標準出力に吐き出す

file = File.open(ARGV[0])
list = []
file.each_line do |line|
  line = line.gsub(%r!^app_log/.+\.log\.gz:!, '')
  time = line.scrub('').split(" ").first
  list << { time: time, line: line }
end
puts list.sort_by { |time_with_line| time_with_line[:time] }.map { |h|h[:line] }
