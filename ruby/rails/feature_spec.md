# FeatureSpec
ブラウザが広告配信との通信でテスト実行時間が引っ張られることがある

## spec/spec_helper.rb
```ruby
  driver.browser.url_blacklist = File.open("#{Rails.root}/spec/support/blacklist_for_feature").lines.map(&:chomp)
```

以下、ログ出力を有効にしたログからブロックするホスト名をファイルに吐き出す
```shell
#/bin/bash

sed -i '' -e 's/# driver.enable_logging/driver.enable_logging/' spec/spec_helper.rb
export LOAD_ALL_FIXTURES_BEFORE_SUITE=yes
if [[ $(which xvfb-run) ]]; then
  xvfb-run bundle exec rake spec:features > l1  2>&1
  xvfb-run bundle exec rake spec:features >> l1 2>&1
  xvfb-run bundle exec rake spec:features >> l1 2>&1
  xvfb-run bundle exec rake spec:features >> l1 2>&1
else
  bundle exec rake spec:features > l1  2>&1
  bundle exec rake spec:features >> l1 2>&1
  bundle exec rake spec:features >> l1 2>&1
  bundle exec rake spec:features >> l1 2>&1
fi
# 冪等性なさそう
sed -i '' -e 's/driver.enable_logging/# driver.enable_logging/' spec/spec_helper.rb

cat l1 | grep 'Received 200' | \
  grep -v map.yahooapis.jp | \
  grep -v 127.0.0.1 | \
  grep -o 'from "https\?://[0-9a-z\._-]\+/' | \
  sed -E -e 's|from "https?://(.+)\/|\1|' | \
  sort | \
  uniq > alll

```

* バックグラウンドジョブにしたかったけどプロセス毎に接続するDBをかえたい
