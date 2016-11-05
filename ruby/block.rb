class Cat
  def initialize(&block)
    self.instance_eval(&block)
  end

  def hello
    puts 'nyan'
  end
end
Cat.new { hello }


class Cat
  def initialize(&block)
    yield(self)
  end

  def hello
    puts 'nyan'
  end
end
Cat.new { |s| s.hello }
