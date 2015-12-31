require "mysql2"
require "active_record"
require 'sugoi_bulk_insert'

DB_NAME = "has_many_joins"

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
