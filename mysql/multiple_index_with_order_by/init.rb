# require './multiple_index_with_order_by/init'
@db_name = "multiple_index_with_order_by"

require './mysql_helper'
require 'activerecord-import'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/mysql2_adapter'

ActiveRecord::Migration.create_table :menu_items do |t|
  t.integer :menu_id, null: false
  t.integer :category_id

  t.timestamps null: false
  t.index [:menu_id, :updated_at, :category_id]
  t.index [:id, :menu_id, :updated_at, :category_id]
end
ActiveRecord::Migration.add_index :menu_items, [:id, :menu_id, :updated_at, :category_id], name: :index_all

class MenuItem < ActiveRecord::Base
end

10.times do |menu_id|
  MenuItem.import(500.times.map {
    { menu_id: menu_id, category_id: 1 }
  })
  10.times do # 1回のinsertを小さくするために10分割する
    MenuItem.import(10_000.times.map {
      { menu_id: menu_id, category_id: nil }
    })
  end
end


__END__

explain  SELECT `menu_items`.* FROM `menu_items` WHERE (`menu_items`.`updated_at` BETWEEN '2010-12-31 15:00:00' AND '2018-06-21 12:36:33' and menu_id = 1);

explain  SELECT `menu_items`.* FROM `menu_items` WHERE (`menu_items`.`updated_at` BETWEEN '2010-12-31 15:00:00' AND '2018-06-21 12:36:33' and menu_id = 1) order by id;

explain  SELECT `menu_items`.* FROM `menu_items` WHERE (`menu_items`.`updated_at` BETWEEN '2010-12-31 15:00:00' AND '2018-06-21 12:36:33' and menu_id = 1) order by id limit 100;

explain SELECT `menu_items`.* FROM `menu_items` WHERE (`menu_items`.`updated_at` BETWEEN '2010-12-31 15:00:00' AND '2018-06-21 12:36:33' and menu_id = 1 order by id limit 100;


# items
## all items => fast
explain SELECT `menu_items`.* FROM `menu_items` WHERE (updated_at BETWEEN '2010-12-31 15:00:00' AND '2018-06-21 12:36:33' and menu_id = 1 and id > 0) order by id limit 100;

## visible items => fast
explain  SELECT `menu_items`.* FROM `menu_items` WHERE (`menu_items`.`updated_at` BETWEEN '2010-12-31 15:00:00' AND '2018-06-21 12:36:33' and menu_id = 1 and id > 0 and category_id is not null) order by id limit 100;


# max
## visible max => fast
## using (index [:menu_id, :category_id, :updated_at]), name: index_menu_items_on_menu_id_and_category_id_and_category_id
explain SELECT max(updated_at) FROM `menu_items` WHERE (menu_id = 1 and category_id is not null)\G

## all max => fast
## using (index [:menu_id, :updated_at])
SELECT max(updated_at) FROM `menu_items` WHERE menu_id = 1;



mysql> explain sELECT `menu_items`.* FROM menu_items WHERE (updated_at BETWEEN '2010-12-31 15:00:00' AND '2018-06-21 12:36:33' and menu_id = 1 and id > 101298 and category_id is not null) order by id desc limit 100\G
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: menu_items
   partitions: NULL
         type: range
possible_keys: PRIMARY,index_menu_items_on_id_and_menu_id_and_updated_at,index_all,old_index,index_menu_items_on_menu_id_and_updated_at_and_category_id,index_menu_items_on_menu_id_and_category_id_and_category_id
          key: index_menu_items_on_menu_id_and_category_id_and_category_id
      key_len: 9
          ref: NULL
         rows: 500
     filtered: 5.55
        Extra: Using index condition; Using where; Using filesort
1 row in set, 1 warning (0.00 sec)
