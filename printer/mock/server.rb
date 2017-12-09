require 'rack'
require 'pry'

def response
  [ 200, {
      'Access-Control-Allow-Origin' => '*',
      "Access-Control-Allow-Headers" => "If-Modified-Since,SOAPAction,Content-Type,Content-Type,Accept,Authorization",
      'Access-Control-Allow-Methods' => 'GET,PUT,POST,DELETE,PATCH,OPTIONS',
      'Cache-Control' => 'public',
      'Content-Type' => 'text/plain',
      'Access-Control-Allow-Credentials' => 'true',
    }, ['success="true"']
  ]
end

app = Rack::Builder.app do
  run lambda { |env|
    request = Rack::Request.new(env)
    env['Access-Control-Allow-Origin'] = '*'
    p request.params
    case env['REQUEST_PATH']
    when '/cgi-bin/eposDisp/service.cgi'
      puts 'success!!!!!!!!!!!!1'
      response
    when '/cgi-bin/epos/service.cgi'
      puts 'second!!!!!!!!!!!!1'
      response
    when '/Users/koji/src/epson_js/sdk.js'
      [ 200, 
        { 'Content-Type' => 'text/javascript' },
        [File.open('/Users/koji/src/epson_js/sdk.js').read]
      ]
    when '/Users/koji/src/epson_js/jquery.min.js'
      [ 200, 
        { 'Content-Type' => 'text/javascript' },
        [File.open('/Users/koji/src/epson_js/jquery.min.js').read]
      ]
    when '/'
      [ 200, 
        { 'Content-Type' => 'text/html' },
        [
          File.open('/Users/koji/src/epson_js/printer.html').read
        ]
      ]
    else
      response
    end
  }
end

Rack::Server.new(app: app, Port: 80).start
