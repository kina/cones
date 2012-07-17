class Order < ActiveRecord::Base
  attr_accessible :customer_id, :paid, :product_id, :quantity

  belongs_to :customer
  belongs_to :product

  def total
    product.price * quantity
  end

  def product_name
    product.name
  end
end
