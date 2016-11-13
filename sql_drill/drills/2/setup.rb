require "mysql2"
require "active_record"
require 'date'

`echo 'drop database sql_drill' | mysql -uroot`
`echo 'create database sql_drill' | mysql -uroot`
config = {
  user: :root,
  password: "",
  :adapter   => "mysql2",
  :encoding  => "utf8",
  :reconnect => true,
  :pool      => 5,
  :database  => 'sql_drill'
}
ActiveRecord::Base.establish_connection(config)

ActiveRecord::Migration.create_table :products do |t|
  t.string :name
  t.boolean :active, default: true
end

