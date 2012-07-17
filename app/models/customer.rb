class Customer < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :orders
  has_many :credits

  def unpaid_orders
    orders.unpaid
  end

  def paid_orders
    orders.paid
  end

  def total_unpaid_orders
    unpaid_orders.inject(0) { |b, o| b + o.total }
  end

  def total_paid_orders
    paid_orders.paid.inject(0) { |b, o| b + o.total }
  end

  def balance
    total_unused_credits - total_unpaid_orders
  end

  def total_credits
    credits.inject(0) { |b, c| b + c.value }
  end

  def total_unused_credits
    credits.unused.inject(0) { |b, c| b + c.value }
  end
end
