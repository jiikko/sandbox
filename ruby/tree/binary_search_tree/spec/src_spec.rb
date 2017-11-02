require './src'
require 'pry'

describe Tree do
  describe '#add' do
    it 'add node' do
      #             10
      #        03       12
      #     01    04      14
      #       02        13  20

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
      binding.pry
      tree.tree_view
    end
  end

  describe '#max_depth' do
    it 'print max depth' do
      tree = Tree.new(10)
      expect(tree.max_depth).to eq 0

      tree = Tree.new(10)
      tree.add(3)
      expect(tree.max_depth).to eq 1

      tree = Tree.new(10)
      tree.add(3)
      tree.add(12)
      tree.add(1)
      expect(tree.max_depth).to eq 2

      tree = Tree.new(10)
      tree.add(3)
      tree.add(12)
      tree.add(14)
      tree.add(13)
      tree.add(20)
      tree.add(4)
      tree.add(1)
      tree.add(2)
      expect(tree.max_depth).to eq 3
    end
  end

  describe '#find' do
    it 'return node' do
      tree = Tree.new(10)
      expect(tree.find(1)).to be_nil
      tree.add(3)
      tree.add(12)
      tree.add(14)
      tree.add(13)
      tree.add(20)
      expect(tree.find(3).to_s).to eq '3'
      expect(tree.find(20).to_s).to eq '20'
    end
  end

  describe '#remove' do
    context 'when remove root node' do
      it 'remove node' do
        skip
      end
    end
    context '削除するnodeに子がいる場合' do
      context '削除するnodeの右nodeがいなくて、左だけがいる時' do
        it 'remove node' do
          #             10
          #        03       12
          #     01    04      14
          #       02       13    20 <= remove
          #                    18 <= next
          #                  17  19
          tree = Tree.new(10)
          tree.add(3)
          tree.add(12)
          tree.add(14)
          tree.add(13)
          tree.add(20)
          tree.add(18)
          tree.add(19)
          tree.add(17)
          tree.add(4)
          tree.add(1)
          tree.add(2)
          tree.remove(20)
          expect(tree.nodes[0].to_i).to eq 3
          expect(tree.nodes[1].nodes[1].nodes[1].to_i).to eq 18
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[0].to_i).to eq 17
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[1].to_i).to eq 19
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[0].parent.to_i).to eq 18
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[1].parent.to_i).to eq 18

          #             10
          #        03       12
          #     01    04      14
          #       02       13    20
          #                    18
          #                  17  19
          #                16 <= remove
          #              15 <= next
          tree = Tree.new(10)
          tree.add(3)
          tree.add(12)
          tree.add(14)
          tree.add(13)
          tree.add(20)
          tree.add(18)
          tree.add(19)
          tree.add(17)
          tree.add(16)
          tree.add(15)
          tree.add(4)
          tree.add(1)
          tree.add(2)
          tree.remove(16)
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[0].nodes[0].to_i).to eq 17
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[0].nodes[0].nodes[0].to_i).to eq 15
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[0].nodes[0].nodes[0].parent.to_i).to eq 17

          #             10
          #        03      12
          #     01    04      14
          #       02       13    20
          #                    18 <= remove
          #                  15 <= next
          #                    16
          tree = Tree.new(10)
          tree.add(3)
          tree.add(12)
          tree.add(14)
          tree.add(13)
          tree.add(20)
          tree.add(18)
          tree.add(15)
          tree.add(16)
          tree.add(4)
          tree.add(1)
          tree.add(2)
          tree.remove(18)
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[0].to_i).to eq 15
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[0].nodes[1].to_i).to eq 16
          expect(tree.nodes[1].nodes[1].nodes[1].nodes[0].nodes[1].parent.to_i).to eq 15
        end
      end
    end
    context '削除するnodeの右nodeがいる時' do
      context 'when deep' do
        it 'remove node' do
          #                       10
          #        remove => 8              12
          #                6   9 <= n     14  20
          #              5              13
          #            1
          tree = Tree.new(10)
          tree.add(8)
          tree.add(12)
          tree.add(14)
          tree.add(13)
          tree.add(20)
          tree.add(6)
          tree.add(9)
          tree.add(5)
          tree.add(1)
          tree.remove(8)
          expect(tree.nodes[0].nodes[0].to_i).to eq 6
          expect(tree.nodes[0].nodes[0].parent.to_i).to eq 9
          expect(tree.nodes[0].to_i).to eq 9
        end
        context 'when shallow' do
          it 'remove node' do
            tree = Tree.new(10)
            tree.add(4)
            tree.add(3)
            tree.add(5)
            tree.add(6)
            tree.remove(4)
            expect(tree.nodes[0].to_i).to eq 5
            expect(tree.nodes[0].nodes[1].to_i).to eq 6
            expect(tree.nodes[0].nodes[1].parent.to_i).to eq 5
            expect(tree.find(5).parent.to_i).to eq 10
            expect(tree.nodes[0].nodes[0].to_i).to eq 3
            expect(tree.nodes[0].nodes[0].parent.to_i).to eq 5
          end
        end
      end
    end
    context '削除するnodeに子がいない場合' do
      it 'remove node' do
        tree = Tree.new(10)
        tree.add(3)
        expect(tree.find(3)).not_to be_nil
        tree.remove(3)
        expect(tree.find(3)).to be_nil

        tree.add(3)
        expect(tree.find(3)).not_to be_nil
        tree.remove(3)
        expect(tree.find(3)).to be_nil
      end
    end
  end
end
