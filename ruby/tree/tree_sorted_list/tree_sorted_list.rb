require 'pry'
require 'prime'

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
    divisors = Prime.prime_division(i).inject([]) do |a, v|
      v[1].times { a << v[0] }
      a
    end
    divisors.sort.reverse
  end
end

list = TreeSortedList.new(5).generate

