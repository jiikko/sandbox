require "mysql2"
require "active_record"
require 'sugoi_bulk_insert'

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
