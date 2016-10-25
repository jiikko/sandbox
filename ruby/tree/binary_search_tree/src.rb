class Tree
  class Node
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
          @children[0] = Node.new(i, parent: self)
        end
      else
        high_node = @children[1]
        if high_node
          high_node.add(i)
        else
          @children[1] = Node.new(i, parent: self)
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
      @children.empty?
    end

    def find(i)
     if @myself == i
       return true
     end
     return if leaf?

     if @myself > i
       @children[0].find(i)
     else
       @children[1].find(i)
     end
    end
  end

  attr_reader :node

  def initialize(i)
    @node = Node.new(i)
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
end
