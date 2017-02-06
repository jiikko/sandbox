# Rails::View
## 日時フィールドを改行して単位を付ける
```ruby
= sprintf(f.datetime_select(:expired_at, { class: :span12, time_separator: '%s' , datetime_separator: '%s' , date_separator: '%s' }), '年<br>', '', '', '', '').html_safe
```
