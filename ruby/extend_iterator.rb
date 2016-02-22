class ParallelArray
  include Enumerable

  def initialize(source)
    @source = source
  end

  def each(&block)
    # yield(@source)
    for x in @source do
      if x == 1
        puts "skip"
        next
      end
      puts "koi"
      sleep 1
      block.call(x)
    end
  end
end
ParallelArray.new([3, 1, 4]).each { |x| puts x }




def server
  require "socket"
  `rm /tmp/s`
  ss = UNIXServer.new("/tmp/s")
  s = ss.accept
  puts s.recv_io
ensure
  ss.close if ss
end

def echo_server
  require "socket"
  ss = UNIXServer.new("/tmp/s")
  # i don't no
  ss.accept_nonblock { # IO::EAGAINWaitReadable: Resource temporarily unavailable - accept(2) would block
    s = ss.accept
    f = s.recv_io
    puts f.read
  }
ensure
  ss.close if ss
end

def echo_server2
  require "socket"
  ss = UNIXServer.new("/tmp/s")
  loop {
    if IO.select([ss], nil, nil, 1).nil?
      sleep(1)
      puts '待ちました'
    else
      s = ss.accept
      f = s.recv_io
      puts f.read
      f.close
      s.close
    end
  }
ensure
  ss.close if ss
end


def client
  File.write('/tmp/tmp_file', 'konoseka')
  f = File.open('/tmp/tmp_file')
  cs = UNIXSocket.open("/tmp/s")
  cs.send_io(File.open('/tmp/tmp_file'))
ensure
  cs.close if cs
end

def client2
  File.write('/tmp/tmp_file', 'konoseka')
  f = File.open('/tmp/tmp_file')
  cs = UNIXSocket.open("/tmp/s")
  cs.send_io(File.open('/tmp/tmp_file'))
ensure
  cs.close if cs
end
