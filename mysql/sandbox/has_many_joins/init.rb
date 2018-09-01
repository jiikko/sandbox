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

class Employee < ActiveRecord::Base
  belongs_to :department
end
class Department  < ActiveRecord::Base;
  has_many :employees
end


# 部署1と社員1

50_000.times do |i|
  Department.create!(name: "部署#{i}").employees.create!(name: "人#{i}")
end
# select count(*) FROM departments D where exists (select E.department_id from employees E where E.department_id = D.id);
# SELECT distinct count(*) FROM `departments` INNER JOIN `employees` ON `employees`.`department_id` = `departments`.`id`;
# countはjoinのほうが早い
#
#
# これ
#
