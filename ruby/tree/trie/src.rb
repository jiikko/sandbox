class Trie
  class Node
    def initialize(string)
      @children = []
      @myself = string
    end

    def add(string)
      prefix_string = string[0]
      node = @children.select do |child|
        child.to_s == prefix_string
      end
      if node.empty?
        node = Node.new(prefix_string)
        string[1..-1].each_char { |char| node.add(char) }
        @children << node
      else
        # TODO
      end
      self
    end

    def to_s
      @myself
    end
  end

  def initialize
    @node = Node.new(nil)
  end

  def add(string)
    @node.add(string)
  end
end
