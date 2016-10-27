class Tree::Node
  attr_reader :parent

  def initialize(i, parent: nil)
    @myself = i
    @parent = parent
    @children = []
  end

  def add(i)
    if @myself > i
      low_node = @children[0]
      if low_node
        low_node.add(i)
      else
        @children[0] = Tree::Node.new(i, parent: self)
      end
    else
      high_node = @children[1]
      if high_node
        high_node.add(i)
      else
        @children[1] = Tree::Node.new(i, parent: self)
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
    @myself.to_s
  end

  def to_i
    @myself
  end

  def r_print(depth)
    next_depth = nil
    puts "#{depth.to_s}:#{self.to_s}"
    if self.parent.nil?
      next_depth = 1
    else
      next_depth = depth + 1
    end
    @children.each do |node|
      if node
        node.r_print(next_depth)
      else
        next
      end
    end
  end

  def max_depth(current_depth)
    if leaf?
      return current_depth
    end

    if self.parent.nil?
      next_depth = 1
    else
      next_depth = current_depth + 1
    end

    max_depth = 0
    @children.each do |node|
      next if node.nil?
      temp_max = node.max_depth(next_depth)
      if temp_max > max_depth
        max_depth = temp_max
      end
    end
    max_depth
  end

  def leaf?
    @children.compact.empty?
  end

  def find(i)
    if @myself == i
      return self
    end

    if @myself > i
      @children[0].find(i)
    else
      @children[1].find(i)
    end
  end

  def remove(i)
    found_node = find(i)
    right_lowest_node = found_node.nodes[1] && found_node.nodes[1].lowest_node
    local_lowest_node = found_node.nodes[0] unless right_lowest_node
    if local_lowest_node
      n = found_node.parent.nodes[0]
      if found_node == n
        found_node.parent.nodes[0] = local_lowest_node
      end
      n = found_node.parent.nodes[1]
      if found_node == n
        found_node.parent.nodes[1] = local_lowest_node
      end
    else
      n = found_node.parent.nodes[0]
      if found_node == n
        found_node.parent.nodes[0] = nil
      end
      n = found_node.parent.nodes[1]
      if found_node == n
        found_node.parent.nodes[1] = nil
      end
    end
  end

  protected

  def lowest_node
    if leaf? || nodes[0].nil?
      return self
    end
    nodes[0].lowest_node
  end
end
