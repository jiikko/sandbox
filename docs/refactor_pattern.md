# リファクタリングパターン
## 返却用の一時変数
```ruby
def func(arg)
  arg ? nil : {}
end

def a_func
  if condition
    ps = b_func(arg)
    return ps if ps # ps is not refarenced
  end

  [...]
end
```
