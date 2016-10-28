require 'pry'

class TreeSortedList
  class Node
    def initialize(root)
      @root = root
    end

    def calc
      r = []
      binding.pry
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
  end

  def generate
    @node.calc
  end
end

list = TreeSortedList.new(5).generate
