require 'timeout'

def ensure_timeout(timeout, &block)
  threads = []
  current_thread = Thread.current
  wotker_thread = Thread.new do
    value = yield
    if value.is_a?(Thread)
      threads << value
    end
  end
  watch_dog_thread = Thread.new do
    counter = 0
    loop do
      counter = counter + 1
      if counter > timeout
        wotker_thread.raise(Timeout::Error, 'execution expired')
        threads.each { |thread| thread.raise(Timeout::Error, 'execution expired') }
        current_thread.raise(Timeout::Error, 'execution expired')
        break
      end
      sleep(1)
    end
  end
ensure
  watch_dog_thread.join
  wotker_thread.join
end

# Thread
require 'timeout'; Timeout.timeout(1) { puts 'finished with c' }
require 'timeout'; Timeout.timeout(1) { sleep(2); puts 'finished with c' }
require 'timeout'; Timeout.timeout(1) { Thread.new { sleep(2); puts 'finished' } }
require 'timeout'; ensure_timeout(1) { Thread.new { sleep(2); puts 'finished with ensure_timeout' } }
require 'timeout'; ensure_timeout(1) { sleep(2); puts 'finished without thread with ensure_timeout' }

# 通信街
# timeout 発生しよる
require "socket"
require 'timeout'; ensure_timeout(1) { sleep(2); puts 'finished without thread with ensure_timeout' }
Timeout::timeout(1) do
  begin
    gs = TCPServer.open(0)
    gs.accept
  ensure
    gs.close
  end
end
