@db_name = __FILE__
require './mysql_helper'

ActiveRecord::Migration.create_table :employees do |t|
  t.string :name
  t.integer :department_id
end
ActiveRecord::Migration.add_index :employees, :department_id
ActiveRecord::Migration.create_table :departments do |t|
  t.string :name
end
ActiveRecord::Migration.create_table :users do |t|
  t.string :name
end
ActiveRecord::Migration.create_table :posts do |t|
  t.string :title
  t.integer :user_id
end
ActiveRecord::Migration.add_index :posts, :user_id

class Employee < ActiveRecord::Base
  belongs_to :department
end
class Department < ActiveRecord::Base
  has_many :employees
end
class User < ActiveRecord::Base
  has_many :posts
end
class Post < ActiveRecord::Base
  belongs_to :user
end

("a".."f").to_a.each do |x|
  Department.create!(name: x)
end

departments = Department.all.to_a
200.times do |i|
  Employee.create!(name: i, department: departments.sample)
end

SugoiBulkInsert.new(table_name: "employees", count: 100000) { |x|
  x.column :name, 'aaaa'
  x.column :department_id, 1
}.fire
SugoiBulkInsert.new(table_name: "employees", count: 100000) { |x|
  x.column :name, 'aaaa'
}.fire

SugoiBulkInsert.new(table_name: "users", count: 1000) { |x|
  x.column :name, 'ウェイ'
}.fire
SugoiBulkInsert.new(table_name: "posts", count: 100000) { |x|
  x.column :title, 'はい'
  x.column :user_id, User.ids
}.fire

Employee.where(department: Department.where(id: 4)).explain
# 相関サブクエリ
Employee.where("exists (#{Department.where(id: 4).where('employees.department_id = departments.id').to_sql}) ").explain


User.where(id: Post.where(id: Post.select(:id)).select(:user_id))
User.joins(:posts).where(posts: { id: Post.select(:id) }).explain



