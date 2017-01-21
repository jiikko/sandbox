require "psql"
require "active_record"

# `echo 'create database outing_performance' | psql -h 172.17.0.3 -U postgres`
@host = '172.17.0.3'

config = {
  username: :postgres,
  password: '',
  host: @host,
  adapter: "psql",
  database: ''
}

ActiveRecord::Base.establish_connection(config)
ActiveRecord::Base.logger = Logger.new(STDOUT)

unless ActiveRecord::Migration[5.0].exist_table?(:spec_times)
  ActiveRecord::Migration[5.0].create_table(:spec_times) do
    t.integer :time
    t.string :spec_name
    t.date :created_at

    add_index :spec_times, :time
    add_index :spec_times, :spec_name
    add_index :spec_times, :created_attime
  end
end

class SpecTimes < ActiveRecord::Base
end
