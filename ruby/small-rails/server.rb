require 'socket'

port = 3000
server = TCPServer.open port

socket = server.accept

loop do
  puts "got connection!"

  if match = socket.gets.chomp.match(/^(?<verb>[A-Z]*) (?<path>[^ ]*) (?<ver>.*)$/)
    headers  = []
    while line = socket.readline.chomp
      break if line.bytesize == 0
      headers << line.split(": ")
    end
    p VERB: match[:verb]
    p PATH: match[:path]
    p VERSION: match[:ver]
    p HEADERS: headers

    if line.bytesize == 0
      socket.write "HTTP/1.1 200 OK"
      socket.write "\r\n"
      socket.write "Hellow \r\n"
      socket.close
      break
    end
  end
end
