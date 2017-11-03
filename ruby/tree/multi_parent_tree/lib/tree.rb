class Tree
  class Node
    attr_accessor :name, :children

    def initialize(name: nil)
      @children = []
      @name = name
    end

    def add(node, parent: )
      if parent == :root
        children << node
      else
        parent.children << node
      end
    end

    def print(depth=0)
      case
      when depth > 1
          puts "#{'--'*depth} #{name}"
      when depth == 1
        puts "| #{name}"
      end
      children.each do |child|
        child.print(depth+1)
      end
    end
  end
end
