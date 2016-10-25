# Rails/Trouble
## rspecでテストが失敗した時のスタックトレースが短い
rspecでのスタックトレースは短くデバックが難しいので、binding.pryするなりして下記を実行すると詳細なスタックトレースが見れる
```ruby
begin
  rails
rescue Exception => e
  STDERR.puts e.backtrace.join("\n")
end
```

## jpmobile と railsの対応表
https://github.com/jpmobile/jpmobile/wiki/Version-:-Jpmobile-vs-Rails
