require "mysql2"
require "active_record"
require 'sugoi_bulk_insert'

raise('invaid') unless defined?(@db_name)
@db_name.gsub!('/', '_')
@db_name.gsub!('.rb', '')

puts `echo 'drop database #{@db_name}' | mysql -uroot`
puts `echo 'create database #{@db_name}' | mysql -uroot`

config = {
  username: :root,
  password: "",
  :adapter   => "mysql2",
  :encoding  => "utf8",
  :reconnect => true,
  :pool      => 5,
  :database  => @db_name
}

ActiveRecord::Base.establish_connection(config)
ActiveRecord::Base.logger = Logger.new(STDOUT)
