require "socket"

gs = TCPServer.open(8008)
addr = gs.addr
addr.shift
printf("server is on %s\n", addr.join(":"))

responses = [
"<connect><data><client_id>sock6705352456</client_id><protocol_version>2</protocol_version></data></connect>",
"<open_device><device_id>local_printer</device_id><code>OK</code><data_id>1</data_id></open_device>"
"<open_device><device_id>local_scanner</device_id><code>OK</code><data_id>2</data_id></open_device>",
]
while true
  Thread.start(gs.accept) do |s|       # save to dynamic variable
    print(s, " is accepted\n")
    while s.gets
      puts 'hi'
      s.puts('recievied')
    end
    print(s, " is gone\n")
    s.close
  end
end
