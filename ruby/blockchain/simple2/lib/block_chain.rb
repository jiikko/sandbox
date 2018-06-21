class BlockChain
  def initialize
    @blocks = []
    @blocks << BlockChain.genesis_block
  end

  def last_block
  end

  def next_block(transactions)
    height = last_block.height + 1

  end

  def add_block(new_block)
  end

  def self.genesis_block
    Block.genesis_block
  end
end
