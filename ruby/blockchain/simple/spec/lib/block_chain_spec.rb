require 'spec_helper'

describe BlockChain do
  describe '#get_latest_block' do
    context 'when empty chain' do
      it 'get genesis block' do
        expect(BlockChain.new.get_latest_block.data).to eq("I am genesis block!")
      end
    end
  end

  describe '#generate_next_block' do
    it 'return block' do
      block_chain = BlockChain.new
      expect(block_chain.generate_next_block('second')).to be_a(Block)
    end
  end

  describe '#add_block' do
    context 'when same genesis and difference instance of BlockChain' do
      it 'return true' do
        block_chain1 = BlockChain.new
        block_chain2 = BlockChain.new
        return_value = block_chain1.generate_next_block_and_add('second')
        expect(return_value).to eq(true)
      end
    end
    context 'when argments is valid block' do
      it 'return true' do
        block_chain = BlockChain.new
        next_block = block_chain.generate_next_block('second')
        return_value = block_chain.add_block(next_block)
        expect(return_value).to eq(true)
      end
      it 'be success to add to list in block_chain' do
        block_chain = BlockChain.new
        next_block = block_chain.generate_next_block('second')
        block_chain.add_block(next_block)
        expect(block_chain.get_latest_block.equeal?(next_block)).to eq(true)
        expect(block_chain.size).to eq(2)
      end
    end
    context 'when argments is invalid block' do
      it 'be failue to add to list in block_chain' do
        other_block_chain = BlockChain.new
        other_block_chain.generate_next_block_and_add('second')
        other_block = other_block_chain.generate_next_block('third')

        block_chain = BlockChain.new
        return_value = block_chain.add_block(other_block)
        expect(return_value).to eq(false)
        expect(block_chain.size).to eq(1)
      end
    end
  end
end
