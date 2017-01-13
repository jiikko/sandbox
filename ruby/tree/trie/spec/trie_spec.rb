require 'spec_helper'

describe Trie do
  describe '#add' do
    context '3moziの時' do
      it '3つの要素が追加されること' do
      trie = Trie.new
      trie.add('ccc')
      expect(trie.nodes.first.nodes.first.nodes.size).to eq 1
      end
    end
  end

  describe '#find' do
    it 'be success' do
      trie = Trie.new
      trie.add('dd')
      trie.add('ccc')
      expect(trie.find('f')).to eq false
      expect(trie.find('dd')).to eq true
      expect(trie.find('d')).to eq true
      expect(trie.find('d')).to eq true
      expect(trie.find('cc')).to eq true
      expect(trie.find('ccc')).to eq true
    end
  end
end
