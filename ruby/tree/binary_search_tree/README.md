# 二分探索木を作る
* https://ja.wikipedia.org/wiki/木構造\_(データ構造)
* https://ja.wikipedia.org/wiki/%E4%BA%8C%E5%88%86%E6%8E%A2%E7%B4%A2%E6%9C%A8

## IF例
```ruby
tree = Tree.new(10)
tree.add(3)
tree.add(7)
tree.add(11)
tree.add(1)
tree.add(20)
tree.add(21)
```

* ノードを追加できるようにする
```ruby
#             10
#        03        12
#     01    04   13  14
#       02             20
tree = Tree.new(10)
tree.add(3)
tree.add(12)
tree.add(14)
tree.add(13)
tree.add(20)
tree.add(4)
tree.add(1)
tree.add(2)
```

* 順番に標準出力へ表示する
  * https://github.com/jiikko/sandbox/blob/3c773d533f36cc266489d11ec1c73a2ea77b592f/ruby/tree/normal_tree/src.rb
* 深さを出力する
  * https://github.com/jiikko/sandbox/commit/a1056d1a516762fd54564cd50cca71e547164fd4
    * root にあるもう片方の親のカウントができていない
* ノードを探索できるようにする
* ノードを削除できるようにする
* 木のカタチをビジュアライズする

## to run spec
```
bundle exec rspec
```
