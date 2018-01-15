require 'rack'
require 'rack-timeout'
require 'pp'
require 'pry'
require 'logger'
require 'thread'
require 'timeout'

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

class LoggerMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    Thread.start do
      loop do
        $logger.info('called from LoggerMiddleware')
      end
    end
    @app.call(env)
  end
end

app = Rack::Builder.app do
  use LoggerMiddleware
  use Rack::Timeout, service_timeout: 1
  run lambda { |env| 
    begin 
      Timeout.timeout(3) do
        loop do
          $logger.info('called from MainThread')
        end
      end
    rescue
    end
    [200, {'Content-Type' => 'text/plain'}, ['OK']] 
  }
end

t = Thread.start do
  Thread.current[:stdout] = StringIO.new
  STDOUT.puts(Thread.current[:stdout].string)
  Rack::Server.new(app: app, Port: 8080, config: 'puma_config').start
end

trap :INT do
  exit(0)
end

require 'open-uri'
require 'net/http'

retry_count = 0
begin
  puts '.'
  res = Net::HTTP.start("localhost", 8080) {|http| http.get('/') }
  puts res.body
  puts res.instance_eval { @header }
rescue Errno::ECONNREFUSED, Errno::ENOENT => e
  sleep(0.3)
  retry_count = retry_count + 1
  retry_count > 5 ? raise : retry
end

t.join
