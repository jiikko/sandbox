# グループの中からもっとも最高値のレコードを表示する
* 2通りあるらしい
* http://labs.timedia.co.jp/2014/10/selecting-max-record-in-group-by.html
  * やってない
* max in group した結果を内部結合する
  * 集約関数を通していないカラムをselectするのはMySQLだと動くが意図しない結果が返るのでmaxした結果を結合をする

* ARを使うとこう
```
SponsoredComment.joins("JOIN (SELECT max(momiji_sponsored_comments.updated_at), `momiji_sponsored_comments`.`commentable_id` FROM `momiji_sponsored_comments` GROUP BY commentable_id) as t").
  where("commentable_type = 'SpotProfile' AND t.commentable_id = momiji_sponsored_comments.commentable_id").find_each do |comment|
  [...]
end
```

