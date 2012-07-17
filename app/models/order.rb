class Order < ActiveRecord::Base
  attr_accessible :customer_id, :paid, :product_id, :quantity

  belongs_to :customer
  belongs_to :product

  before_save :set_paid_at

  scope :paid,   where(paid: true)
  scope :unpaid, where(paid: false)

  def total
    product.price * quantity
  end

  def product_name
    product.name
  end

  private
  def set_paid_at
    self.paid_at = DateTime.now if self.paid?
  end
end
