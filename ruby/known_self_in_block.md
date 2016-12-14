# self と インスタンス変数
```ruby
def array_with(&block)
  [:'hello array'].instance_eval(&block)
end

array = array_with do
  @name = :bob
  puts self # array
  self
end # return  [:"hello array"]

puts @name # nil
puts array.instance_eval { @name } # :bob
```
