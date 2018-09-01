require "mysql2"
require "active_record"
require 'sugoi_bulk_insert'

DB_NAME = "multi_index"

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
  t.integer :account_id
  t.integer :department_id
end
ActiveRecord::Migration.add_index :employees, [:account_id, :department_id]
ActiveRecord::Migration.create_table :departments do |t|
  t.string :name
end

class Employee < ActiveRecord::Base
  belongs_to :department
end
class Department < ActiveRecord::Base
  has_many :employees
end

b = SugoiBulkInsert.new(table_name: "employees", count: 100000) do |x|
  x.column :name, 'aaaa'
  x.column :account_id, 1...40000
  x.column :department_id, 1...40000
end
6.times { b.fire }

# 複合インデックスは順番が大事
Employee.where(account_id: 3)     # インデックス聞く
Employee.where(department_id: 3)  # 効かない
