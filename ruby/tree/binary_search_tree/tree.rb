class Tree
  attr_reader :node

  def initialize(i)
    @node = Tree::Node.new(i)
  end

  def print
    @node.r_print(0)
  end

  def add(i)
    node.add(i)
    true
  end

  def nodes
    node.nodes
  end

  def nodes_with_to_s
    node.nodes_with_to_s
  end

  def max_depth
    node.max_depth(0)
  end

  def find(i)
    node.find(i)
  end

  def remove(i)
    node.remove(i)
  end
end
