#! /usr/bin/env ruby

require 'io/console'
require 'io/console/size'

file_name =
  if ARGV[0].nil?
    puts 'input filename'
    exit 1
  else
    ARGV[0]
  end
text = File.read(file_name)


#画面を消去して、真ん中に移動しておく
print "\e[2J"
print "\e[%d;%dH" % [0, 0]
# print "\e[%d;%dH" % IO::console_size.map{|size| size / 2 }

puts text
while (key = STDIN.getch) != "\C-c"
  # 方向キー以外は不要なので、エスケープ文字を得る処理は簡略化した
  if key == "\e" && STDIN.getch == "["
    key = STDIN.getch
  end

  # 方向を判断
  direction =
    case key
    when "A", "k", "w", "\u0010"; "A" #↑
    when "B", "j", "s", "\u000E"; "B" #↓
    when "C", "l", "d", "\u0006"; "C" #→
    when "D", "h", "a", "\u0002"; "D" #←
    else nil
    end

  # カーソル移動
  print "\e[#{direction}" if direction
end
