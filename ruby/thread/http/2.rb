require './http_helper'

queue = Queue.new
ts = []
results = []
concurency = 4

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
  queue.push(->{ get_request })
end
concurency.times { queue.push(nil) }
ts.each(&:join)
puts results.inspect
