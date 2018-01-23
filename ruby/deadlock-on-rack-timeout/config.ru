require 'logger'
class Logger
  class LogDevice
    def write(message)
      begin
        synchronize do
          if @shift_age and @dev.respond_to?(:stat)
            begin
              check_shift_log
            rescue
              warn("log shifting failed. #{$!}")
            end
          end
          begin
            @dev.write(message)
          rescue
            warn("log writing failed. #{$!}")
          end
        end
      rescue Exception => ignored
        warn("log writing failed. #{ignored.full_messages}")
      end
    end
  end
end



require 'rack'
require 'rack-timeout'
require 'pp'
require 'pry'
require 'logger'
require 'thread'
require 'timeout'
require 'puma'

File.write('log.log', nil)
$logger = Logger.new('log.log')

class Middleware
  def initialize(app)
    @app = app
  end

  def call(env)
    sleep 2
    pp 'called middleware'
    @app.call(env)
  end
end

class MutexLoop
  def initialize(app)
    @app = app
  end

  def call(env)
    Thread.start do
      loop do
        m = Mutex.new
        m.synchronize do
        $logger.info 'from mainthread'
        end
      end
    end
    @app.call(env)
  end
end

app = ->(env){
  begin 
    Timeout.timeout(2) do
      loop do
        $logger.info 'from mainthread'
      end
    end
  rescue
  end
  [200, {'Content-Type' => 'text/plain'}, ['OK']] 
}

use Rack::Timeout, service_timeout: 1
use MutexLoop
run app
