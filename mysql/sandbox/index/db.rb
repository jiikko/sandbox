require "active_record"
require "mysql2"
require 'sugoi_bulk_insert'

DB_NAME = "join_training"

puts `echo 'drop database #{DB_NAME}' | mysql -uroot`
puts `echo 'create database #{DB_NAME}' | mysql -uroot`

config = {
  user: :root,
  password: "",
  :adapter   => "mysql2",
  :encoding  => "utf8",
  :reconnect => true,
  :pool      => 5,
  :database  => DB_NAME
}

ActiveRecord::Base.establish_connection(config)
ActiveRecord::Migration.create_table :employees do |t|
  t.string :name
  t.integer :department_id
end
ActiveRecord::Migration.add_index :employees, :department_id
ActiveRecord::Migration.create_table :departments do |t|
  t.string :name
end
ActiveRecord::Migration.create_table :comments do |t|
  t.string :commentable_type
  t.integer :commentable_id
  t.string :title
  t.text :body
end
ActiveRecord::Migration.add_index :comments, [:commentable_type, :commentable_id]


class Employee < ActiveRecord::Base; end
class Department  < ActiveRecord::Base;
  has_many :employees
end
class Comment < ActiveRecord::Base
end

d = Department.create!(name:  '総務')
d.employees.create!(name: '石田')

d = Department.create!(name:  '人事')
d.employees.create!(name: '小笠原')
d.employees.create!(name: '夏目')

d = Department.create!(name:  '開発')
d.employees.create!(name: '米田')
d.employees.create!(name: '釜本')
d.employees.create!(name: '岩瀬')

d = Department.create!(name:  '営業')

10_000.times do
  Employee.create!(name: '新人')
end


b = SugoiBulkInsert.new(table_name: "comments", count: 30000) do |x|
  x.column :commentable_type, %w(AAA VVV CCC GGG)
  x.column :commentable_id, 1..300
  x.column :title, 'aaaa'
  x.column :body, 'aaaa'
end
600.times { b.fire }
b.fire
