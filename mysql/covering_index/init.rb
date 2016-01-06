# cd ./mysql/covering_index
# $ bunsle exec irb
# require "covering_index/init"

DB_NAME = "covering_index"

require './mysql_helper'

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


b = SugoiBulkInsert.new(table_name: "employees", count: 100000) do |x|
  x.column :name, 'aaaa'
  x.column :department_id, 1...40000
end
2.times { b.fire }


# 2.3.0 :013 > Employee.where(department_id: 2).explain
#  => EXPLAIN for: SELECT `employees`.* FROM `employees` WHERE `employees`.`department_id` = 2
# +----+-------------+-----------+------------+------+----------------------------------+----------------------------------+---------+-------+------+----------+-------+
# | id | select_type | table     | partitions | type | possible_keys                    | key                              | key_len | ref   | rows | filtered | Extra |
# +----+-------------+-----------+------------+------+----------------------------------+----------------------------------+---------+-------+------+----------+-------+
# |  1 | SIMPLE      | employees | NULL       | ref  | index_employees_on_department_id | index_employees_on_department_id | 5       | const |    9 |    100.0 | NULL  |
# +----+-------------+-----------+------------+------+----------------------------------+----------------------------------+---------+-------+------+----------+-------+
# 1 row in set (0.00 sec)
#
# 2.3.0 :014 > Employee.where(department_id: 2).select(:department_id).explain
#  => EXPLAIN for: SELECT `employees`.`department_id` FROM `employees` WHERE `employees`.`department_id` = 2
# +----+-------------+-----------+------------+------+----------------------------------+----------------------------------+---------+-------+------+----------+-------------+
# | id | select_type | table     | partitions | type | possible_keys                    | key                              | key_len | ref   | rows | filtered | Extra       |
# +----+-------------+-----------+------------+------+----------------------------------+----------------------------------+---------+-------+------+----------+-------------+
# |  1 | SIMPLE      | employees | NULL       | ref  | index_employees_on_department_id | index_employees_on_department_id | 5       | const |    9 |    100.0 | Using index |
# +----+-------------+-----------+------------+------+----------------------------------+----------------------------------+---------+-------+------+----------+-------------+
# 1 row in set (0.00 sec)
