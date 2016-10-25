require './src'
require 'pry'

describe Tree do
  describe '#add' do
    it 'be add node' do
      #             10
      #        03        12
      #     01    04   13  14
      #       02             20

      tree = Tree.new(10)
      tree.add(3)
      tree.add(12)
      tree.add(14)
      tree.add(13)
      tree.add(20)
      tree.add(4)
      tree.add(1)
      tree.add(2)
      expect(tree.nodes[0].to_s).to eq '3'
      expect(tree.nodes[1].to_s).to eq '12'
      expect(tree.nodes[1].nodes[1].to_s).to eq '14'
      expect(tree.nodes[1].nodes[1].nodes[0].to_s).to eq '13'
      expect(tree.nodes[1].nodes[1].nodes[1].to_s).to eq '20'
      expect(tree.nodes[0].nodes[0].to_s).to eq '1'
      expect(tree.nodes[0].nodes[1].to_s).to eq '4'
      expect(tree.nodes[0].nodes[0].nodes[1].to_s).to eq '2'
    end
  end
end
