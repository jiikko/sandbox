# README

## ログの収集
```shell
bundle exec rails s
```

### fluentdの起動
```
cat fluent.conf
  <source>
    @type forward
  </source>
  <match **>
    @type file
    path "./logs"
    <buffer time>
      path "./logs"
    </buffer>
  </match>
</ROOT>

fluentd -c ./fluent.conf
```

```ruby
1000.times { `curl -I http://localhost:3000?p=#{rand(10)}` }
```
