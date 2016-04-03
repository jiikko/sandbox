queue = Queue.new
ts = []
result = []
4.times do
  ts << Thread.start do
    loop do
      block = queue.pop.call
      puts block
      result.push block
      if block == 'exit'
        break
      else
        sleep 1
      end
    end
  end
end

queue.push(->{ 'hai' })
