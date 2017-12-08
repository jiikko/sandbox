require 'rack'
require 'pry'

def response
  [
    200, {
      'Access-Control-Allow-Origin' => '*',
      "Access-Control-Allow-Headers" => "If-Modified-Since,SOAPAction,Content-Type",
      'Access-Control-Allow-Methods' => 'GET,PUT,POST,DELETE,PATCH,OPTIONS',
      'Cache-Control' => 'public',
      'Content-Type' => 'text/plain',
    }, ['success="true"']
  ]
end

app = Rack::Builder.app do
  run lambda { |env|
    env['Access-Control-Allow-Origin'] = '*'
    case env['REQUEST_PATH']
    when '/cgi-bin/eposDisp/service.cgi'
      p env['QUERY_STRING']
      puts 'success!!!!!!!!!!!!1'
      response
    else
      response
    end
  }
end

Rack::Server.new(app: app, Port: 80).start
