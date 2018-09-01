# require "./gap_lock/init"
@db_name = "gap_lock"
require './mysql_helper'

ActiveRecord::Migration.create_table :users do |t|
  t.string :guid
  t.date :on
  t.integer :position

  t.index :position, unique: true
  t.index [:guid, :on]
end

class User < ActiveRecord::Base
end

User.create!(position: 4, guid: "aaa", on: Date.today)
User.create!(position: 5, guid: "aab", on: Date.today)
User.create!(position: 7, guid: "abd", on: Date.today)
User.create!(position: 8, guid: "abf", on: Date.today)
User.create!(position: 9, guid: "abg", on: Date.today)

<<-SQL
+----+----------+
| id | position |
+----+----------+
|  1 |        4 |
|  2 |        5 |
|  4 |        7 |
|  5 |        8 |
|  6 |        9 |
+----+----------+


select * from users;

# testing gap lock ブロックされるケース
4 ~ 0 がギャップロックされる
4の隣のインデックスに入る余地のある範囲はロックされる
## t1
1) begin;
3) select * from users where position = 4 lock in share mode;

## t2
2) begin;
4) INSERT INTO `users` (`position`) VALUES (3);


# testing gap lock ブロックされるケース
4 ~ 0 がギャップロックされる
4の隣のインデックスに入る余地のある範囲はロックされる
## t1
1) begin;
3) select * from users where position = 4 lock in share mode;

## t2
2) begin;
4) INSERT INTO `users` (`position`) VALUES (2);


# testing gap lock ブロックされるケース
4 ~ 0 がギャップロックされる
4の隣のインデックスに入る余地のある範囲はロックされる
## t1
1) begin;
3) select * from users where position = 4 lock in share mode;

## t2
2) begin;
4) INSERT INTO `users` (`position`) VALUES (5);


# testing gap lock ブロックされないケース
4の隣のインデックスに入る余地のある範囲はロックされる
## t1
1) begin;
3) select * from users where position = 4 lock in share mode;

## t2
2) begin;
4) INSERT INTO `users` (`position`) VALUES (11);





select * from users where id = 2 for update;










SQL


