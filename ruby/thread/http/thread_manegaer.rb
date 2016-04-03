class Threadmanegaer
  def initialize(concurency)
    @concurency = concurency
  end

  def queue
    @queue = Queue.new
  end

  def forward_task(block)
    @queue.push(block)
  end

  def finish
    @concurency.times { queue.push(nil) }
  end
end
