class AddPaymentValueToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment_value, :decimal, precision: 8, scale: 2
  end
end
