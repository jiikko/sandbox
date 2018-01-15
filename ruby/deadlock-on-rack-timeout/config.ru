require 'rack'
require 'rack-timeout'
require 'pp'
require 'pry'
require 'logger'
require 'thread'
require 'timeout'
require 'puma'
require './refresher'

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
run app
