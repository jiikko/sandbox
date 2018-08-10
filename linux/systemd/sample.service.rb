#!/usr/bin/ruby

trap :HUP do
  puts "I'm recived HUP!!!!!!!"
  exit 0
end

trap :KILL do
  puts "I'm killed!!!!!!!"
  exit 0
end

loop do
  puts "zzz..."
  sleep 100
end
