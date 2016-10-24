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

  def initialize(i)
    @root = Node.new(i)
  end

  def add(i)
    @root.add(i)
    true
  end

  def nodes
    @root.nodes
  end

  def nodes_with_to_s
    @root.nodes_with_to_s
  end
end

tree = Tree.new(10)
tree.add(3)
tree.add(7)
tree.add(11)
tree.add(1)
tree.add(20)
tree.add(21)
tree.add(22)
tree.add(13)

puts tree.children # =>
puts tree.mix # => 1
puts tree.max # => 20
