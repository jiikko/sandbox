# 3
#   \__ 1
#     \____
#     \____ 2
#   \__ 4
# 12
#   \__
#   \__ 14
#     \____ 13
#     \____ 20

class Tree::Node
  module Printer
    def tree_view(node=nil, level: 0, root: false)
      if node.nil? && root
        nodes.each do |n|
          puts n.to_s
          tree_view(n, level: 1)
        end
      else
        node.nodes.each do |n|
          puts "#{'  ' * level}\\#{'__' * level} #{n.to_s}"
          tree_view(n, level: level + 1)
        end
      end
    end
  end
end
