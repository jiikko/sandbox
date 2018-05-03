class BlockChain
  attr_reader :blocks

  def initialize
    @blocks = []
    @blocks << BlockChain.get_genesis_block
  end 

  def get_latest_block
    @blocks.last
  end

  def generate_next_block(data)
    prev_block = get_latest_block
    next_index = prev_block.index + 1
    next_timestamp = Time.now.to_i
    Block.new(
      index: next_index,
      prev_hash: prev_block.hash, 
      timestamp: next_timestamp,
      data: data,
    )
  end

  def is_valid_new_block?(new_block, prev_block)
    case
    when (prev_block.index + 1) != new_block.index
      puts 'invalid index'
      return false
    # 親のハッシュ値が同じか確認
    when prev_block.hash != new_block.prev_hash
      puts 'invaalid hash: prev_hash'
      return false
    # hash値が正しいか再計算をしている
    when to_hash_for_block(new_block) != new_block.hash
      puts 'invalid hash: hash'
      return false
    end
    true
  end

  def add_block(new_block)
    if is_valid_new_block?(new_block, get_latest_block)
      @blocks << new_block
      true
    else
      false
    end
  end

  def size
    @blocks.size
  end

  def generate_next_block_and_add(data)
    next_block = generate_next_block(data)
    add_block(next_block)
  end

  private

  def to_hash_for_block(block)
    Digest::SHA256.hexdigest({
      index: block.index,
      prev_hash: block.prev_hash,
      timestamp: block.timestamp,
      data: block.data,
    }.to_json)
  end

  class << self
    def is_valid_chai?(block_chain_to_validate)
      # TODO
    end

    def get_genesis_block
      Block.genesis
    end
    end
  end
