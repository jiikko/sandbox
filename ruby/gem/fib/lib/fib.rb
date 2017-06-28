require "fib/version"
require "fib/fib"

module Fib
  def self.ruby(n)
    if(n < 2)
      return n
    else
      return ruby(n - 1) + ruby(n - 2)
    end
  end

  def self.ruby2(n)
    a, b = 0, 1
    n.times do
      a, b = b, a + b
    end
    a
  end
end
