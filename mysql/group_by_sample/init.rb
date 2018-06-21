
@db_name = "d_lock"
require './mysql_helper'

ActiveRecord::Migration.create_table :checkouts do |t|
  t.timestamps
end
ActiveRecord::Migration.create_table :checkout_payments do |t|
  t.integer :checkout_id, null: false
  t.integer :payment_type, null: false
  t.integer :amount, null: false
end

class CheckoutPayment < ActiveRecord::Base
  belongs_to :checkout
end
class Checkout < ActiveRecord::Base
  has_many :checkout_payments
end

checkout = Checkout.create!(created_at: Date.new(2011, 1, 1))
checkout.checkout_payments.create(payment_type: 0, amount: 1)
checkout.checkout_payments.create(payment_type: 0, amount: 1)
checkout.checkout_payments.create(payment_type: 1, amount: 5)
checkout.checkout_payments.create(payment_type: 1, amount: 5)

checkout = Checkout.create!(created_at: Date.new(2016, 1, 1))
checkout.checkout_payments.create(payment_type: 0, amount: 1)
checkout.checkout_payments.create(payment_type: 0, amount: 1)
checkout.checkout_payments.create(payment_type: 1, amount: 5)
checkout.checkout_payments.create(payment_type: 1, amount: 5)

checkout = Checkout.create!(created_at: Date.new(2016, 1, 1))
checkout.checkout_payments.create(payment_type: 0, amount: 1)
checkout.checkout_payments.create(payment_type: 0, amount: 1)
checkout.checkout_payments.create(payment_type: 1, amount: 5)
checkout.checkout_payments.create(payment_type: 1, amount: 5)

sql2 = <<~SQL
select t.count c, t.payment_type pt from (
  select count(*), payment_type
  from checkout_payments
  group by payment_type
) t on t.payment_type = checkout_payments.payment_type
SQL

sql3 = <<~SQL
  select count(*) t_c, payment_type
  from checkout_payments
  group by payment_type
SQL

sql = <<~SQL
inner join (
  select count(*) t_c, payment_type
  from checkout_payments
  group by payment_type
  ) t on checkout_payments.payment_type = t.payment_type
SQL

CheckoutPayment.group('payment_type').select('count(*) count', 'payment_type').map(&:attributes)

CheckoutPayment.group('payment_type').select('count(*)', 'payment_type')
CheckoutPayment.distinct.joins(sql).select('t.payment_type', 't.t_c')
ActiveRecord::Base.connection.execute(sql2)
