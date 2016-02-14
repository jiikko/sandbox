def animal(&block)
  cat(&block)
end

def cat(&block)
  yield
end


class Dog
end
animal { puts 'hell cat' }
