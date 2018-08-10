@db_name = __FILE__
require './mysql_helper'

ActiveRecord::Migration.create_table :exmaples do |t|
  t.string :name
  t.string :json_params
  t.string :string_params
  t.boolean :all_null_boolean
end

class Exmaple < ActiveRecord::Base
  serialize :json_params, JSON
end

Exmaple.create!(name: 'all blank')
Exmaple.create!(name: 'set nil',         json_params: nil,    string_params: nil)
Exmaple.create!(name: 'set string null', json_params: 'null', string_params: 'null')
# INSERT INTO `exmaples` (`json_params`, `name`) VALUES ('null', 'all blank')
# INSERT INTO `exmaples` (`json_params`, `name`) VALUES ('null', 'set nil')
# INSERT INTO `exmaples` (`json_params`, `name`, `string_params`) VALUES ('\"null\"', 'set string null', 'null')

Exmaple.all.each { |e| puts e.reload.attributes }
# {"id"=>1, "name"=>"all blank", "json_params"=>nil, "string_params"=>nil, "all_null_boolean"=>nil}
# {"id"=>2, "name"=>"set nil", "json_params"=>nil, "string_params"=>nil, "all_null_boolean"=>nil}
# {"id"=>3, "name"=>"set string null", "json_params"=>"null", "string_params"=>"null", "all_null_boolean"=>nil}


# mysql> SELECT `exmaples`.* FROM `exmaples`;
# +----+-----------------+-------------+---------------+------------------+
# | id | name            | json_params | string_params | all_null_boolean |
# +----+-----------------+-------------+---------------+------------------+
# |  1 | all blank       | null        | NULL          |            NULL |
# |  2 | set nil         | null        | NULL          |            NULL |
# |  3 | set string null | "null"      | null          |            NULL |
# +----+-----------------+-------------+---------------+-----------------+
# 3 rows in set (0.00 sec)


# NULLとnullと'null'の違い:
Exmaple.where('id = 1 AND json_params is NULL')
# Exmaple Load (0.3ms)  SELECT `exmaples`.* FROM `exmaples`  WHERE (id = 1 AND json_params is NULL)
# => #<ActiveRecord::Relation []>
Exmaple.where('id = 1 AND json_params = "NULL"')
# Exmaple Load (0.5ms)  SELECT `exmaples`.* FROM `exmaples`  WHERE (id = 1 AND json_params = "NULL")
# => #<ActiveRecord::Relation [#<Exmaple id: 1, name: "all blank", json_params: nil, string_params: nil, al_null_boolean: nil>]>
Exmaple.where('id = 1 AND all_null_boolean is NULL')
# Exmaple Load (0.4ms)  SELECT `exmaples`.* FROM `exmaples`  WHERE (id = 1 AND all_null_boolean is NULL)
# => #<ActiveRecord::Relation [#<Exmaple id: 1, name: "all blank", json_params: nil, string_params: nil, all_null_boolean: nil>]>

Exmaple.where('id = 3 AND json_params = "\"null\""')
# Exmaple Load (0.5ms)  SELECT `exmaples`.* FROM `exmaples`  WHERE (id = 3 AND json_params = "\"null\"")
# => #<ActiveRecord::Relation [#<Exmaple id: 3, name: "set string null", json_params: "null", string_params: "null", all_null_boolean: nil>]>

Exmaple.where('id = 3 AND json_params = "null"')
# Exmaple Load (0.4ms)  SELECT `exmaples`.* FROM `exmaples`  WHERE (id = 3 AND json_params = "null")
# => #<ActiveRecord::Relation []>
