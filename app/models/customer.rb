class Customer < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :orders

  def unpaid_orders
    Order.where("customer_id = ? AND paid = ?", self.id, false)
  end

  def balance_due
    unpaid_orders.inject(0) { |b, o| b + o.total }
  end
end
