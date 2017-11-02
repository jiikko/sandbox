class Tree::Node
  module Printer
    def tree_view(node=nil, level: 0)
      if node.nil?
        nodes.each do |node|
          puts node.to_s
          tree_view(node, level: 1)
        end
      else
          binding.pry
        puts "| #{'-' * level} #{node.to_s}"
        node.nodes.each do |node|
          tree_view(node, level: level + 1)
        end
      end
    end
  end
end
