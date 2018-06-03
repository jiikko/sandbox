# require './max_column_with_nullable/init'

@db_name = __FILE__
require './mysql_helper'

class Menu < ActiveRecord::Base
  has_many :menu_items
  has_many :categories

  ActiveRecord::Migration.create_table self.table_name do |t|
    t.timestamps null: false
  end
end

class MenuItem < ActiveRecord::Base
  belongs_to :category

  ActiveRecord::Migration.create_table self.table_name do |t|
    t.string :name, null: false
    t.integer :menu_id, null: false
    t.integer :category_id, null: true
    t.timestamps null: false
  end
  ActiveRecord::Migration.remove_index :menu_items, [:menu_id, :updated_at]
  ActiveRecord::Migration.add_index :menu_items, [:menu_id, :updated_at]
  ActiveRecord::Migration.add_index :menu_items, [:menu_id, :updated_at, :category_id]
  ActiveRecord::Migration.remove_index :menu_items, [:menu_id, :updated_at, :category_id]
  ActiveRecord::Migration.add_index :menu_items, [:menu_id, :category_id, :updated_at]
  ActiveRecord::Migration.add_index :menu_items, [:updated_at]
end

class Category< ActiveRecord::Base;
  has_many :menu_items

  ActiveRecord::Migration.create_table self.table_name do |t|
    t.string :name, null: false
    t.integer :menu_id, null: false, index: true
    t.timestamps null: false
  end
end

ActiveRecord::Base.transaction do
  menu = Menu.create!
  20.times do |i|
    category = menu.categories.create!(name: "name_#{i}")
    2_000.times do |ii|
      menu.menu_items.create!(name: "name_#{i}_#{ii}", category: category)
    end
    1_000.times do |ii|
      menu.menu_items.create!(name: "hidden_name_#{i}_#{ii}", category: nil)
    end
  end
end

# mysql> show create table menu_items\G;
# *************************** 1. row ***************************
#        Table: menu_items
# Create Table: CREATE TABLE `menu_items` (
#   `id` bigint(20) NOT NULL AUTO_INCREMENT,
#   `name` varchar(255) NOT NULL,
#   `menu_id` int(11) NOT NULL,
#   `category_id` int(11) DEFAULT NULL,
#   `created_at` datetime NOT NULL,
#   `updated_at` datetime NOT NULL,
#   PRIMARY KEY (`id`),
#   KEY `index_menu_items_on_menu_id_and_updated_at` (`menu_id`,`updated_at`)
# ) ENGINE=InnoDB AUTO_INCREMENT=60001 DEFAULT CHARSET=utf8
# 1 row in set (0.00 sec)


# irb(main):093:0> menu.menu_items.where.not(category: nil).count
# D, [2018-06-01T23:15:19.780740 #38640] DEBUG -- :    (112.3ms)  SELECT COUNT(*) FROM `menu_items` WHERE `menu_items`.`menu_id` = 1 AND (`menu_items`.`category_id` IS NOT NULL)
# => 40000
# irb(main):094:0> menu.menu_items.where(category: nil).count
# D, [2018-06-01T23:15:22.688323 #38640] DEBUG -- :    (139.1ms)  SELECT COUNT(*) FROM `menu_items` WHERE `menu_items`.`menu_id` = 1 AND `menu_items`.`category_id` IS NULL
# => 20000
# irb(main):095:0> menu.menu_items.count
# D, [2018-06-01T23:15:29.301139 #38640] DEBUG -- :    (27.9ms)  SELECT COUNT(*) FROM `menu_items` WHERE `menu_items`.`menu_id` = 1
# => 60000

menu = Menu.last

# slow
# (324.0ms)  SELECT MAX(`menu_items`.`updated_at`) FROM `menu_items` WHERE `menu_items`.`menu_id` = 1 AND (exists(select 1 from categories where menu_items.category_id = categories.id))
menu.menu_items.where('exists(select 1 from categories where menu_items.category_id = categories.id)').maximum(:updated_at)

# slow
# (170.7ms)  SELECT MAX(`menu_items`.`updated_at`) FROM `menu_items` WHERE `menu_items`.`menu_id` = 1 AND `menu_items`.`category_id` IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
menu.menu_items.where(category_id: menu.categories.ids).maximum(:updated_at)

# slow
# (125.9ms)  SELECT MAX(`menu_items`.`updated_at`) FROM `menu_items` WHERE `menu_items`.`menu_id` = 1 AND (`menu_items`.`category_id` IS NOT NULL)
menu.menu_items.where.not(category: nil).maximum(:updated_at)

# slow
menu.menu_items.where.not(category: nil).order('menu_items.updated_at desc').maximum(:updated_at)

# slow
# (38.8ms)  SELECT MAX(`menu_items`.`updated_at`) FROM `menu_items` WHERE `menu_items`.`menu_id` = 1 AND `menu_items`.`category_id` IN (SELECT `categories`.`id` FROM `categories` WHERE `categories`.`menu_id` = 1)
menu.menu_items.where(category: menu.categories).maximum(:updated_at)

# slow
# (35.7ms)  SELECT MAX(`menu_items`.`updated_at`) FROM `menu_items` INNER JOIN `categories` ON `categories`.`id` = `menu_items`.`category_id` WHERE `menu_items`.`menu_id` = 1
menu.menu_items.joins(:category).maximum(:updated_at)

# fast
# updated_at の新しいレコードがnilだと遅い
# (0.7ms)  SELECT  `menu_items`.`updated_at` FROM `menu_items` INNER JOIN `categories` ON `categories`.`id` = `menu_items`.`category_id` WHERE `menu_items`.`menu_id` = 1 ORDER BY menu_items.updated_at desc LIMIT 1
menu.menu_items.joins(:category).order('menu_items.updated_at desc').limit(1).pluck(:updated_at).first

# fast(ActiveRecord::Migration.add_index :menu_items, [:menu_id, :category_id, :updated_at])
# updated_at の新しいレコードがnilでも早い
# (0.8ms)  SELECT  `menu_items`.`updated_at` FROM `menu_items` INNER JOIN `categories` ON `categories`.`id` = `menu_items`.`category_id` WHERE `menu_items`.`menu_id` = 1 ORDER BY category_id desc, menu_items.updated_at desc LIMIT 1
menu.menu_items.joins(:category).order('category_id desc, menu_items.updated_at desc').limit(1).pluck(:updated_at).first
menu.menu_items.where.not(category: nil).order('category_id desc, menu_items.updated_at desc').limit(1).pluck(:updated_at).first

# fast
# updated_at の新しいレコードがnilだと遅い
# (0.7ms)  SELECT  `menu_items`.* FROM `menu_items` WHERE `menu_items`.`menu_id` = 1 AND (`menu_items`.`category_id` IS NOT NULL) ORDER BY menu_items.updated_at desc LIMIT 1
menu.menu_items.where.not(category: nil).order('menu_items.updated_at desc').limit(1).pluck(:updated_at).first


# 全部早くする
menu.menu_items.where.not(category: nil).maximum(:updated_at)
menu.menu_items.where(category: nil).maximum(:updated_at)
menu.menu_items.maximum(:updated_at)

# ActiveRecord::Migration.add_index :menu_items, [:menu_id, :category_id, :updated_at]
