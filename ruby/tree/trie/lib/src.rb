# load 'src.rb'; t = Trie.new; t.add('dd'); t.add('ccc')
class Trie
  class Node
    def initialize(string)
      @nodes = []
      @myself = string
    end

    def add(string)
      node = @nodes.find { |node| node.to_s == string[0] }
      if node.nil?
        node = Node.new(string[0])
        @nodes << node
      end
      node.add(string[1..-1]) if string[1..-1] != ''
      self
    end

    def to_s
      @myself
    end

    def find(string)
      return true if string == ''
      node = @nodes.find { |node| node.to_s == string[0] }
      if node
        return node.find(string[1..-1])
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
