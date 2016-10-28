require './modules/formatable'

class Tree::Node
  include Formatable

  attr_accessor :parent

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
    # fail when it not exist children.
    return if leaf?

    if @myself > i
      @children[0].find(i)
    else
      @children[1].find(i)
    end
  end

  def remove(i)
    remove_node = find(i)
    right_lowest_node = remove_node.nodes[1] && remove_node.nodes[1].lowest_node
    left_lowest_node = remove_node.nodes[0] unless right_lowest_node
    next_node = right_lowest_node || left_lowest_node
    if next_node
      # Swich parent pinter and children pointer
      # 10, 4, 3, 5, 6 を入れたとして、4を削除すると

      # 10.nodesのうち remove_node(4)への参照をnext_node(5)に付け替える
      n = remove_node.parent.nodes[0]
      if remove_node == n
        remove_node.parent.nodes[0] = next_node
      end
      n = remove_node.parent.nodes[1]
      if remove_node == n
        remove_node.parent.nodes[1] = next_node
      end

      # 3と5のparent参照を付け替える
      remove_node.nodes[0].parent = next_node if remove_node.nodes[0]
      remove_node.nodes[1].parent = next_node if remove_node.nodes[1]

      # remove_node(4).nodesの参照を新しいnext_node(5)へ付け替える
      if remove_node.nodes[0] == next_node
        remove_node.nodes[0] = next_node.nodes[0]
      elsif remove_node.nodes[1] == next_node
        remove_node.nodes[1] = next_node.nodes[1]
      end
      next_node.parent = remove_node.parent
      next_node.nodes[0] = remove_node.nodes[0]
      next_node.nodes[1] = remove_node.nodes[1]
    else
      n = remove_node.parent.nodes[0]
      if remove_node == n
        remove_node.parent.nodes[0] = nil
      end
      n = remove_node.parent.nodes[1]
      if remove_node == n
        remove_node.parent.nodes[1] = nil
      end
    end
  end

  def collect_nodes(list = {})
    list.merge!({ @myself => nodes_with_to_i })
    nodes.each do |node|
      if node
        list.merge!(node.collect_nodes)
      end
    end
    return list
  end

  protected

  def lowest_node
    if leaf? || nodes[0].nil?
      return self
    end
    nodes[0].lowest_node
  end

  def myself
    @myself
  end
end
