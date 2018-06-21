class Block
  attr_reader :hash, :height, :transactions, :timestamp, :nonce, :prev_hash

  def initialize(args)
    @hash = args[:hash]
    @height = args[:height]
    @transactions = args[:transactions]
    @timestamp = args[:timestamp]
    @nonce = args[:nonce]
    @prev_hash = args[:prev_hash]
  end

  def genesis_block
  end
end
