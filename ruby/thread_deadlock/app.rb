require 'logger'
require 'pry'
require 'mongo'

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

module MongoConnector
  # Connect to mongodb server and establish connection.
  def connect(collection_name)
    puts 'gggggggggg'
    client = Mongo::Client.new(['localhost:28001'], database: 'test')
      
    coll = client[collection_name]
    return [client,  coll]
  end
  
  module_function :connect
end

module Rails
  def self.logger
    @logger
  end
  def self.logger=(l)
    @logger = l
  end
end
Rails.logger = Logger.new(STDOUT)


class SQLLogger
  class Middleware
    def initialize(app)
      @app = app
      # ActiveSupport::Notifications.subscribe "sql.active_record" do |*args|
      #   SQLLogger.instance.try do |logger|
      #     logger.log_sql(args[4][:sql])
      #   end
      # end
    end

    def call(env)
      logger = SQLLogger.new()
      result = nil

      begin
        Thread.current[:sql_logger_instance] = logger
        result = @app.call(env)
      ensure
        Thread.current[:sql_logger_instance] = nil
        logger.write_to_mongo(env, result) unless logger.skip_logging
      end
    end
  end

  module Queue
    def self.queue(hash)
      @queue.push(hash) if started?
    end

    def self.started?
      !!@queue
    end
    
    def self.start
      @queue = ::Queue.new
      @thread ||= Thread.new do
        while hash = @queue.pop
          ensure_mongo_connected do |collection|
            begin
              Rails.logger.debug "Inserting to mongodb..."
              collection.insert_one(hash)
              if ENV['FLUENTD_URL']
                url =  ENV['FLUENTD_URL']+"?time=#{Time.now.to_i}"
                HTTPClient.new.post(url, hash.to_json, 'Content-Type' => 'application/json')
              end
            rescue => exn
              Rails.logger.debug exn.inspect
            end
          end
        end
      end
      Rails.logger.info "#{self} started"
    end

    def self.join
      Rails.logger.debug "Waiting for shutdown of worker thread..."
      @queue.push(false)
      @thread.try(:join)
      @thread = nil
    end

    def self.ensure_mongo_connected(&block)
      unless @conn
        begin
          Rails.logger.info "Connecting to MongoDB"

          collection_name = ENV['MONGO_LOGS_COLLECTION'] || "sql_logger_records"
          @conn, @coll = MongoConnector.connect(collection_name)
        rescue 
          Rails.logger.error "Mongo DB connect failed"
        end
        
        return unless @conn
      end

      begin
        yield(@coll)
      rescue
        begin
          yield(@coll)
        rescue
          Rails.logger.error "Mongo DB insert failed"
          @conn = nil
          @coll = nil
        end
      end
    end
  end

  def initialize
    @sql_buffer = StringIO.new
  end
  
  def log_sql(sql)
    @sql_buffer.puts(sql)
  end
  
  def setup(hash)
    if hash
      @context ||= {}
      @context.merge!(hash)
    else
      @context = nil
    end
  end
  
  def write_to_mongo(env, result)
    return unless @context
    
    hash = {}
    
    hash[:timestamp] = Time.now
    hash[:method] = env["REQUEST_METHOD"]
    hash[:url] = env["REQUEST_URI"]
    hash[:status] = result.try(:first) || 503
    hash[:sql] = SQLLogger.shorten_sql(@sql_buffer.string)
    
    hash.merge!(SQLLogger.trim_strings_in_json(@context))
    
    Queue.queue(hash)
  end
  
  def self.instance
    Thread.current[:sql_logger_instance]
  end

  def skip_logging
    @skip_logging
  end

  def skip_logging!
    @skip_logging = true
  end

  def self.shorten_sql(sql, size: 64.kilobytes)
    expected_size = [size - 4, 0].max

    if sql.bytesize <= expected_size
      sql
    else
      sql = sql.dup
      while sql.bytesize > expected_size
        sql.sub!(/\A.*?$/, '').sub!(/\A\n/, "")
      end
      "...\n" + sql
    end
  end

  def self.trim_strings_in_json(json, size: 1.kilobytes)
    case json
    when Hash
      json.each.with_object({}) do |(k, v), hash|
        hash[k] = trim_strings_in_json(v, size: size)
      end
    when Array
      json.map {|element| trim_strings_in_json(element, size: size) }
    when String
      if json.bytesize > size
        json[0, size-3] + "..."
      else
        json
      end
    when Numeric
      json
    when TrueClass, FalseClass
      json
    when json.respond_to?(:as_json)
      self.trim_strings_in_json(json.as_json, size: size)
    when nil
      nil
    else
      json.inspect
    end
  end
end


Rails.logger.error "###############33333"
