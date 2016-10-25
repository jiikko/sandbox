# 二分探索木を作る
https://ja.wikipedia.org/wiki/%E4%BA%8C%E5%88%86%E6%8E%A2%E7%B4%A2%E6%9C%A8

## IF例
```ruby
tree = Tree.new(10)
tree.add(3)
tree.add(7)
tree.add(11)
tree.add(1)
tree.add(20)
tree.add(21)
tree.add(22)
tree.add(13)
```

* ノードを追加できるようにする
  * https://github.com/jiikko/sandbox/blob/b30e39b6bd47066962efa776a5756c755f6a72be/ruby/tree/tree.rb
* 順番に標準出力へ表示する
  * https://github.com/jiikko/sandbox/blob/3c773d533f36cc266489d11ec1c73a2ea77b592f/ruby/tree/normal_tree/src.rb
* 深さを出力する
  * https://github.com/jiikko/sandbox/commit/a1056d1a516762fd54564cd50cca71e547164fd4
* 木のカタチをビジュアライズして表示する
* ノードを探索できるようにする
* ノードを削除できるようにする
