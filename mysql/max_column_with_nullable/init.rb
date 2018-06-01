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
  ActiveRecord::Migration.add_index :menu_items, [:menu_id, :updated_at]
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
# (38.8ms)  SELECT MAX(`menu_items`.`updated_at`) FROM `menu_items` WHERE `menu_items`.`menu_id` = 1 AND `menu_items`.`category_id` IN (SELECT `categories`.`id` FROM `categories` WHERE `categories`.`menu_id` = 1)
menu.menu_items.where(category: menu.categories).maximum(:updated_at)

# slow
# (35.7ms)  SELECT MAX(`menu_items`.`updated_at`) FROM `menu_items` INNER JOIN `categories` ON `categories`.`id` = `menu_items`.`category_id` WHERE `menu_items`.`menu_id` = 1
menu.menu_items.joins(:category).maximum(:updated_at)

# fast
# (0.7ms)  SELECT  `menu_items`.`updated_at` FROM `menu_items` INNER JOIN `categories` ON `categories`.`id` = `menu_items`.`category_id` WHERE `menu_items`.`menu_id` = 1 ORDER BY menu_items.updated_at desc LIMIT 1
menu.menu_items.joins(:category).order('menu_items.updated_at desc').limit(1).pluck(:updated_at).first
