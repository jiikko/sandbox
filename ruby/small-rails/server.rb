require 'socket'
require 'pry'

class Application
  def call(env)
    [200, {}, ["hellow #{Time.now.to_i}"]]
  end
end


app = Application.new

port = 3000
server = TCPServer.open port
puts "start!"

loop do
  socket = server.accept
  puts "got connection!"

  if match = socket.gets.chomp.match(/^(?<verb>[A-Z]*) (?<path>[^ ]*) (?<ver>.*)$/)
    headers  = []
    while line = socket.readline.chomp
      break if line.bytesize == 0
      headers << line.split(": ")
    end
    env = {
      REQUEST_METHOD: match[:verb],
      PATH_INFO: match[:path],
      HTTP_VERSION: match[:ver],
    }
    response = app.call(env)

    status = response[0]
    headers = response[1]
    body = response[2]

    socket.write "HTTP/1.1 #{status} OK\r\n"
    headers.each do |key, value|
      socket.write "#{key}: #{value}"
    end
    socket.write "\r\n"
    body.each { |part| socket.write part }
    socket.close
    puts 'next!'
  else
    socket.close
  end
end
