# sed
OSXに入っているsedはbsdでdebianなどに入っているsedはgnuなのでメタ文字が微妙に異なる.

# OSXでいつものように書きたい
## brew install gnu-sed
bsd sedを使わない

## -Eを有効にする
gnu sedだと`?`だとバックスラッシュが必要だけど拡張正規表現
```shell
echo 'http_https' | sed -E -e 's|https?||g'
```

```
BSD sedがイケてないのではなく、
GNU sedが独自で拡張正規表現を実装していただけっぽい。
```

http://blog.kenjiskywalker.org/blog/2014/07/18/sed-bre/
