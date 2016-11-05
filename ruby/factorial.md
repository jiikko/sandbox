
```ruby
class Fixnum
  def factorial
    sum = 1
    i = self
    while i > 1 do
      sum *= i
      i -= 1
    end
    sum
  end
end


class Fixnum
  def factorial
    (1..self).to_a.inject(:*)
  end
end
```
