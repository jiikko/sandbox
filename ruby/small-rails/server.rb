require 'socket'
require 'pry'

module ApplicationController
  class DoubleRenderingError < StandardError; end
  class TemplateNotFound < StandardError; end

  class Base
    def render_action(action_name)
      if respond_to?(action_name)
        send action_name
      end

      # unless rendered_something?
      #   render_template action_name
      # end

      [200, {}, [render_body]]
    rescue TemplateNotFound
      [500, {}, ['templateが見つかりませんでした']]
    rescue DoubleRenderingError
      [500, {}, ['renderingが2重で呼ばれました']]
    end

    def render_template
      # TODO
    end

    def render(text: nil)
      raise DoubleRendering if @render_body

      if text
        @render_body = text
      end
    end

    def render_body
      unless @render_body
        raise TemplateNotFound
      end
      @render_body
    end

    def rendered_something?
      !!@render_body
    end
  end
end

class UsersController < ApplicationController::Base
  def new
    render text: 'users new'
  end
end

class ShopsController < ApplicationController::Base
  def new
    render text: 'foo'
  end
end

class RackRouter
  def initialize
    @table = {
      "users" => {
        'new' => { :this => [UsersController, :new] },
        :this => [UsersController, :index],
      },
      'shops' => {
        'new' => { :this => [ShopsController, :new] },
        :this => [ShopsController, :new],
      }
    }

  end

  def call(env)
    find_route(env[:PATH_INFO], @table) do |controller, name|
      instance = controller.new
      status, headers, body = instance.render_action name
      [status, headers, body]
    end
  end

  private

  def find_route(path, table)
    controller, action = path.split("/").drop(1).inject(table) { |t, name|
      t[name]
    }[:this]
    yield(controller, action)
  end
end

# あとで時間を記録する
class Timer
  def initialize(next_app)
  end
end

app = RackRouter.new



port = 3000
server = TCPServer.open port
puts "start!"

loop do
  socket = server.accept
  puts "got connection!"

  if match = socket.gets.chomp.match(/^(?<verb>[A-Z]*) (?<path>[^ ]*) (?<ver>.*)$/)
    headers  = []
    while line = socket.readline.chomp
      break if line.bytesize == 0
      headers << line.split(": ")
    end
    env = {
      REQUEST_METHOD: match[:verb],
      PATH_INFO: match[:path],
      HTTP_VERSION: match[:ver],
    }
    response = app.call(env)

    status = response[0]
    headers = response[1]
    body = response[2]

    socket.write "HTTP/1.1 #{status} OK\r\n"
    headers.each do |key, value|
      socket.write "#{key}: #{value}"
    end
    socket.write "\r\n"
    body.each { |part| socket.write part }
    socket.close
    puts 'next!'
  else
    socket.close
  end
end
