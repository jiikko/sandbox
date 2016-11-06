require 'pry'

class TreeSortedList
  class << self
    attr_accessor :divisors
  end

  class Node
    def initialize(root)
      @root = root
    end

    def calc
      r = []
      if next_diff.zero?
        return @root
      end

     r << Node.new(next_low_root).calc
     r << Node.new(next_high_root).calc
     r
    end

    def next_low_root
      @root - next_diff
    end

    def next_high_root
      next_diff + @root
    end

    private

    def next_diff
      (@root / 2).to_i
    end
  end

  def initialize(root)
    @node = Node.new(root)
    TreeSortedList.divisors =
  end

  def generate
    @node.calc
  end

  def create_divisors(i)
    # http://qiita.com/seinosuke/items/fde2e0471dcf937e5a09
    # http://syoshinsyakangeisagi.blogspot.jp/2014/12/ruby_5.html
  end
end

list = TreeSortedList.new(5).generate

