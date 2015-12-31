# be irb
# $:.unshift "./"; require "load"

require "active_record"
require "mysql2"
require 'sugoi_bulk_insert'

DB_NAME = "join_training"

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

class Employee < ActiveRecord::Base; end
class Department  < ActiveRecord::Base;
  has_many :employees
end
class Comment < ActiveRecord::Base
end
