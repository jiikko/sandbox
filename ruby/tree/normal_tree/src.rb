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

    def r_print
      puts self.to_s
      @children.each do |node|
        if node
          node.r_print
        else
          next
        end
      end
    end
  end

  attr_reader :node

  def initialize(i)
    @node = Node.new(i)
  end

  def print
    @node.r_print
  end
end
