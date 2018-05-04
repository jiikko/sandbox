class Block
  attr_reader :index, :prev_hash, :timestamp, :data, :hash

  def initialize(index: , prev_hash: , timestamp: , data: )
    @index = index
    @prev_hash = prev_hash
    @timestamp = timestamp
    @data = data
    @hash = to_hash(index: index, prev_hash: prev_hash, timestamp: timestamp, data: data)
  end

  def equeal?(block)
    hash == block.hash
  end

  private

  def to_hash(index: , prev_hash: , timestamp: , data: )
    Digest::SHA256.hexdigest({
      index: index,
      prev_hash: prev_hash,
      timestamp: timestamp,
      data: data,
    }.to_json)
  end

  class << self
    def genesis
      self.new(
        index: 0,
        prev_hash: '0',
        timestamp: 1512779478,
        data: 'I am genesis block!',
      )
    end
  end
end
