@db_name = __FILE__
require './mysql_helper'

ActiveRecord::Migration.create_table :employees do |t|
  t.string :name
  t.integer :department_id
end

ActiveRecord::Migration.create_table :departments do |t|
  t.string :name
end

ActiveRecord::Migration.create_table :department_settings do |t|
  t.integer :department_id
  t.string :name
end

ActiveRecord::Migration.add_index :employees, :department_id

class Employee < ActiveRecord::Base
  belongs_to :department
end
class Department < ActiveRecord::Base;
  has_many :employees
  has_one :department_setting
  after_create :create_department_setting!
end
class DepartmentSetting < ActiveRecord::Base
  belongs_to :department
end

("a".."f").to_a.each do |x|
  Department.create!(name: x)
end

departments = Department.all
1000.times do |i|
  Employee.create!(name: i, department: departments.sample)
end

Employee.joins(department: :department_setting).to_sql
# => "SELECT `employees`.* FROM `employees` INNER JOIN `departments` ON `departments`.`id` = `employees`.`department_id` INNER JOIN `department_settings` ON `department_settings`.`department_id` = `departments`.`id`"

# department_settingsからjoinして最適化してる
# mysql> explain SELECT `employees`.* FROM `employees` INNER JOIN `departments` ON `departments`.`id` = `employees`.`department_id` INNER JOIN `department_settings` ON `department_settings`.`department_id` = `departments`.`id`\G;
# *************************** 1. row ***************************
#            id: 1
#   select_type: SIMPLE
#         table: department_settings
#    partitions: NULL
#          type: ALL
# possible_keys: NULL
#           key: NULL
#       key_len: NULL
#           ref: NULL
#          rows: 6
#      filtered: 100.00
#         Extra: Using where
# *************************** 2. row ***************************
#            id: 1
#   select_type: SIMPLE
#         table: departments
#    partitions: NULL
#          type: eq_ref
# possible_keys: PRIMARY
#           key: PRIMARY
#       key_len: 4
#           ref: optimized_join.department_settings.department_id
#          rows: 1
#      filtered: 100.00
#         Extra: Using index
# *************************** 3. row ***************************
#            id: 1
#   select_type: SIMPLE
#         table: employees
#    partitions: NULL
#          type: ref
# possible_keys: index_employees_on_department_id
#           key: index_employees_on_department_id
#       key_len: 5
#           ref: optimized_join.department_settings.department_id
#          rows: 166
#      filtered: 100.00
#         Extra: NULL
# 3 rows in set, 1 warning (0.00 sec)
