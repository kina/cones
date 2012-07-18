class Order < ActiveRecord::Base
  attr_accessible :customer_id, :product_id, :quantity, :payment_value

  belongs_to :customer
  belongs_to :product

  before_save :process_order

  def total
    product.price * quantity
  end

  def product_name
    product.name
  end

  private
  def process_order
    return if self.payment_value == total
    self.payment_value ||= 0

    value = self.payment_value - total
    self.customer.debits.create({value: value.abs}) if value < 0
    self.customer.credits.create({value: value}) if value > 0
  end
end
