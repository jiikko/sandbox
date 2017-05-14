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
end
