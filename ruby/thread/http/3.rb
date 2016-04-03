require './http_helper'
require './thread_manegaer'

concurency = 4

thread_manegaer = Threadmanegaer.new(concurency)
queue = thread_manegaer.queue
ts = []
results = []

concurency.times do
  ts << Thread.start do
    loop do
      task = queue.pop
      if task
        response = task.call
        results << response.code
      else
        break
      end
    end
  end
end

COUNT.times do
  thread_manegaer.forward_task(->{ get_request })
end
thread_manegaer.finish
puts results.inspect
