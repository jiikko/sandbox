ENV['MONGOHQ_URL']

require './app'
require 'timeout'

class ShowEnv
  def call(env)
    Timeout.timeout(2) do
      sleep(rand(3))
    end

    [ 200,                                          # ステータス(Integer)
      { 'Content-Type' => 'text/plain' },           # レスポンスヘッダ(Hash)
      env.keys.sort.map {|k| "#{k} = #{env[k]}\n" } # body(StringのArray)
    ]
  end
end

use SQLLogger::Middleware
run ShowEnv.new
