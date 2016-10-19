@db_name = "d_lock"
require './mysql_helper'

ActiveRecord::Migration.create_table :members do |t|
  t.string :name
end

ActiveRecord::Migration.create_table :medals do |t|
  t.integer :member_id, null: false
  t.string :name
end

class Member < ActiveRecord::Base
  has_many :medals
end

class Medal < ActiveRecord::Base
  belongs_to :member
end

bob = Member.create(name: :bob)
%w(10日連続寝坊 退職金をもらう 電車でくつを踏まれる).each do |name|
  bob.medals.create(name: name)
end

alice = Member.create(name: :alice)
%w(眠い だるい 紛失).each do |name|
  alice.medals.create(name: name)
end

->{

# 偶然を装ったdeadlock
Thread.new do
  member = Member.find(1)
  member.with_lock do
    member.medals.order(:id).each do |m|
      m.lock!
      sleep 2
    end
  end
end

member = Member.find(1)
member.with_lock do
  member.medals.order(id: :desc).each do |m|
    m.lock!
    sleep 1
  end
end


# 意図的なdeadlock
Thread.new do
  member = Member.find(1)
  member.with_lock do
    m1 = member.medals.first.lock!
    m1.update(name: 'a')
    m2 = member.medals.second
    m2.lock!
  end
end

member = Member.find(1)
member.with_lock do
  m2 = member.medals.second.lock!
  m2.update(name: 'b')
  sleep 1
  m1 = member.medals.first
  m1.lock!
end


# blocking
## blocking!!
Thread.new do
  Member.transaction do
    member = Member.find(1)
    member.lock!
    sleep 7
    puts 'finish bg'
  end
end
Member.transaction do
  sleep 1
  member = Member.find(1)
  puts 'doing lock!'
  member.lock!
  puts 'updating'
  member.update(name: 22)
  puts 'updated'
end

## no blocking
Thread.new do
  member = Member.find(1)
  member.lock!
  sleep 7
  puts 'finish bg'
end
sleep 1
member = Member.find(1)
puts 'doing lock!'
member.lock!
puts 'updating'
member.update(name: 22)
puts 'updated'


# 別接続で
Thread.new do
  ActiveRecord::Base.connection_pool.with_connection do
    member = Member.find(1)
    member.lock!
    sleep 3
    puts 'finish bg'
  end
end
sleep 1
member = Member.find(1)
puts 'doing lock!'
puts 'updating'
member.update(name: 22)
puts 'updated'

}

# トランザクション中でのfor uodate とnot トランザクション中でのfor uodateの違い
# http://www.ne.jp/asahi/hishidama/home/tech/oracle/lock.html
