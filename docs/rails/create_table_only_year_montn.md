# 後悔しないための(日がない)年月カラムを持つテーブルの実装

日を持たない要件だったので、年と月が別カラムで持つテーブルを定義したが、実装がめんどくなってきた。
結論は、日を持たないとしてもdate型で定義するのがいい。
ディスク節約といってもコード書かないことに越したことないしなぁ。

```ruby
    create_table :momiji_summarized_month_listing_clicks do |t|
      t.integer :year, null: false
      t.integer :month, null: false
      t.integer :price, null: false, default: 0
      t.integer :listing_account_id, null: false
      t.index [:year, :month, :listing_account_id], unique: true, name: :index_listing_account_and_yyyymm

      t.timestamps null: false
    end
```
# 年月だけを持つテーブルを実装した時にあなたが後悔する12個の理由
### 年を挟んだ範囲検索
レコードが順序を持たないため、2015月11月から2017年01月 を検索する時
```
select *
  from table
  where
    (year = 2015 and (month between 1 and 11) ) or
    (year = 2016 and (month between 1 and 12)) or
    (year = 2017 and (month = 1))
```
みたいに自分で上記のようなクエリを吐くコードを書かないといけないことに気がついてdate型にしてしまえという気持ちになった。
