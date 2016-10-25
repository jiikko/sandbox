class Tree
  class Node
    def initialize(i)
      @myself = i
      @children = []
    end

    def add(i)
      if @myself > i
        low_node = @children.first
        if low_node
          low_node.add(i)
        else
          @children[0] = Node.new(i)
        end
      else
        high_node = @children.last
        if high_node
          high_node.add(i)
        else
          @children[1] = Node.new(i)
        end
      end
      true
    end

    def nodes
      @children
    end

    def nodes_with_to_s
      [ @children[0].to_s,
        @children[1].to_s,
      ]
    end

    def to_s
      @myself
    end
  end

  attr_reader :node

  def initialize(i)
    @node = Node.new(i)
  end
end

tree = Tree.new(10)
tree.node.add(3)
tree.node.add(7)
tree.node.add(11)
tree.node.add(1)
tree.node.add(20)
tree.node.add(21)
tree.node.add(22)
tree.node.add(13)

puts tree.node.children # =>
puts tree.node.nodes_with_to_s[0] # => 3
puts tree.node.nodes_with_to_s[1] # => 7
puts tree.node.nodes[0].nodes_with_to_s[0] # => 1
puts tree.mix # => 1
puts tree.max # => 20
