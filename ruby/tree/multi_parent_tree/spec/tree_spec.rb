require 'spec_helper'

describe Tree::Node do
  describe '#print' do
    it 'be print to aa' do
      tree = Tree::Node.new
      root1 = Tree::Node.new(name: :root1)
      root2 = Tree::Node.new(name: :root2)
      child = Tree::Node.new(name: :child)
      child_child = Tree::Node.new(name: :child_child)
      child_of_root2 = Tree::Node.new(name: :child_of_root2)
      tree.add(root1, parent: :root)
      tree.add(root2, parent: :root)
      tree.add(child, parent: root1)
      tree.add(child_child, parent: child)
      tree.add(child_of_root2, parent: root1)
      tree.add(child_of_root2, parent: root2)
      # root1 
      # | |__ child1
      # |    |__ child2
      # |
      # root2
      #   |__ child_of_root2
      puts tree.print
    end
  end

  describe '#add' do
    context 'only root' do
      before do
        @tree = Tree::Node.new
        root1 = Tree::Node.new(name: :root1)
        root2 = Tree::Node.new(name: :root2)
        @tree.add(root1, parent: :root)
        @tree.add(root2, parent: :root)
      end
      it 'be added' do
        expect(@tree.children.size).to eq(2)
        expect(@tree.children.map(&:name)).to eq([:root1, :root2])
      end
    end

    context 'with child' do
      before do
        @tree = Tree::Node.new
        @root1 = Tree::Node.new(name: :root1)
        root2 = Tree::Node.new(name: :root2)
        @child = Tree::Node.new(name: :child)
        @child_child = Tree::Node.new(name: :child)
        @tree.add(@root1, parent: :root)
        @tree.add(root2, parent: :root)
        @tree.add(@child, parent: @root1)
      end
      it 'be added' do
        expect(@tree.children.size).to eq(2)
        expect(@tree.children.map(&:name)).to eq([:root1, :root2])
        child_list = @tree.children.first.children
        expect(child_list.size).to eq(1)
        expect(child_list.first.name).to eq(:child)
      end
      it 'has reference of parents' do
        expect(@child.parents).to eq([@root1])
      end
      context 'when 4 depth' do
        it 'has reference of parents and children' do
          child_level2 = Tree::Node.new(name: :child_level2)
          child_level3 = Tree::Node.new(name: :child_level3)
          child_level4 = Tree::Node.new(name: :child_level4)
          child_level4_2 = Tree::Node.new(name: :child_level4_2)
          @tree.add(child_level2,   parent: @child)
          @tree.add(child_level3,   parent: child_level2)
          @tree.add(child_level4,   parent: child_level3)
          @tree.add(child_level4_2, parent: child_level3)

          expect(child_level4.parents).to eq([child_level3])
          expect(child_level4_2.parents).to eq([child_level3])
          expect(child_level3.children).to match_array([child_level4, child_level4_2])
        end
      end
    end
  end
end
