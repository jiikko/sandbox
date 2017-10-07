# frozen_string_literal: true

# from https://github.com/rails/rails/blob/master/guides/bug_report_templates/active_record_master.rb

begin
  require "bundler/inline"
rescue LoadError => e
  $stderr.puts "Bundler version 1.10 or later is required. Please update your Bundler"
  raise e
end

gemfile do
  source "https://rubygems.org"
  git_source(:github) { |repo| "https://github.com/#{repo}.git" }
  gem "rails"
  gem "arel"
  gem "sqlite3"
end

require "active_record"
require "minitest/autorun"
require "logger"

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :posts, force: true do |t|
  end
end

class Post < ActiveRecord::Base
  after_commit { puts 'I am called by after_commit' }
  after_create { puts 'I am called by after_create' }
  after_create_commit { puts 'I am called by after_create_commit' }
  after_save { puts 'I am called by after_save' }
  before_create { puts 'I am called by before_create' }
  before_save { puts 'I am called by before_save' }
  before_update { puts 'I am called by before_update' }
  before_validation { puts 'I am called by before_validation' }
end

post = Post.new
puts '-----------'
puts 'when run_callbacks(:save) without block'
post.run_callbacks(:save)
puts '-----------'
puts 'when run_callbacks(:save) with block to include false'
post.run_callbacks(:save) { false }
puts '-----------'
puts 'when run_callbacks(:save) with block to include true'
post.run_callbacks(:save) { true }

puts '-----------'
puts 'when run_callbacks(:create) without block'
post.run_callbacks(:create)
puts '-----------'
puts 'when run_callbacks(:create) with block to include false'
post.run_callbacks(:create) { false }
puts '-----------'
puts 'when run_callbacks(:create) with block to include true'
post.run_callbacks(:create) { true }
puts '-----------'

# -----------
# when run_callbacks(:save) without block
# I am called by before_save
# I am called by after_save
# -----------
# when run_callbacks(:save) with block to include false
# I am called by before_save
# -----------
# when run_callbacks(:save) with block to include true
# I am called by before_save
# I am called by after_save
# -----------
# when run_callbacks(:create) without block
# I am called by before_create
# I am called by after_create
# -----------
# when run_callbacks(:create) with block to include false
# I am called by before_create
# -----------
# when run_callbacks(:create) with block to include true
# I am called by before_create
# I am called by after_create
# -----------
