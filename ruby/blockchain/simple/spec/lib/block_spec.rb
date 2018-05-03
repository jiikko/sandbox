require 'spec_helper'

describe Block do
  describe '#equeal?' do
    context 'difflence object' do
      it 'be false' do
        block1 = Block.new(index: 0, prev_hash: '3', timestamp: 1, data: 't')
        block2 = Block.new(index: 1, prev_hash: '3', timestamp: 1, data: 't')
        expect(block1.equeal?(block2)).to eq(false)
        block1 = Block.new(index: 1, prev_hash: '3', timestamp: 1, data: 't')
        block2 = Block.new(index: 1, prev_hash: '5', timestamp: 1, data: 't')
        expect(block1.equeal?(block2)).to eq(false)
        block1 = Block.new(index: 1, prev_hash: '3', timestamp: 1, data: 't')
        block2 = Block.new(index: 1, prev_hash: '3', timestamp: 2, data: 't')
        expect(block1.equeal?(block2)).to eq(false)
        block1 = Block.new(index: 1, prev_hash: '3', timestamp: 1, data: 't')
        block2 = Block.new(index: 1, prev_hash: '3', timestamp: 1, data: 'r')
        expect(block1.equeal?(block2)).to eq(false)
      end
    end

    context 'same object' do
      it 'be true' do
        block1 = Block.new(index: 0, prev_hash: '3', timestamp: 1, data: 't')
        block2 = Block.new(index: 0, prev_hash: '3', timestamp: 1, data: 't')
        expect(block1.equeal?(block2)).to eq(true)
        expect(block1.equeal?(block1)).to eq(true)
      end
    end
  end
end
