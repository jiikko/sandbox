ActiveRecord::Migration.create_table :items do |t|
  t.string :name, null: false
  t.string :group
end

ActiveRecord::Migration.create_table :variations do |t|
  t.string :name, null: false
  t.string :group, null: true
end


class Variation < ActiveRecord::Base
end

class Item < ActiveRecord::Base
end


# 1 : 1







# null: false

Item.create!(name: '普通')
Item.create!(name: '普通')
Item.create!(name: '空文字', group: '')
Item.create!(name: '空文字', group: '')

Variation.create!(name: '普通', group: nil)
Variation.create!(name: '空文字', group: '')


# not_variation_join_sql = "left join (#{the_account.menu.variation_items.to_sql}) t on (t.group = menu_items.group or (t.group = '' and menu_items.group is null)) and t.name = menu_items.name"
# variation_inner_sql = "inner join (#{the_account.menu.variation_items.to_sql}) t on (t.group = menu_items.group or (t.group = '' and menu_items.group is null)) and t.name = menu_items.name"

sql = <<SQL
inner join (#{Variation.all.to_sql}) t on 
  t.group = items.group or (t.group is null and items.group is null)
  and t.name = items.name
SQL

Item.joins(sql)
