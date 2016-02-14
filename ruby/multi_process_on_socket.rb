require 'open-uri'
require 'socket'
require 'pry'
require 'tempfile'
`rm /tmp/.mp`

URLS = [
  # analiticsで取得する
]
HOST = ''
CONCURRENCY = 10

class Worker
  def initialize(sock_path, block)
    @sock_path = sock_path
    @block = block
  end

  def work!
    loop {
      sock = UNIXSocket.open(@sock_path)
      sock.puts('POP')
      if IO.select([sock], nil, nil, 1.0).nil?
        break
      else
        data = sock.read(65536)
        if data.nil?
          break
        else
          @block.call(Marshal.load(data))
        end
      end
      sock.close
    }
  end
end

class Master
  attr_accessor :sock

  def initialize(&block)
    @block = block
    @sock_path = '/tmp/.mp'
    @sock = UNIXServer.new(@sock_path)
  end

  def new_worker!
    fork {
      worker = Worker.new(@sock_path, @block)
      worker.work!
      exit 0
    }
  end
end

class ParallelArray
  def initialize(list, concurrency: 1)
    @list = list
    @concurrency = concurrency
  end

  def each(&block)
    master = Master.new(&block)
    @concurrency.times { master.new_worker! }
    loop {
      break if @list.empty?
      # http://docs.ruby-lang.org/ja/2.3.0/method/IO/s/select.html
      if IO.select([master.sock], nil, nil, 1).nil?
        puts '待ちます'
      else
        s = master.sock.accept
        if s.read(3) == 'POP'
          s.write(Marshal.dump(@list.pop))
        else
          raise('okashi')
        end
        s.close
      end
    }
    @list
  ensure
    master.sock.close unless master.sock.closed?
  end
end


list = [
  *(1..10).to_a
]

ParallelArray.new(list, concurrency: 4).each do |item|
  msg = "[debug] "
  msg << "pid: #{$$} "
  msg << item.class.to_s
  msg << item.to_s
  puts msg
end
