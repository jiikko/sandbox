require 'open-uri'

URLS = [
  # analiticsで取得する
]
HOST = ''
CONCURRENCY = 10

class Worker
  def initialize(sock_path)
    @sock = UnixSocket.new(sock_path)
  end

  def work!
    loop {
      data = @sock.read
      if data
        get_request(data)
      else
        break
      end
    }
  end

  private

  def get_request(url)
    open() do
    end
  end
end

class Master
  def initialize(urls)
    @sock_path = '/tmp/.mp'
    @sock = UnixServer.new(@sock_path)
    @urls = urls
  end

  def pop_url
    @urls.pop
  end

  def new_worker
    fork {
      worker = Worker.new(sock_path)
      worker.work!
      exit 0
    }
  end

  private

  def sock_path
    @sock_path
  end
end

master = Master.new(urls)
concurrency.times {
  master.fork_worker!
}
