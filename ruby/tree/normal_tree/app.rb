# I/Fを持つクラスを作成
#   データが正しく順番に格納されているか確認する
# 順番に標準出力へ表示する
# 木のカタチをビジュアライズして表示する
# 深さを出力する
# 回転する

require 'src'

tree = Tree.new(10)
tree.node.add(3)
tree.node.add(7)
tree.node.add(11)
tree.node.add(1)
tree.node.add(20)
tree.node.add(21)
tree.node.add(22)
tree.node.add(13)

puts tree.node.children # =>
puts tree.node.nodes_with_to_s[0] # => 3
puts tree.node.nodes_with_to_s[1] # => 7
puts tree.node.nodes[0].nodes_with_to_s[0] # => 1
puts tree.mix # => 1
puts tree.max # => 20

tree.print
