# load 'src.rb'; t = Trie.new; t.add('dd'); t.add('ccc')
class Trie
  class Node
    def initialize(string)
      @nodes = []
      @myself = string
    end

    def add(string)
      prefix_string = string[0]
      node = @nodes.find do |child|
        child.to_s == prefix_string
      end
      if node
        string[1..-1].each_char { |char| node.add(char) }
      else
        node = Node.new(prefix_string)
        node.add(string[1..-1]) if string[1..-1]
        @nodes << node
      end
      self
    end

    def to_s
      @myself
    end

    def find(string)
      return true if string == ''
      node = @nodes.find { |node| node.to_s == string[0] }
      if node
        node.find(string[1..-1])
      else
        return false
      end
    end

    def nodes
      @nodes
    end
  end

  def initialize
    @node = Node.new(nil)
  end

  def add(string)
    @node.add(string)
  end

  def find(string)
    @node.find(string)
  end

  def nodes
    @node.nodes
  end
end
