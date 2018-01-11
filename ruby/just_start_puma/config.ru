class PumaRefresher
  def initialize(interval: 30 * 60, timeout: 1)
    @interval = interval
    @timeout = timeout
    @running = false
  end

  def stop
    @running = false
    @thread.join
  end

  def start
    @running = true
    @thread = Thread.start do
      begin
        run_loop do
          refresh_workers
        end
      rescue Exception => e
        puts "PumaRefresher ERR: #{e.class.to_s}: #{e.message}"
        raise
      end
    end
    @thread.abort_on_exception = true
  end

  private

  def run_loop
    next_yield = Time.now + random_interval

    while @running
      sleep @timeout
      if next_yield < Time.now
        next_yield = Time.now + random_interval
        yield
      end
    end
  end

  def random_interval
    factor = 1.2 - rand * 0.4
    @interval * factor
  end

  def refresh_workers
    workers = get_workers
    if workers
      puts "[#{Process.pid}] Refreshing #{workers.size} Puma workers... #{workers.map(&:pid)}"
      workers.each do |worker|
        puts "Killing Puma worker #{worker.pid}..."
        worker.term
      end
    else
      puts "[#{Process.pid}] No Puma Worker running..." if @master
    end
  end

  def get_workers
    if defined?(Puma::Cluster)
      @master ||= ObjectSpace.each_object(Puma::Cluster).first
      @master.instance_variable_get(:@workers)
    end
  end
end

interval = (20)
$Refresher = PumaRefresher.new(interval: interval).tap(&:start)

class ShowEnv
  def call(env)
    [ 200,                                          # ステータス(Integer)
      { 'Content-Type' => 'text/plain' },           # レスポンスヘッダ(Hash)
      env.keys.sort.map {|k| "#{k} = #{env[k]}\n" } # body(StringのArray)
    ]
  end
end

run ShowEnv.new
