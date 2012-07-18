class Customer < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :orders
  has_many :credits
  has_many :debits

  def total_orders
    orders.inject(0) { |b, o| b + o.total }
  end

  def balance
    total_credits - total_debits
  end

  def total_credits
    credits.inject(0) { |b, c| b + c.value }
  end

  def total_debits
    debits.inject(0) { |b, d| b + d.value }
  end
end
