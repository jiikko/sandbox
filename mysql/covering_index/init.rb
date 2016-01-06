DB_NAME = "covering_index"

require '../mysql_helper'

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
