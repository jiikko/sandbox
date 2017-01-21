require "pg"
require "active_record"

# sudo apt-get install libpq-dev
# `echo 'create database outing_performance' | psql -h 172.17.0.3 -U postgres`
@host = '172.17.0.3'

config = {
  username: :postgres,
  password: '',
  host: @host,
  adapter: "postgresql",
  database: 'outing_performance',
}

ActiveRecord::Base.establish_connection(config)
ActiveRecord::Base.logger = Logger.new(STDOUT)

unless ActiveRecord::Migration[5.0].table_exists?(:spec_times)
  ActiveRecord::Migration[5.0].create_table(:spec_times) do |t|
    t.integer :time
    t.string :spec_name
    t.date :created_at
  end
  ActiveRecord::Migration[5.0].add_index :spec_times, :time
  ActiveRecord::Migration[5.0].add_index :spec_times, :spec_name
  ActiveRecord::Migration[5.0].add_index :spec_times, :created_at
end

class SpecTimes < ActiveRecord::Base
end

unless SpecTimes.exists?
  SpecTimes.create(time: 100, spec_name: :test_queue, created_at: Time.now)
  SpecTimes.create(time: 100, spec_name: :test_queue, created_at: Time.now)
  SpecTimes.create(time: 100, spec_name: :test_queue, created_at: Time.now)
  SpecTimes.create(time: 100, spec_name: :test_queue, created_at: Time.now)
  SpecTimes.create(time: rand(100), spec_name: :model, created_at: Time.now)
  SpecTimes.create(time: rand(100), spec_name: :model, created_at: Time.now)
  SpecTimes.create(time: rand(100), spec_name: :model, created_at: Time.now)
  SpecTimes.create(time: rand(100), spec_name: :model, created_at: Time.now)
  SpecTimes.create(time: rand(100), spec_name: :model, created_at: Time.now)
end

def make_test_queue
  SpecTimes.create(time: rand(100), spec_name: :test_queue, created_at: Time.now)
end
