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
  ActiveRecord::Migration.add_index :menu_items, [:menu_id, :category_id, :updated_at]
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
