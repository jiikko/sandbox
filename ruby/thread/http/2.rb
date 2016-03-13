require './http_helper'

concurency = 6

queue = Queue.new
ts = []
results = []
mutex = Mutex.new

concurency.times do
  ts << Thread.start do
    loop do
      task = queue.pop
      if task
        response = task.call
        mutex.synchronize { results << response.code }
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
