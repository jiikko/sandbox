require 'prime'
require 'pry'

class TreeSortedList
  class << self
    attr_accessor :sorted_list, :divisors
  end

  class Node
    attr_accessor :root, :parent

    def initialize(root, parent: nil)
      @root = root
      @parent = parent
    end

    def calc(list = TreeSortedList.divisors)
      r = []
      diff = list.first
      if @parent
        TreeSortedList.sorted_list << @root
      end
      if list.empty?
        return
      end

      next_list = list[1..-1]
      r << Node.new(next_low_root(diff) , parent: self).calc(next_list)
      r << Node.new(next_high_root(diff), parent: self).calc(next_list)
      r
    end

    def next_low_root(diff)
      @root - diff
    end

    def next_high_root(diff)
      diff + @root
    end
  end

  def self.create_divisors(i)
    divisors = Prime.prime_division(i).inject([]) do |a, v|
      v[1].times { a << v[0] }
      a
    end
    divisors.sort.reverse
  end

  def initialize(i)
    @node = Node.new(i)
    TreeSortedList.divisors = self.class.create_divisors(i)
    TreeSortedList.sorted_list = []
  end

  def generate
    @node.calc
    TreeSortedList.sorted_list
  end
end

# list = TreeSortedList.new(5).generate

# load './lib/tree_sorted_list.rb'; TreeSortedList.new(10).generate
# load './lib/tree_sorted_list.rb'; TreeSortedList.new(10).generate; TreeSortedList.sorted_list
